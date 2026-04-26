const { Swipe, Profile, Match, Survey, Notification, User } = require('../models');
const GamificationService = require('../services/gamificationService');
const AIService = require('../services/aiService');

exports.getLikesReceived = async (req, res) => {
    try {
        const userId = req.user.id;
        const pendingLikes = await Swipe.getPendingLikes(userId);
        res.json(pendingLikes);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getDiscovery = async (req, res) => {
    try {
        const userId = req.user.id;
        const { lat: queryLat, lng: queryLng, minAge, maxAge, maxDistance, useInterests } = req.query;
        
        // Cập nhật vị trí người dùng nếu được gửi kèm trong query (Seamless update)
        if (queryLat && queryLng) {
            try {
                await Profile.update({
                    location: { type: 'Point', coordinates: [parseFloat(queryLng), parseFloat(queryLat)] }
                }, { where: { user_id: userId } });
                console.log(`[Discovery] Cập nhật vị trí User ${userId} từ query: (${queryLat}, ${queryLng})`);
            } catch (updateError) {
                console.error('[Discovery Location Update Error]:', updateError);
            }
        }

        const profile = await Profile.findByUserId(userId);
        
        if (!profile) {
            return res.status(404).json({ error: 'Profile not found' });
        }

        // Get user surveys for match score calculation
        const surveys = await Survey.findAll({ where: { user_id: userId } });
        
        // Extract filters from query
        // Map looking_for from profile to backend gender values
        let lookingFor = null;
        if (profile.looking_for) {
            const lf = profile.looking_for.toLowerCase();
            // If user wants both, we don't apply gender filter
            if ((lf.includes('nam') && lf.includes('nữ')) || lf.includes('tất cả')) {
                lookingFor = null;
            } else if (lf.includes('nam')) {
                lookingFor = 'male';
            } else if (lf.includes('nữ')) {
                lookingFor = 'female';
            }
        }

        const discoveryFilters = {
            minAge: parseInt(minAge) || 18,
            maxAge: parseInt(maxAge) || 100,
            maxDistance: parseInt(maxDistance) || 20000,
            ignoreDNA: req.query.ignoreDNA === 'true',
            useInterests: (useInterests === 'true') || (profile.ai_match_keywords && profile.ai_match_keywords.length > 0), 
            userInterests: profile.interests || [],
            lookingFor: lookingFor,
            aiKeywords: profile.ai_match_keywords || []
        };

        // Ưu tiên tọa độ từ query, sau đó đến profile
        let lat = parseFloat(queryLat) || profile.lat;
        let lng = parseFloat(queryLng) || profile.lng;

        console.log(`[Discovery] User ${userId} at (${lat}, ${lng}) with filters:`, discoveryFilters);

        const list = await Swipe.getDiscoveryList(userId, lat, lng, surveys, discoveryFilters);
        console.log(`[Discovery] Found ${list.length} users`);
        res.json(list);
    } catch (error) {
        console.error('[Discovery Error]:', error);
        res.status(500).json({ error: error.message });
    }
};

exports.saveSurvey = async (req, res) => {
    try {
        const userId = req.user.id;
        const { answers } = req.body; // Array of { question_id, category, answer }

        for (const item of answers) {
            await Survey.upsert({
                user_id: userId,
                question_id: item.question_id,
                category: item.category,
                answer: item.answer,
                weight: 1
            });
        }

        // award points for completing surveys (Fixed 40 XP as per rule)
        const totalPoints = 40;
        let gamification = null;
        try {
            gamification = await GamificationService.awardPoints(userId, totalPoints, 'Hoàn thành bài tư vấn chatbot AI 📝');
            console.log(`[Survey] Awarded ${totalPoints} XP to user ${userId}`);
        } catch (pointsError) {
            console.error('[Survey Points Error]:', pointsError);
        }

        // NEW: Generate AI Ideal Partner Profile & DNA Scores
        let aiAnalysis = null;
        try {
            // 1. Generate Qualitative Analysis (AI)
            aiAnalysis = await AIService.generateIdealPartnerProfile(answers);
            console.log(`[Survey] AI Analysis Result for user ${userId}:`, JSON.stringify(aiAnalysis, null, 2));
            
            if (aiAnalysis) {
                await Profile.update({
                    ai_ideal_description: aiAnalysis.description,
                    ai_match_keywords: aiAnalysis.target_tags || []
                }, { where: { user_id: userId } });
                console.log(`[Survey] AI Analysis saved to Profile for user ${userId}`);
            }

            // 2. Generate Quantitative DNA Scores (Algorithmic + AI)
            const dnaScores = AIService.calculateDNAProfile(answers, aiAnalysis?.preference_vector);
            await User.update(dnaScores, { where: { id: userId } });
            console.log(`[Survey] DNA Scores saved to User table for user ${userId}`);

        } catch (aiError) {
            console.error('[AI Survey Analysis Error]:', aiError);
        }

        res.json({ 
            message: 'Survey saved successfully',
            gamification: gamification,
            ai_analysis: aiAnalysis,
            points_added: totalPoints // Add a direct field as backup
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.swipe = async (req, res) => {
    try {
        const { swipedId, type } = req.body; 
        const swiperId = req.user.id;

        await Swipe.create({ swiper_id: swiperId, swiped_id: swipedId, type });

        // Update AI Preferences based on swipe behavior
        _updateAIPreferences(swiperId, swipedId, type);

        let isMatch = false;
        if (type === 'like' || type === 'superlike') {
            const { Op } = require('sequelize');
            const targetId = parseInt(swipedId);

            // 1. Check if ANY match record already exists between these two users
            const existingMatch = await Match.findOne({
                where: {
                    [Op.or]: [
                        { user1_id: targetId, user2_id: swiperId },
                        { user1_id: swiperId, user2_id: targetId }
                    ]
                }
            });

            if (existingMatch) {
                // If it's already accepted, it's already a match
                if (existingMatch.status === 'accepted') {
                    isMatch = true;
                } 
                // If the OTHER person liked us (we are user2), then it's now a match completion
                else if (existingMatch.user2_id === swiperId && existingMatch.status === 'pending') {
                    isMatch = true;
                    await existingMatch.update({ status: 'accepted' });

                    // Notification for both parties
                    const swiper = await Profile.findOne({ where: { user_id: swiperId } });
                    const swiped = await Profile.findOne({ where: { user_id: targetId } });

                    await Notification.create({
                        user_id: targetId,
                        type: 'match',
                        title: 'Tương hợp mới! ❤️',
                        content: `Chúc mừng! Bạn vừa có một tương hợp mới với ${swiper?.display_name || 'ai đó'}.`,
                        metadata: { swiper_id: swiperId }
                    });

                    await Notification.create({
                        user_id: swiperId,
                        type: 'match',
                        title: 'Tương hợp mới! ❤️',
                        content: `Chúc mừng! Bạn vừa tương hợp với ${swiped?.display_name || 'ai đó'}. Hãy bắt chuyện ngay!`,
                        metadata: { swiped_id: targetId }
                    });
                }
                // If WE already liked THEM (we are user1), it stays pending but we return isMatch=false
            } else {
                // 2. No match record exists, create a new pending match
                await Match.create({ 
                    user1_id: swiperId, 
                    user2_id: targetId, 
                    status: 'pending' 
                });
                
                // NEW: Rule - Show match dialog (isMatch: true) for every Like/SuperLike
                isMatch = true;

                // Notify the swiped user about the new chat request
                const swiper = await Profile.findOne({ where: { user_id: swiperId } });
                await Notification.create({
                    user_id: targetId,
                    type: 'match',
                    title: 'Lời mời kết nối mới! 💬',
                    content: `${swiper?.display_name || 'Ai đó'} muốn trò chuyện với bạn.`,
                    metadata: { swiper_id: swiperId }
                });
            }

            // Award points for receiving a Super Like
            if (type === 'superlike') {
                await GamificationService.awardPoints(swipedId, 50, 'Được người khác Super Like ⭐');
            }
        }

        res.json({ message: 'Swipe recorded', isMatch });
    } catch (error) {
        if (error.name === 'SequelizeUniqueConstraintError') {
            return res.status(400).json({ error: 'You have already swiped this user' });
        }
        res.status(500).json({ error: error.message });
    }
};

exports.resetSwipes = async (req, res) => {
    try {
        const userId = req.user.id;
        // Xóa tất cả lượt quẹt của người dùng này để bắt đầu lại (Dành cho demo/test)
        await Swipe.destroy({ where: { swiper_id: userId } });
        
        // Thưởng 1 ít điểm cho việc "làm mới bản thân"
        const gamification = await GamificationService.awardPoints(userId, 10, 'Làm mới danh sách khám phá ✨');

        res.json({ 
            message: 'Discovery list reset successfully',
            gamification
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

/**
 * Helper to update AI preferences based on swipe behavior
 */
async function _updateAIPreferences(swiperId, swipedId, type) {
    try {
        const swiperProfile = await Profile.findOne({ where: { user_id: swiperId } });
        const swipedProfile = await Profile.findOne({ where: { user_id: swipedId } });
        
        if (!swiperProfile || !swipedProfile) return;

        let prefs = swiperProfile.ai_preferences || {};
        // Normalize if it's a string (though Sequelize JSON should handle it)
        if (typeof prefs === 'string') {
            try { prefs = JSON.parse(prefs); } catch(e) { prefs = {}; }
        }

        // Keywords to track: occupation, interests, bio-vibe, effort, height, and purpose
        const keywords = [];
        if (swipedProfile.occupation) {
            keywords.push(swipedProfile.occupation.toLowerCase().trim());
        }
        
        // Track Purpose
        if (swipedProfile.purpose) {
            keywords.push(`mục-đích-${swipedProfile.purpose.toLowerCase().trim().replace(/\s+/g, '-')}`);
        }

        // Track Height preference (categorized)
        if (swipedProfile.height) {
            if (swipedProfile.height >= 175) keywords.push('gu-người-cao');
            else if (swipedProfile.height <= 160) keywords.push('gu-nhỏ-nhắn');
        }

        // Analyze profile effort (bio length as proxy)
        const bioLength = (swipedProfile.bio || '').length;
        if (bioLength > 150) keywords.push('hồ-sơ-chi-tiết');
        else if (bioLength < 30) keywords.push('bí-ẩn-ít-nói');

        // Extract style keywords from bio (simple heuristic)
        const bio = (swipedProfile.bio || '').toLowerCase();
        if (bio.includes('haha') || bio.includes('hihi') || bio.includes('vui')) keywords.push('phong-cách-hài-hước');
        if (bio.includes('tìm') || bio.includes('muốn') || bio.includes('nghiêm túc')) keywords.push('nghiêm-túc');
        if (bio.includes('chill') || bio.includes('nhẹ nhàng')) keywords.push('chill-vibe');

        if (swipedProfile.interests) {
            let interests = [];
            try {
                interests = Array.isArray(swipedProfile.interests) 
                    ? swipedProfile.interests 
                    : JSON.parse(swipedProfile.interests || '[]');
            } catch (e) { interests = []; }
            
            interests.forEach(i => {
                if (typeof i === 'string') keywords.push(i.toLowerCase().trim());
            });
        }

        const multiplier = (type === 'like' || type === 'superlike') ? 1 : -0.5;
        const weightBase = (type === 'superlike') ? 2 : 1;

        // Apply weights
        keywords.forEach(kw => {
            if (!kw || kw.length < 2) return;
            prefs[kw] = (prefs[kw] || 0) + (weightBase * multiplier);
            
            // Safety caps
            if (prefs[kw] > 50) prefs[kw] = 50;
            if (prefs[kw] < -20) prefs[kw] = -20;
        });

        // Save updated preferences
        await swiperProfile.update({ ai_preferences: prefs });
        console.log(`[AI Prefs] Updated keywords for user ${swiperId}: ${keywords.join(', ')} (Action: ${type})`);

        // DEEP LEARNING: Every 5 Likes, trigger a deep taste analysis using Gemini
        if (type === 'like' || type === 'superlike') {
            const likesCount = await Swipe.count({ 
                where: { 
                    swiper_id: swiperId, 
                    type: { [require('sequelize').Op.in]: ['like', 'superlike'] } 
                } 
            });

            if (likesCount > 0 && likesCount % 5 === 0) {
                console.log(`[AI Prefs] Triggering Deep Taste Analysis for user ${swiperId} (Likes: ${likesCount})`);
                
                // Get last 10 liked profiles
                const lastLikes = await Swipe.findAll({
                    where: { swiper_id: swiperId, type: { [require('sequelize').Op.in]: ['like', 'superlike'] } },
                    order: [['created_at', 'DESC']],
                    limit: 10
                });

                const swipedIds = lastLikes.map(l => l.swiped_id);
                const likedProfiles = await Profile.findAll({ where: { user_id: swipedIds } });

                if (likedProfiles.length >= 3) {
                    const analysis = await AIService.analyzeUserTaste(likedProfiles);
                    if (analysis && analysis.learned_tags) {
                        // Merge new learned tags with existing DNA keywords
                        let currentKeywords = swiperProfile.ai_match_keywords || [];
                        const updatedKeywords = [...new Set([...currentKeywords, ...analysis.learned_tags])].slice(0, 20);
                        
                        await swiperProfile.update({ 
                            ai_match_keywords: updatedKeywords,
                            ai_ideal_description: analysis.analysis // Update the AI's understanding description
                        });
                        console.log(`[AI Prefs] Deep Learning Success for ${swiperId}. New Tags: ${analysis.learned_tags.join(', ')}`);
                    }
                }
            }
        }

    } catch (e) {
        console.error('[AI Prefs Update Error]:', e);
    }
}
