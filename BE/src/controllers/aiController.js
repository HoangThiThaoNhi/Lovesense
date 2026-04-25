const aiService = require('../services/aiService');
const gamificationService = require('../services/gamificationService');
const { User, Profile, Photo, Question, AIChat, AISession } = require('../models');

exports.interview = async (req, res) => {
    try {
        const { history, lastResponse, session_id } = req.body;
        
        let currentSessionId = session_id;
        
        // If no session_id provided, find the latest active interview session or create one
        if (!currentSessionId) {
            const latestSession = await AISession.findOne({
                where: { user_id: req.user.id, type: 'interview' },
                order: [['created_at', 'DESC']]
            });
            
            if (latestSession) {
                currentSessionId = latestSession.id;
            } else {
                const newSession = await AISession.create({
                    user_id: req.user.id,
                    type: 'interview',
                    title: 'Bắt đầu phỏng vấn'
                });
                currentSessionId = newSession.id;
            }
        }
        
        // 1. Filter history to ensure it's compatible with Gemini startChat
        // Gemini expects alternating roles, and chat.sendMessage adds a 'user' message.
        // So history should ideally end with a 'model' message or be empty.
        const cleanHistory = (history || []).filter(msg => msg.role !== 'system');
        if (cleanHistory.length > 0 && cleanHistory[cleanHistory.length - 1].role === 'user') {
            cleanHistory.pop(); // Remove the last user message if it's already there
        }

        const prompt = lastResponse || "Chào bạn, hãy bắt đầu buổi phỏng vấn tìm hiểu về gu người yêu của tôi nhé!";
        const aiResponse = await aiService.generateResponse(prompt, cleanHistory);
        
        // 2. Try to parse profile data from current history to see if we can "complete" it
        const parsedProfile = await aiService.parseProfileFromChat([...history, { role: 'user', content: lastResponse }]);
        
        // 3. If interview is complete, get initial recommendations
        let recommendations = [];
        const isComplete = !!(parsedProfile && parsedProfile.display_name && parsedProfile.age);
        
        if (isComplete) {
            const allUsers = await User.findAll({
                include: [{ model: Profile, as: 'profile' }],
                where: { id: { [require('sequelize').Op.ne]: req.user.id } },
                limit: 20
            });

            const candidates = allUsers.map(u => ({
                id: u.id,
                name: u.profile?.display_name || 'Người dùng LoveSense',
                age: u.profile?.age,
                interests: u.profile?.interests
            }));

            const recommendedIds = await aiService.getMatchRecommendations(parsedProfile, candidates);
            recommendations = await User.findAll({
                where: { id: recommendedIds },
                include: [
                    { model: Profile, as: 'profile' },
                    { model: Photo, as: 'photos' }
                ]
            });

            // award points for profile completion
            await gamificationService.awardPoints(req.user.id, 100, 'Hoàn thành phỏng vấn hồ sơ');
        }

        // 4. Update session title if it's the first message
        if (lastResponse) {
            const session = await AISession.findByPk(currentSessionId);
            if (session && (session.title === 'Bắt đầu phỏng vấn' || session.title === 'Cuộc trò chuyện mới')) {
                const summary = lastResponse.length > 40 ? lastResponse.substring(0, 37) + '...' : lastResponse;
                await session.update({ title: summary });
            }
        }

        // 5. Save history to database
        if (lastResponse) {
            await AIChat.create({
                user_id: req.user.id,
                session_id: currentSessionId,
                role: 'user',
                content: lastResponse,
                type: 'interview'
            });
        }
        await AIChat.create({
            user_id: req.user.id,
            session_id: currentSessionId,
            role: 'assistant',
            content: aiResponse,
            type: 'interview'
        });

        // award points for each interview message to encourage interaction
        const gamification = await gamificationService.awardPoints(req.user.id, 10, 'Trò chuyện cùng AI Hunter 🤖');

        res.json({
            message: aiResponse,
            parsedProfile: parsedProfile,
            isComplete: isComplete,
            recommendations: recommendations,
            session_id: currentSessionId,
            gamification
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.consult = async (req, res) => {
    try {
        const { history, message, session_id } = req.body;
        
        let currentSessionId = session_id;
        
        // If no session_id, find latest consult session or create new
        if (!currentSessionId) {
            const latestSession = await AISession.findOne({
                where: { user_id: req.user.id, type: 'consult' },
                order: [['created_at', 'DESC']]
            });
            
            if (latestSession) {
                currentSessionId = latestSession.id;
            } else {
                const newSession = await AISession.create({
                    user_id: req.user.id,
                    type: 'consult',
                    title: message.substring(0, 50) || 'Cuộc trò chuyện mới'
                });
                currentSessionId = newSession.id;
            }
        }
        
        const prompt = `Bạn là một trợ lý tư vấn tình cảm chuyên nghiệp của LoveSense. Người dùng hỏi: "${message}". Hãy trả lời một cách thông minh, hóm hỉnh và chân thành. Nếu người dùng đang mô tả gu người yêu hoặc nhờ tìm người, hãy hứa sẽ tìm cho họ nhé.`;
        
        // Filter history for Gemini compatibility
        const cleanHistory = (history || []).filter(msg => msg.role !== 'system');
        if (cleanHistory.length > 0 && cleanHistory[cleanHistory.length - 1].role === 'user') {
            cleanHistory.pop();
        }

        console.log(`[AI Consult] Sending prompt for session ${currentSessionId}`);
        const aiResponse = await aiService.generateResponse(prompt, cleanHistory);

        // Intent detection: Does the user want to see matches?
        const intentPrompt = `Dựa trên tin nhắn mới nhất: "${message}" và lịch sử: ${JSON.stringify(history)}. 
        Người dùng có đang yêu cầu tìm người, gợi ý đối tượng, hoặc mô tả người họ muốn gặp không? 
        Hãy trả lời bằng JSON: {"wantsMatches": true/false}`;
        
        let recommendations = [];
        try {
            const intentText = await aiService.generateResponse(intentPrompt, []);
            console.log("Intent check response:", intentText);
            
            // Flexibly parse JSON from AI response
            const jsonMatch = intentText.match(/\{.*?\}/s);
            const intent = jsonMatch ? JSON.parse(jsonMatch[0]) : { wantsMatches: false };
            
            if (intent.wantsMatches || message.toLowerCase().includes("tìm") || message.toLowerCase().includes("gợi ý")) {
                console.log("Match intent detected, fetching candidates...");
                // Fetch more candidates to increase matching success
                const allUsers = await User.findAll({
                    include: [{ model: Profile, as: 'profile' }],
                    where: { id: { [require('sequelize').Op.ne]: req.user.id } },
                    limit: 50
                });

                const candidates = allUsers.map(u => ({
                    id: u.id,
                    name: u.profile?.display_name || 'Người dùng LoveSense',
                    age: u.profile?.age,
                    bio: u.profile?.bio,
                    interests: u.profile?.interests
                }));

                // Get AI recommendations
                const userQuery = { query: message, history: history };
                const recommendedIds = await aiService.getMatchRecommendations(userQuery, candidates);
                console.log("AI recommended IDs:", recommendedIds);
                
                if (recommendedIds && recommendedIds.length > 0) {
                    recommendations = await User.findAll({
                        where: { id: recommendedIds },
                        include: [
                            { model: Profile, as: 'profile' },
                            { model: Photo, as: 'photos' }
                        ]
                    });
                }
            }
        } catch (e) {
            console.error("Intent/Recommendation Error:", e);
        }

        // Update session title if it's the first message and has a default title
        const session = await AISession.findByPk(currentSessionId);
        if (session && (session.title === 'Cuộc trò chuyện mới' || session.title === 'Bắt đầu phỏng vấn')) {
            const summary = message.length > 40 ? message.substring(0, 37) + '...' : message;
            await session.update({ title: summary });
        }

        // save to DB
        await AIChat.create({
            user_id: req.user.id,
            session_id: currentSessionId,
            role: 'user',
            content: message,
            type: 'consult'
        });
        await AIChat.create({
            user_id: req.user.id,
            session_id: currentSessionId,
            role: 'assistant',
            content: aiResponse,
            type: 'consult'
        });

        // award points for using AI consultant
        const gamification = await gamificationService.awardPoints(req.user.id, 10, 'Sử dụng trợ lý tư vấn');

        res.json({ 
            message: aiResponse,
            recommendations: recommendations,
            session_id: currentSessionId,
            gamification
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getRecommendations = async (req, res) => {
    try {
        const { userProfile, history } = req.body; // userProfile could be from interview or current user
        
        // 1. Fetch other active users (excluding current)
        const allUsers = await User.findAll({
            include: [{ model: Profile, as: 'profile' }],
            where: {
                id: { [require('sequelize').Op.ne]: req.user.id }
            },
            limit: 20 // Let's limit for the AI to handle easily
        });

        // 2. Format users for AI
        const candidates = allUsers.map(u => ({
            id: u.id,
            name: u.profile?.display_name || 'Người dùng LoveSense',
            age: u.profile?.age,
            bio: u.profile?.bio,
            interests: u.profile?.interests
        }));

        // 3. Get AI IDs
        const recommendedIds = await aiService.getMatchRecommendations(userProfile, candidates);
        
        // 4. Fetch full details of recommended users
        const matches = await User.findAll({
            where: { id: recommendedIds },
            include: [
                { model: Profile, as: 'profile' },
                { model: Photo, as: 'photos' }
            ]
        });

        res.json({ recommendations: matches });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getQuestions = async (req, res) => {
    try {
        const questions = await Question.findAll({
            where: { status: 'active' },
            order: [['category', 'ASC'], ['created_at', 'ASC']]
        });

        // Parse options (could be JSON array string or semicolon-separated string)
        const formattedQuestions = questions.map(q => {
            let options = [];
            if (q.options) {
                try {
                    // 1. Try parsing check if it's a JSON array
                    const parsed = typeof q.options === 'string' ? JSON.parse(q.options) : q.options;
                    options = Array.isArray(parsed) ? parsed : [parsed];
                } catch (e) {
                    // 2. If not JSON, split by semicolon (Admin format)
                    options = q.options.split(';').map(opt => opt.trim()).filter(opt => opt !== '');
                }
            }
            return {
                id: q.id,
                question: q.text,
                options: options,
                category: q.category,
                type: q.type
            };
        });

        res.json(formattedQuestions);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getChatHistory = async (req, res) => {
    try {
        const { type, session_id } = req.params; // 'interview' or 'consult'
        
        const whereClause = { 
            user_id: req.user.id,
            type: type
        };
        
        if (session_id && session_id !== 'latest') {
            whereClause.session_id = session_id;
        }
        
        const history = await AIChat.findAll({
            where: whereClause,
            order: [['created_at', 'ASC']]
        });
        
        // Map to match the 'history' format expected by AI service
        const formattedHistory = history.map(h => ({
            role: h.role,
            content: h.content,
            recommendations: h.role === 'assistant' ? [] : null // Placeholder if needed
        }));

        res.json(formattedHistory);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getSessions = async (req, res) => {
    try {
        const { type } = req.params;
        const sessions = await AISession.findAll({
            where: { 
                user_id: req.user.id,
                type: type
            },
            order: [['created_at', 'DESC']]
        });
        res.json(sessions);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.createSession = async (req, res) => {
    try {
        const { type, title } = req.body;
        const session = await AISession.create({
            user_id: req.user.id,
            type: type || 'consult',
            title: title || 'Cuộc trò chuyện mới'
        });
        res.json(session);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.deleteSession = async (req, res) => {
    try {
        const { id } = req.params;
        await AISession.destroy({
            where: { id: id, user_id: req.user.id }
        });
        // Optionally delete messages too, but Cascade should handle it if set up in DB
        res.json({ message: "Đã xóa lịch sử trò chuyện" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
