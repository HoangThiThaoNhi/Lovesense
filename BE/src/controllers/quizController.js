const QuizQuestion = require('../models/quizQuestionModel');
const QuizOption = require('../models/quizOptionModel');
const Profile = require('../models/profileModel');
const PointHistory = require('../models/pointHistoryModel');
const Badge = require('../models/badgeModel');
const UserBadge = require('../models/userBadgeModel');
const Notification = require('../models/notificationModel');
const AIService = require('../services/aiService');
const GamificationService = require('../services/gamificationService');
const anof = require('../config/anof.json');

// --- CMS APIs ---

/**
 * AI gợi ý mappings cho câu hỏi và các đáp án dựa trên anof.json
 */
exports.aiSuggestMappings = async (req, res) => {
    try {
        const { question, options, category_id } = req.body;
        
        // Gọi AI Service để phân tích logic dựa trên framework anof
        const suggestion = await AIService.suggestQuizLogic(question, options, category_id);
        
        res.json(suggestion);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.createQuestion = async (req, res) => {
    try {
        const { content, category_id, priority, options } = req.body;
        
        const question = await QuizQuestion.create({ content, category_id, priority });
        
        if (options && options.length > 0) {
            const optionsToCreate = options.map(opt => ({
                ...opt,
                question_id: question.id
            }));
            await QuizOption.bulkCreate(optionsToCreate);
        }
        
        res.json({ message: 'Question created successfully', questionId: question.id });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// --- APP APIs ---

/**
 * Lấy danh sách quiz cho App Flutter hiển thị
 */
exports.getQuiz = async (req, res) => {
    try {
        const questions = await QuizQuestion.findAll({
            where: { status: 'active' },
            include: [{
                model: QuizOption,
                as: 'options',
                attributes: ['id', 'label', 'meta_hint'] // Không trả về mappings để tránh user hack
            }],
            order: [['priority', 'ASC']]
        });
        
        res.json(questions);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

/**
 * Xử lý khi user trả lời một câu hỏi
 */
exports.submitAnswer = async (req, res) => {
    try {
        const userId = req.user.id;
        const { optionId } = req.body;
        
        const option = await QuizOption.findByPk(optionId, {
            include: [{ model: QuizQuestion, as: 'question' }]
        });
        
        if (!option) return res.status(404).json({ error: 'Option not found' });
        
        // 1. Cập nhật DNA Vector trong Profile
        const profile = await Profile.findOne({ where: { user_id: userId } });
        
        // Đảm bảo dnaVector là Object (đề phòng DB trả về String)
        let dnaVector = profile.dna_vector || {};
        if (typeof dnaVector === 'string') {
            try { dnaVector = JSON.parse(dnaVector); } catch(e) { dnaVector = {}; }
        }
        
        // Đảm bảo mappings là Array
        let mappings = option.mappings || [];
        if (typeof mappings === 'string') {
            try { mappings = JSON.parse(mappings); } catch(e) { mappings = []; }
        }
        
        console.log(`[Quiz] Processing answer for User ${userId}. Current DNA:`, JSON.stringify(dnaVector));
        console.log(`[Quiz] Mappings to apply:`, JSON.stringify(mappings));

        if (Array.isArray(mappings)) {
            mappings.forEach(mapping => {
                const currentScore = dnaVector[mapping.criteria_id] || 0;
                // Giới hạn score trong khoảng [-1.0, 1.0]
                dnaVector[mapping.criteria_id] = Math.max(-1.0, Math.min(1.0, currentScore + (mapping.score_delta || 0)));
            });
        }
        
        await profile.update({ dna_vector: dnaVector });
        console.log(`[Quiz] Updated DNA Vector:`, JSON.stringify(dnaVector));
        
        // 2. Thưởng điểm XP (Mỗi câu hỏi DNA cộng 5 XP)
        const points = 5;
        const gamification = await GamificationService.awardPoints(userId, points, `Trả lời câu hỏi AI DNA: ${option.question.content.substring(0, 30)}...`);
        
        res.json({ 
            message: 'Answer processed', 
            dna_vector: dnaVector,
            points_added: points,
            gamification
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

/**
 * AI Tổng hợp DNA và viết bài nhận xét tổng quan
 */
exports.generateDNAReport = async (req, res) => {
    try {
        const userId = req.user.id;
        const profile = await Profile.findOne({ where: { user_id: userId } });
        
        let dnaVector = profile.dna_vector;
        
        // 1. Cố gắng parse nếu là String
        if (typeof dnaVector === 'string') {
            try { dnaVector = JSON.parse(dnaVector); } catch(e) { dnaVector = null; }
        }
        
        // 2. RESET LOGIC: Chỉ reset nếu thực sự là Mảng cũ (Legacy)
        if (Array.isArray(dnaVector)) {
            console.log(`[Quiz] Legacy Array DNA detected for User ${userId}. Resetting to Object...`);
            await profile.update({ dna_vector: {} });
            return res.status(400).json({ error: 'Dữ liệu DNA cũ không còn tương thích. Vui lòng làm lại bài Quiz để nhận kết quả chính xác nhất!' });
        }

        // 3. Nếu rỗng hoặc null, yêu cầu làm bài
        if (!dnaVector || Object.keys(dnaVector).length === 0) {
            return res.status(400).json({ error: 'Chưa đủ dữ liệu DNA để phân tích. Hãy trả lời thêm vài câu hỏi nhé!' });
        }
        
        // Gọi AI viết bài phân tích dựa trên DNA Vector và Framework anof
        const report = await AIService.generateDNAReport(dnaVector);
        
        // Cập nhật keywords vào profile để Discovery có thể tìm người phù hợp
        // Lấy cả nhãn AI và tên tiêu chí gốc để tăng tỉ lệ match
        const dnaKeywords = [
            ...(report.highlights || []).map(h => h.replace('✨ ', '')),
            ...Object.keys(dnaVector).filter(k => Math.abs(dnaVector[k]) > 0.5) // Lấy các ID tiêu chí có điểm cao
        ];

        await profile.update({ 
            ai_ideal_description: report.summary,
            ai_match_keywords: dnaKeywords // LƯU TỪ KHÓA ĐỂ MATCHING
        });

        // NEW: Also sync to User table 7 score columns
        const dnaScores = AIService.calculateDNAProfile(null, dnaVector);
        const { User } = require('../models');
        await User.update(dnaScores, { where: { id: userId } });
        console.log(`[Quiz] DNA Scores synced to User table for user ${userId}`);
        
        res.json({
            ...report,
            debug_dna: dnaVector
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
