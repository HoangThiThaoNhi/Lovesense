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

        // Reset dna_vector khi bắt đầu bài mới để kết quả không bị cộng dồn từ lần trước
        // KHÔNG reset dna_report để user vẫn xem được kết quả cũ nếu bỏ quiz giữa chừng
        // dna_report sẽ bị ghi đè khi hoàn thành bài mới
        const userId = req.user.id;
        await Profile.update({ dna_vector: {} }, { where: { user_id: userId } });
        console.log(`[Quiz] Reset DNA vector for user ${userId} - starting fresh quiz session (old report preserved until new one is generated)`);
        
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
        const gamification = await GamificationService.awardPoints(userId, points, `Trả lời câu hỏi AI DNA: ${option.question.content.substring(0, 30)}...`, { skipNotification: true });
        
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
        
        // 1. Parse if string
        if (typeof dnaVector === 'string') {
            try { dnaVector = JSON.parse(dnaVector); } catch(e) { dnaVector = null; }
        }
        
        // 2. RESET LOGIC: Only reset if truly a legacy Array
        if (Array.isArray(dnaVector)) {
            console.log(`[Quiz] Legacy Array DNA detected for User ${userId}. Resetting to Object...`);
            await profile.update({ dna_vector: {}, dna_report: null });
            return res.status(400).json({ error: 'Dữ liệu DNA cũ không còn tương thích. Vui lòng làm lại bài Quiz để nhận kết quả chính xác nhất!' });
        }

        // 3. SERVE FROM CACHE FIRST - return cached report regardless of dna_vector state
        // This allows viewing the report even if the user started (but didn't finish) a new quiz
        const forceNew = req.query.forceNew === 'true';
        if (!forceNew && profile.dna_report) {
            console.log(`[Quiz] Returning cached DNA report for user ${userId}`);
            return res.json(profile.dna_report);
        }

        // 4. No cache and no dna_vector → require quiz
        if (!dnaVector || Object.keys(dnaVector).length === 0) {
            return res.status(400).json({ error: 'Chưa đủ dữ liệu DNA để phân tích. Hãy trả lời thêm vài câu hỏi nhé!' });
        }
        
        // 5. Generate NEW report via AI
        console.log(`[Quiz] Generating new DNA report for user ${userId}...`);
        const report = await AIService.generateDNAReport(dnaVector);
        
        // Update keywords in profile for Discovery
        // Chỉ dùng các câu AI-generated highlights (loại bỏ raw criteria ID như social_circle, career_ambition...)
        const dnaKeywords = (report.user_highlights || []).map(h => h.replace('✨ ', '').trim());

        // Build the response object
        const reportResponse = {
            summary: report.user_summary,
            highlights: report.user_highlights,
            ideal_vibe: report.ideal_partner_vibe,
            debug_dna: dnaVector
        };

        // 6. SAVE REPORT TO DB so future calls return exact same content
        await profile.update({ 
            ai_ideal_description: report.user_summary,
            ai_match_keywords: dnaKeywords,
            dna_report: reportResponse  // <-- Cache the full report
        });
        
        // --- ADD HISTORY LOGGING CHO MỤC ĐÍCH DEMO ---
        try {
            const fs = require('fs');
            const path = require('path');
            const logPath = path.join(__dirname, '../../dna_test_history.json');
            let history = [];
            if (fs.existsSync(logPath)) {
                const data = fs.readFileSync(logPath, 'utf8');
                history = JSON.parse(data || '[]');
            }
            history.unshift({
                time: new Date().toISOString(),
                user_id: userId,
                display_name: profile.display_name,
                dna_vector: dnaVector,
                report: reportResponse
            });
            // Giữ lại 20 lịch sử gần nhất
            if (history.length > 20) history = history.slice(0, 20);
            fs.writeFileSync(logPath, JSON.stringify(history, null, 2));
        } catch (err) {
            console.error('[Quiz] Lỗi lưu lịch sử demo:', err);
        }
        // ---------------------------------------------
        
        console.log(`[Quiz] DNA report saved to profile for user ${userId}`);

        // Sync 7 DNA score columns to User table
        const dnaScores = await AIService.calculateDNAProfile(null, dnaVector);
        const { User } = require('../models');
        await User.update(dnaScores, { where: { id: userId } });
        console.log(`[Quiz] DNA Scores synced to User table for user ${userId}`);

        // Notification
        await Notification.create({
            user_id: userId,
            type: 'ai_analysis',
            title: '✨ Giải mã DNA Soulmate thành công!',
            content: 'Chúc mừng! Bạn đã hoàn thành bài trắc nghiệm DNA. Lovesense AI đã cập nhật hồ sơ và sẵn sàng tìm kiếm nửa kia hoàn hảo cho bạn.',
            metadata: { report_summary: (report.user_summary || '').substring(0, 50) }
        });
        
        res.json(reportResponse);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

