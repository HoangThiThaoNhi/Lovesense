const { Swipe, Profile, Match, Survey, Notification, User } = require('../models');
const GamificationService = require('../services/gamificationService');
const AIService = require('../services/aiService');

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
            useInterests: (useInterests === 'true') || (profile.ai_match_keywords && profile.ai_match_keywords.length > 0), // Tự động bật nếu có DNA
            userInterests: profile.interests || [],
            lookingFor: lookingFor,
            aiKeywords: profile.ai_match_keywords || []
        };

        // Ưu tiên tọa độ từ query, sau đó đến profile, cuối cùng là HCM default
        let lat = parseFloat(queryLat) || profile.lat || 10.762622;
        let lng = parseFloat(queryLng) || profile.lng || 106.660172;

        // Mock emulator to Hanoi for realistic distance testing (Chỉ mock nếu là tọa độ mặc định của Google Emulator)
        if (Math.abs(lat - 37.4219983) < 0.01 && Math.abs(lng - (-122.084)) < 0.01) {
            lat = 21.0285;
            lng = 105.8542;
        }

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
