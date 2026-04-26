const { DataTypes, Op, Sequelize } = require('sequelize');
const sequelize = require('../config/db');
const Profile = require('./profileModel');
const User = require('./userModel');

const Swipe = sequelize.define('Swipe', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    swiper_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    swiped_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    type: {
        type: DataTypes.ENUM('like', 'nope', 'superlike'),
        allowNull: false
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {
    tableName: 'swipes',
    indexes: [
        {
            unique: true,
            fields: ['swiper_id', 'swiped_id']
        }
    ]
});

// Dùng sequelize.query cho spatial SQL phức tạp - đây là cách chuẩn của Sequelize
Swipe.getDiscoveryList = async function (userId, userLat, userLng, surveys = [], filters = {}) {
    const { QueryTypes } = require('sequelize');
    const { 
        minAge = 0, 
        maxAge = 100,
        maxDistance = 20000, 
        useInterests = false, 
        userInterests = [],
        lookingFor = null,
        aiKeywords = []
    } = filters;

    // Add AI keywords to interest matching if useInterests is enabled
    let combinedKeywords = [...userInterests];
    if (useInterests && aiKeywords && aiKeywords.length > 0) {
        combinedKeywords = [...new Set([...combinedKeywords, ...aiKeywords])];
    }

    const processedKeywords = combinedKeywords.slice(0, 15);

    let interestScoreSql = '0';
    const interestReplacements = [];
    if (useInterests && processedKeywords.length > 0) {
        const keywordConditions = processedKeywords.map(kw => {
            interestReplacements.push(`%${kw}%`);
            return `(CASE WHEN p.interests LIKE ? THEN 10 ELSE 0 END)`;
        });

        const bioConditions = processedKeywords.map(kw => {
            interestReplacements.push(`%${kw}%`);
            return `(CASE WHEN p.bio LIKE ? THEN 5 ELSE 0 END)`;
        });

        // Search in ai_match_keywords JSON column
        const aiKeywordConditions = processedKeywords.map(kw => {
            interestReplacements.push(`%${kw}%`);
            return `(CASE WHEN p.ai_match_keywords LIKE ? THEN 15 ELSE 0 END)`;
        });
        
        interestScoreSql = `(${keywordConditions.join(' + ')}) + (${bioConditions.join(' + ')}) + (${aiKeywordConditions.join(' + ')})`;
    }

    let genderSql = '';
    const genderReplacements = [];
    if (lookingFor) {
        genderSql = ` AND p.gender = ?`;
        genderReplacements.push(lookingFor);
    }

    let finalMinAge = parseInt(minAge);
    let finalMaxAge = parseInt(maxAge);
    let finalMaxDistance = parseInt(maxDistance);

    const distanceCondition = finalMaxDistance >= 20000 
        ? "1=1" 
        : "(ST_Distance_Sphere(p.location, POINT(?, ?)) / 1000) <= ?";
    
    const distanceReplacements = [];
    if (finalMaxDistance < 20000) {
        distanceReplacements.push(userLng, userLat, finalMaxDistance);
    }

    const replacements = [
        userLng, userLat,        // 1 & 2
        ...interestReplacements, // 3+
        userId,                  // swiper_id
        userId,                  // p.user_id !=
        finalMinAge,        
        finalMaxAge,        
        ...genderReplacements,   
        ...distanceReplacements  
    ];

    const sql = `
        SELECT p.id, p.user_id, COALESCE(u.full_name, p.display_name) as display_name, p.age, p.gender, p.occupation, p.bio, p.interests, p.ai_match_keywords,
               u.ambition_score, u.personality_score, u.career_score, u.core_values_score, u.interests_score, u.lifestyle_score, u.family_orientation_score,
               ST_X(p.location) as lng, ST_Y(p.location) as lat,
               ROUND(ST_Distance_Sphere(p.location, POINT(?, ?)) / 1000) as distance_km,
               COALESCE(
                 u.avatar_url,
                 (SELECT image_url FROM photos WHERE user_id = p.user_id AND is_main = 1 LIMIT 1),
                 'https://ui-avatars.com/api/?name=' || COALESCE(u.full_name, p.display_name) || '&background=random'
               ) as main_photo,
               ((${interestScoreSql}) + (CASE WHEN p.ai_match_keywords IS NOT NULL THEN 20 ELSE 0 END)) as match_score
        FROM profiles p
        INNER JOIN users u ON u.id = p.user_id
        LEFT JOIN swipes s ON s.swiped_id = p.user_id AND s.swiper_id = ?
        WHERE p.user_id != ? AND u.status = 'active' AND s.id IS NULL
        AND p.age BETWEEN ? AND ?
        ${genderSql}
        AND ${distanceCondition}
        ORDER BY match_score DESC, distance_km ASC
        LIMIT 50
    `;

    let rows = await sequelize.query(sql, {
        replacements,
        type: QueryTypes.SELECT
    });

    // FALLBACK: If no users found matching filters, relax filters and fetch any available users
    if (rows.length === 0) {
        console.log(`[Discovery] No users found with strict filters for user ${userId}. Relaxing filters...`);
        const fallbackSql = `
            SELECT p.id, p.user_id, COALESCE(u.full_name, p.display_name) as display_name, p.age, p.gender, p.occupation, p.bio, p.interests, p.ai_match_keywords,
                   u.ambition_score, u.personality_score, u.career_score, u.core_values_score, u.interests_score, u.lifestyle_score, u.family_orientation_score,
                   ST_X(p.location) as lng, ST_Y(p.location) as lat,
                   ROUND(ST_Distance_Sphere(p.location, POINT(?, ?)) / 1000) as distance_km,
                   COALESCE(
                     u.avatar_url,
                     (SELECT image_url FROM photos WHERE user_id = p.user_id AND is_main = 1 LIMIT 1),
                     'https://ui-avatars.com/api/?name=' || COALESCE(u.full_name, p.display_name) || '&background=random'
                   ) as main_photo,
                   0 as match_score
            FROM profiles p
            INNER JOIN users u ON u.id = p.user_id
            LEFT JOIN swipes s ON s.swiped_id = p.user_id AND s.swiper_id = ?
            WHERE p.user_id != ? AND u.status = 'active' AND s.id IS NULL
            ${genderSql}
            ORDER BY RAND()
            LIMIT 15
        `;
        rows = await sequelize.query(fallbackSql, {
            replacements: [userLng, userLat, userId, userId, ...genderReplacements],
            type: QueryTypes.SELECT
        });
        console.log(`[Discovery] Fallback query returned ${rows.length} random users`);
    }

    // Similarity calculation based on 7 score columns
    const calculateDNASimilarity = (u1, u2) => {
        const scores = [
            'ambition_score', 'personality_score', 'career_score', 
            'core_values_score', 'interests_score', 'lifestyle_score', 
            'family_orientation_score'
        ];
        
        let sumSquaredDiff = 0;
        let count = 0;
        
        scores.forEach(key => {
            const v1 = parseFloat(u1[key]) || 0;
            const v2 = parseFloat(u2[key]) || 0;
            // Only compare if at least one has a non-zero score
            if (v1 !== 0 || v2 !== 0) {
                const d = v1 - v2;
                sumSquaredDiff += d * d;
                count++;
            }
        });
        
        if (count === 0) return 0;
        
        // Maximum possible distance in 7D space with 0-100 scale is sqrt(7 * 100^2) ≈ 264.5
        const maxDistance = Math.sqrt(count * 10000);
        const distance = Math.sqrt(sumSquaredDiff);
        
        // Similarity score from 0.0 to 1.0 (1.0 is perfect)
        const similarity = 1 - (distance / maxDistance);
        return Math.max(0, similarity);
    };

    // Fetch swiper data (DNA scores and AI Preferences)
    const swiper = await Profile.findOne({ 
        where: { user_id: userId },
        include: [{ model: User, as: 'user' }]
    });
    
    if (rows && rows.length > 0 && swiper) {
        // Prepare AI preference weights for fast lookup
        let aiPrefs = swiper.ai_preferences || {};
        if (typeof aiPrefs === 'string') {
            try { aiPrefs = JSON.parse(aiPrefs); } catch(e) { aiPrefs = {}; }
        }

        const ignoreDNA = filters.ignoreDNA === true || filters.ignoreDNA === 'true';

        rows = rows.map(row => {
            // 1. DNA Similarity (Quantitative) - Set to 0 if ignoring DNA
            const similarity = ignoreDNA ? 0 : calculateDNASimilarity(swiper.user || {}, row);
            
            // 2. AI Preference Score (Learned from swiping behavior)
            let aiFeedbackScore = 0;
            try {
                const targetKeywords = [];
                if (row.occupation) targetKeywords.push(row.occupation.toLowerCase().trim());
                
                let interests = [];
                try {
                    interests = Array.isArray(row.interests) ? row.interests : JSON.parse(row.interests || '[]');
                } catch(e) {}
                interests.forEach(i => {
                    if (typeof i === 'string') targetKeywords.push(i.toLowerCase().trim());
                });

                // Calculate cumulative weight from learned preferences
                targetKeywords.forEach(kw => {
                    if (aiPrefs[kw]) {
                        aiFeedbackScore += aiPrefs[kw];
                    }
                });
            } catch (e) {
                console.error('[AI Feedback Calculation Error]:', e);
            }

            let finalScore = parseFloat(row.match_score) || 0;
            
            // Apply DNA Bonus - INCREASED WEIGHT to make changes visible
            if (similarity > 0.9) {
                finalScore += 500; // DNA Soulmate bonus (HUGE BOOST)
            } else if (similarity > 0.8) {
                finalScore += 300;
            } else if (similarity > 0.7) {
                finalScore += 200;
            } else if (similarity > 0.5) {
                finalScore += 100;
            }
            
            // Add a small randomized factor to prevent "Stale" results if scores are tied
            finalScore += (Math.random() * 5); 

            // Apply AI Feedback Bonus (Scaling preference score to avoid overshadowing everything)
            const clippedFeedbackScore = Math.min(Math.max(aiFeedbackScore, -50), 150);
            finalScore += clippedFeedbackScore;

            const isDNAMatch = similarity >= 0.9;
            row.dna_similarity = similarity;
            row.ai_feedback_score = aiFeedbackScore;
            row.is_dna_match = similarity > 0.9;
            row.match_reason = similarity > 0.75 ? '✨ Tâm đầu ý hợp qua DNA' : null;
            row.match_score = finalScore;
            
            return row;
        });
        
        rows.sort((a, b) => b.match_score - a.match_score);
    }

    return rows;
};

Swipe.getPendingLikes = async function (userId) {
    const { QueryTypes } = require('sequelize');
    const sql = `
        SELECT p.id, p.user_id, COALESCE(u.full_name, p.display_name) as display_name, p.age, p.gender, p.occupation, p.bio,
               COALESCE(
                 u.avatar_url,
                 (SELECT image_url FROM photos WHERE user_id = p.user_id AND is_main = 1 LIMIT 1),
                 'https://ui-avatars.com/api/?name=' || COALESCE(u.full_name, p.display_name) || '&background=random'
               ) as main_photo,
               s.type as swipe_type, s.created_at as liked_at
        FROM swipes s
        INNER JOIN profiles p ON p.user_id = s.swiper_id
        INNER JOIN users u ON u.id = p.user_id
        LEFT JOIN swipes s2 ON s2.swiper_id = ? AND s2.swiped_id = s.swiper_id
        WHERE s.swiped_id = ? AND s.type IN ('like', 'superlike')
        AND s2.id IS NULL
        ORDER BY s.created_at DESC
    `;

    return await sequelize.query(sql, {
        replacements: [userId, userId],
        type: QueryTypes.SELECT
    });
};

module.exports = Swipe;
