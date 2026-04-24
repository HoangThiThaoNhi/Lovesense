const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

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

    // KEEP: Vietnamese compound words intact (No more splitting by space)
    const processedKeywords = combinedKeywords.slice(0, 15); // Limit to 15 keywords

    let interestScoreSql = '0';
    const interestReplacements = [];
    if (useInterests && processedKeywords.length > 0) {
        const interestConditions = processedKeywords.map(kw => {
            interestReplacements.push(`%${kw}%`);
            return `(CASE WHEN p.interests LIKE ? THEN 10 ELSE 0 END)`;
        }).join(' + ');
        
        let bioConditions = '0';
        if (aiKeywords.length > 0) {
            bioConditions = processedKeywords.map(kw => {
                interestReplacements.push(`%${kw}%`);
                return `(CASE WHEN p.bio LIKE ? THEN 5 ELSE 0 END)`;
            }).join(' + ');
        }
        
        interestScoreSql = `(${interestConditions}) + (${bioConditions})`;
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

    if (useInterests) {
        console.log("🤖 [Discovery] AI Mode Active: Prioritizing interest matches within user filters.");
    }

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
        SELECT p.id, p.user_id, p.display_name, p.age, p.gender, p.occupation, p.bio, p.interests, p.dna_vector, p.ai_match_keywords,
               ST_X(p.location) as lng, ST_Y(p.location) as lat,
               ROUND(ST_Distance_Sphere(p.location, POINT(?, ?)) / 1000) as distance_km,
               COALESCE(
                 (SELECT image_url FROM photos WHERE user_id = p.user_id AND is_main = 1 LIMIT 1),
                 'https://ui-avatars.com/api/?name=' || p.display_name || '&background=random'
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

    if (!rows || rows.length === 0) {
        console.log(`[Discovery] No users found for ${userId} with strict filters. Trying fallback (ignoring distance)...`);
        const fallbackSql = `
            SELECT p.id, p.user_id, p.display_name, p.age, p.gender, p.occupation, p.bio, p.interests, p.dna_vector, p.ai_match_keywords,
                   ST_X(p.location) as lng, ST_Y(p.location) as lat,
                   ROUND(ST_Distance_Sphere(p.location, POINT(?, ?)) / 1000) as distance_km,
                   COALESCE(
                     (SELECT image_url FROM photos WHERE user_id = p.user_id AND is_main = 1 LIMIT 1),
                     'https://ui-avatars.com/api/?name=' || p.display_name || '&background=random'
                   ) as main_photo
            FROM profiles p
            INNER JOIN users u ON u.id = p.user_id
            LEFT JOIN swipes s ON s.swiped_id = p.user_id AND s.swiper_id = ?
            WHERE p.user_id != ? AND u.status = 'active' AND s.id IS NULL
            AND p.age BETWEEN ? AND ?
            ${genderSql}
            ORDER BY RAND()
            LIMIT 50
        `;
        
        const fallbackReplacements = [
            userLng, userLat, 
            userId, 
            userId, 
            finalMinAge, 
            finalMaxAge,
            ...genderReplacements
        ];

        rows = await sequelize.query(fallbackSql, {
            replacements: fallbackReplacements,
            type: QueryTypes.SELECT
        });
    }

    // Extract interest weights from surveys if available
    const surveyInterests = (surveys || [])
        .filter(s => s.category === 'lifestyle' || s.category === 'values')
        .map(s => String(s.answer).toLowerCase());

    // Fetch current user's DNA for similarity comparison
    const Profile = require('./profileModel');
    const currentUserProfile = await Profile.findOne({ where: { user_id: userId }, attributes: ['dna_vector'] });
    let currentUserDNA = currentUserProfile?.dna_vector || {};
    
    if (typeof currentUserDNA === 'string') {
        try { currentUserDNA = JSON.parse(currentUserDNA); } catch (e) { currentUserDNA = {}; }
    }

    // Helper: Euclidean Distance to Similarity (0.0 to 1.0)
    const calculateDNASimilarity = (v1, v2) => {
        if (!v1 || !v2 || Object.keys(v1).length === 0 || Object.keys(v2).length === 0) return 0;
        const keys = new Set([...Object.keys(v1), ...Object.keys(v2)]);
        let sumSquaredDiff = 0;
        keys.forEach(key => {
            const v1Val = parseFloat(v1[key]) || 0;
            const v2Val = parseFloat(v2[key]) || 0;
            const d = v1Val - v2Val;
            sumSquaredDiff += d * d;
        });
        const distance = Math.sqrt(sumSquaredDiff);
        return 1 / (1 + distance);
    };

    // Process rows and calculate match_score in JS
    rows = rows.map(row => {
        // Parse DNA Vector if string
        if (typeof row.dna_vector === 'string') {
            try { row.dna_vector = JSON.parse(row.dna_vector); } catch (e) { row.dna_vector = {}; }
        }

        if (typeof row.interests === 'string') {
            try { row.interests = JSON.parse(row.interests); }
            catch (e) { row.interests = []; }
        }
        
        const rowInterests = Array.isArray(row.interests) ? row.interests : [];
        
        // Start with SQL score
        let finalScore = parseFloat(row.match_score) || 0;

        // 1. Basic Keyword Matching (Survey)
        const surveyMatchCount = rowInterests.filter(interest => 
            surveyInterests.includes(String(interest).toLowerCase())
        ).length;
        finalScore += (surveyMatchCount * 5);

        // 2. DNA Soulmate Matching
        const dnaSimilarity = calculateDNASimilarity(currentUserDNA, row.dna_vector || {});
        row.dna_similarity = dnaSimilarity;
        
        if (dnaSimilarity > 0.8) {
            finalScore += 100;
        } else if (dnaSimilarity > 0.5) {
            finalScore += (dnaSimilarity * 50);
        }

        // 3. AI-Powered Matching
        if (aiKeywords && aiKeywords.length > 0) {
            const aiMatchCount = rowInterests.filter(interest => 
                aiKeywords.some(kw => 
                    String(interest).toLowerCase().includes(kw.toLowerCase()) ||
                    kw.toLowerCase().includes(String(interest).toLowerCase())
                )
            ).length;
            
            finalScore += (aiMatchCount * 5);
        }

        const isDNAMatch = finalScore > 60 || dnaSimilarity > 0.8;
        
        return {
            ...row,
            match_score: finalScore,
            is_dna_match: isDNAMatch,
            match_reason: isDNAMatch ? "🌟 Tâm đầu ý hợp qua DNA" : (finalScore > 20 ? "✨ Có nhiều điểm tương đồng" : null)
        };
    });

    // Sort by match_score DESC
    rows.sort((a, b) => b.match_score - a.match_score);

    return rows.slice(0, 50);
};

module.exports = Swipe;
