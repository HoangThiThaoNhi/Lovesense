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
 * Lấy danh sách quiz cho App Flutter hiển thị (Chọn ngẫu nhiên 1 trong 6 bộ cốt lõi gồm 7 câu)
 */
exports.getQuiz = async (req, res) => {
    try {
        const userId = req.user.id;

        // 1. Get all unique set_ids available in active questions
        const distinctSets = await QuizQuestion.findAll({
            attributes: ['set_id'],
            group: ['set_id'],
            where: { status: 'active' }
        });
        
        const setIds = distinctSets.map(q => q.set_id).filter(id => id != null);
        const randomSetId = setIds.length > 0 ? setIds[Math.floor(Math.random() * setIds.length)] : 1;

        console.log(`[Quiz] Selected random set_id: ${randomSetId} for user ${userId}`);

        // 2. Fetch the 7 questions of this set
        const questions = await QuizQuestion.findAll({
            where: { status: 'active', set_id: randomSetId },
            include: [{
                model: QuizOption,
                as: 'options',
                attributes: ['id', 'label', 'meta_hint']
            }],
            order: [['priority', 'ASC']]
        });

        // 3. Reset dna_vector and set quiz_session_state
        await Profile.update({
            dna_vector: {},
            quiz_session_state: {
                current_set_id: randomSetId,
                answered_question_ids: [],
                stage: 1,
                answered_questions: [],
                generated_questions: []
            }
        }, { where: { user_id: userId } });

        console.log(`[Quiz] Reset DNA vector & initialized quiz_session_state for user ${userId}`);
        
        res.json(questions);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

/**
 * Xử lý khi user trả lời một câu hỏi (Hỗ trợ cả câu hỏi tĩnh trong DB và câu hỏi động do AI sinh ra)
 */
exports.submitAnswer = async (req, res) => {
    try {
        const userId = req.user.id;
        const { optionId } = req.body;
        const crypto = require('crypto');

        if (!optionId) {
            return res.status(400).json({ error: 'Thiếu optionId trong yêu cầu.' });
        }
        
        const profile = await Profile.findOne({ where: { user_id: userId } });
        let sessionState = profile.quiz_session_state || { answered_question_ids: [], stage: 1, answered_questions: [], generated_questions: [] };
        if (typeof sessionState === 'string') {
            try { sessionState = JSON.parse(sessionState); } catch(e) { sessionState = { answered_question_ids: [], stage: 1, answered_questions: [], generated_questions: [] }; }
        }
        if (!sessionState.answered_questions) sessionState.answered_questions = [];
        if (!sessionState.generated_questions) sessionState.generated_questions = [];

        let option = null;
        let isDynamic = false;
        let questionContent = "";
        let optionLabel = "";
        let mappings = [];
        let questionId = null;

        // 1. Check if optionId is from a dynamically generated question (case-insensitive string comparison)
        if (sessionState.generated_questions && Array.isArray(sessionState.generated_questions)) {
            for (const q of sessionState.generated_questions) {
                const opt = q.options.find(o => String(o.id).toLowerCase() === String(optionId).toLowerCase());
                if (opt) {
                    option = opt;
                    isDynamic = true;
                    questionContent = q.content;
                    optionLabel = opt.label;
                    mappings = opt.mappings || [];
                    questionId = q.id;
                    break;
                }
            }
        }

        // 2. If not dynamic, search database (static question)
        if (!option) {
            const dbOption = await QuizOption.findOne({
                where: { id: optionId },
                include: [{ model: QuizQuestion, as: 'question' }]
            });
            if (!dbOption) return res.status(404).json({ error: 'Option not found' });
            option = dbOption;
            questionContent = dbOption.question.content;
            optionLabel = dbOption.label;
            mappings = dbOption.mappings || [];
            questionId = dbOption.question.id;
        }

        // 3. Update DNA Vector in Profile
        let dnaVector = profile.dna_vector || {};
        if (typeof dnaVector === 'string') {
            try { dnaVector = JSON.parse(dnaVector); } catch(e) { dnaVector = {}; }
        }

        if (typeof mappings === 'string') {
            try { mappings = JSON.parse(mappings); } catch(e) { mappings = []; }
        }

        console.log(`[Quiz] Processing answer for User ${userId}. Current DNA:`, JSON.stringify(dnaVector));
        console.log(`[Quiz] Mappings to apply:`, JSON.stringify(mappings));

        if (Array.isArray(mappings)) {
            mappings.forEach(mapping => {
                const currentScore = dnaVector[mapping.criteria_id] || 0;
                dnaVector[mapping.criteria_id] = Math.max(-1.0, Math.min(1.0, currentScore + (mapping.score_delta || 0)));
            });
        }

        // 4. Update sessionState progress
        if (!sessionState.answered_question_ids.includes(questionId)) {
            sessionState.answered_question_ids.push(questionId);
            sessionState.answered_questions.push({
                question_text: questionContent,
                selected_option_label: optionLabel
            });
        }

        // 5. Check if we just completed Stage 1 (first 7 questions)
        let nextQuestions = null;
        if (sessionState.stage === 1 && sessionState.answered_question_ids.length === 7) {
            console.log(`[Quiz] Stage 1 completed for user ${userId}. Generating dynamic follow-up questions...`);
            
            // Generate follow-up questions based on answers and current DNA Vector
            const nextQuestionsData = await AIService.generateDynamicFollowUpQuestions(
                sessionState.answered_questions,
                dnaVector
            );

            // Format dynamic questions with temporary IDs (UUID v4)
            const formattedNextQuestions = nextQuestionsData.map(q => {
                const qId = crypto.randomUUID();
                return {
                    id: qId,
                    content: q.content,
                    category_id: q.category_id || 'G1_PERSONALITY',
                    sub_category: q.sub_category || 'general',
                    type: 'mcq',
                    options: (q.options || []).map(opt => ({
                        id: crypto.randomUUID(),
                        question_id: qId,
                        label: opt.label,
                        mappings: opt.mappings || [],
                        meta_hint: opt.meta_hint || ''
                    }))
                };
            });

            // Cache formatted questions in sessionState
            sessionState.generated_questions = formattedNextQuestions;
            sessionState.stage = 2;

            // Strip mappings before sending to mobile client for security
            nextQuestions = formattedNextQuestions.map(q => ({
                id: q.id,
                content: q.content,
                category_id: q.category_id,
                sub_category: q.sub_category,
                type: q.type,
                options: q.options.map(opt => ({
                    id: opt.id,
                    label: opt.label,
                    meta_hint: opt.meta_hint
                }))
            }));
            console.log(`[Quiz] Generated ${nextQuestions.length} follow-up questions for user ${userId}`);
        }

        // Explicitly set JSON change flags to force Sequelize to generate SQL UPDATE
        profile.dna_vector = dnaVector;
        profile.quiz_session_state = sessionState;
        profile.changed('dna_vector', true);
        profile.changed('quiz_session_state', true);
        await profile.save();
        console.log(`[Quiz] Updated DNA Vector and quiz_session_state in DB for user ${userId}:`, JSON.stringify(dnaVector));

        // 6. Award XP points
        const points = 5;
        const gamification = await GamificationService.awardPoints(userId, points, `Trả lời câu hỏi AI DNA: ${questionContent.substring(0, 30)}...`, { skipNotification: true });

        res.json({
            message: 'Answer processed',
            dna_vector: dnaVector,
            points_added: points,
            gamification,
            next_questions: nextQuestions
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
            type: 'ai_insight',
            title: '✨ Giải mã DNA Soulmate thành công!',
            content: 'Chúc mừng! Bạn đã hoàn thành bài trắc nghiệm DNA. Lovesense AI đã cập nhật hồ sơ và sẵn sàng tìm kiếm nửa kia hoàn hảo cho bạn.',
            metadata: { report_summary: (report.user_summary || '').substring(0, 50) }
        });
        
        res.json(reportResponse);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

