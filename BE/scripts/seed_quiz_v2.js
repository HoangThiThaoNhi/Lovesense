const { QuizQuestion, QuizOption, sequelize } = require('../src/models');

const quizData = [
    {
        content: "Bạn cảm thấy thế nào về việc chia sẻ không gian riêng tư (personal space) khi đang trong một mối quan hệ?",
        category_id: "G6_CONFLICT_RESOLUTION",
        sub_category: "privacy",
        weight: 3,
        difficulty: "medium",
        priority: 5,
        options: [
            { label: "Cần sự kết nối 24/7, luôn muốn ở bên cạnh nhau", mappings: [{ criteria_id: "personal_space", score_delta: -0.8 }, { criteria_id: "attachment_style", score_delta: 0.5 }], meta_hint: "anxious_attachment" },
            { label: "Cần sự cân bằng, có những khoảng nghỉ cho sở thích cá nhân", mappings: [{ criteria_id: "personal_space", score_delta: 0.2 }, { criteria_id: "attachment_style", score_delta: -0.1 }], meta_hint: "secure_attachment" },
            { label: "Rất coi trọng không gian riêng, không muốn bị kiểm soát", mappings: [{ criteria_id: "personal_space", score_delta: 0.9 }, { criteria_id: "attachment_style", score_delta: -0.6 }], meta_hint: "avoidant_attachment" }
        ]
    },
    {
        content: "Khi có xung đột xảy ra, phản ứng đầu tiên của bạn thường là gì?",
        category_id: "G6_CONFLICT_RESOLUTION",
        sub_category: "communication",
        weight: 4,
        difficulty: "hard",
        priority: 6,
        options: [
            { label: "Ngồi lại nói chuyện thẳng thắn để tìm giải pháp ngay", mappings: [{ criteria_id: "communication_style", score_delta: 0.8 }, { criteria_id: "conflict_approach", score_delta: 0.7 }], meta_hint: "direct_communication" },
            { label: "Im lặng để bình tâm lại rồi mới giải quyết sau", mappings: [{ criteria_id: "communication_style", score_delta: -0.4 }, { criteria_id: "conflict_approach", score_delta: 0.2 }], meta_hint: "reflective_conflict" },
            { label: "Thể hiện cảm xúc mạnh mẽ, cần được đối phương vỗ về trước", mappings: [{ criteria_id: "communication_style", score_delta: 0.3 }, { criteria_id: "conflict_approach", score_delta: -0.7 }], meta_hint: "emotional_conflict" }
        ]
    },
    {
        content: "Quan điểm của bạn về việc quản lý tài chính trong hôn nhân/mối quan hệ lâu dài?",
        category_id: "G3_FINANCIAL_LIFESTYLE",
        sub_category: "finance",
        weight: 5,
        difficulty: "hard",
        priority: 7,
        options: [
            { label: "Công khai hoàn toàn, dùng chung một quỹ tài chính", mappings: [{ criteria_id: "financial_transparency", score_delta: 0.9 }], meta_hint: "full_transparency" },
            { label: "Góp chung sinh hoạt phí, còn lại tiền ai nấy giữ", mappings: [{ criteria_id: "financial_transparency", score_delta: 0.1 }], meta_hint: "hybrid_finance" },
            { label: "Độc lập hoàn toàn về tài chính để cảm thấy tự do", mappings: [{ criteria_id: "financial_transparency", score_delta: -0.8 }], meta_hint: "independent_finance" }
        ]
    },
    {
        content: "Bạn nhìn nhận thế nào về việc có con cái trong tương lai?",
        category_id: "G2_CORE_VALUES",
        sub_category: "family",
        weight: 5,
        difficulty: "medium",
        priority: 8,
        options: [
            { label: "Rất yêu trẻ con và chắc chắn muốn có con", mappings: [{ criteria_id: "family_goal", score_delta: 0.9 }], meta_hint: "family_oriented" },
            { label: "Đang phân vân, tùy thuộc vào điều kiện kinh tế và đối phương", mappings: [{ criteria_id: "family_goal", score_delta: 0.0 }], meta_hint: "undecided_family" },
            { label: "Ưu tiên cuộc sống tự do, không có ý định sinh con", mappings: [{ criteria_id: "family_goal", score_delta: -1.0 }], meta_hint: "child_free" }
        ]
    },
    {
        content: "Mức độ quan trọng của tôn giáo hoặc đức tin trong cuộc sống của bạn?",
        category_id: "G2_CORE_VALUES",
        sub_category: "spirituality",
        weight: 2,
        difficulty: "easy",
        priority: 9,
        options: [
            { label: "Rất quan trọng, chi phối mọi quyết định lớn", mappings: [{ criteria_id: "religion_influence", score_delta: 0.9 }], meta_hint: "spiritual_high" },
            { label: "Bình thường, có đức tin nhưng không quá khắt khe", mappings: [{ criteria_id: "religion_influence", score_delta: 0.3 }], meta_hint: "spiritual_moderate" },
            { label: "Không quan tâm đến tôn giáo/tâm linh", mappings: [{ criteria_id: "religion_influence", score_delta: -0.8 }], meta_hint: "secular" }
        ]
    },
    {
        content: "Bạn thường phản ứng thế nào với những thay đổi bất ngờ trong cuộc sống?",
        category_id: "G1_PERSONALITY",
        sub_category: "stability",
        weight: 3,
        difficulty: "medium",
        priority: 10,
        options: [
            { label: "Bình tĩnh đón nhận và thích nghi nhanh chóng", mappings: [{ criteria_id: "emotional_stability", score_delta: 0.8 }, { criteria_id: "openness_to_exp", score_delta: 0.5 }], meta_hint: "resilient" },
            { label: "Cảm thấy lo lắng nhưng sẽ cố gắng vượt qua", mappings: [{ criteria_id: "emotional_stability", score_delta: -0.2 }], meta_hint: "anxious_resilient" },
            { label: "Rất căng thẳng và cần nhiều thời gian để ổn định", mappings: [{ criteria_id: "emotional_stability", score_delta: -0.8 }], meta_hint: "sensitive" }
        ]
    },
    {
        content: "Gu du lịch yêu thích của bạn là gì?",
        category_id: "G7_INTERESTS_GROWTH",
        sub_category: "leisure",
        weight: 1,
        difficulty: "easy",
        priority: 11,
        options: [
            { label: "Nghỉ dưỡng sang chảnh tại Resort 5 sao", mappings: [{ criteria_id: "travel_style", score_delta: -0.7 }, { criteria_id: "spending_habit", score_delta: 0.6 }], meta_hint: "luxury_traveler" },
            { label: "Đi phượt, khám phá những vùng đất hoang sơ", mappings: [{ criteria_id: "travel_style", score_delta: 0.9 }, { criteria_id: "openness_to_exp", score_delta: 0.7 }], meta_hint: "explorer" },
            { label: "Du lịch văn hóa, bảo tàng và ẩm thực địa phương", mappings: [{ criteria_id: "travel_style", score_delta: 0.2 }, { criteria_id: "intellectual_curiosity", score_delta: 0.5 }], meta_hint: "cultural_traveler" }
        ]
    },
    {
        content: "Bạn có nhu cầu học hỏi và phát triển bản thân như thế nào?",
        category_id: "G7_INTERESTS_GROWTH",
        sub_category: "intellect",
        weight: 2,
        difficulty: "medium",
        priority: 12,
        options: [
            { label: "Liên tục học các kỹ năng mới, đọc sách mỗi ngày", mappings: [{ criteria_id: "intellectual_curiosity", score_delta: 0.9 }], meta_hint: "constant_learner" },
            { label: "Học khi cần thiết cho công việc hoặc cuộc sống", mappings: [{ criteria_id: "intellectual_curiosity", score_delta: 0.3 }], meta_hint: "practical_learner" },
            { label: "Hài lòng với những gì mình đang có", mappings: [{ criteria_id: "intellectual_curiosity", score_delta: -0.5 }], meta_hint: "contented" }
        ]
    },
    {
        content: "Mối quan hệ của bạn với vòng tròn bạn bè (social circle) như thế nào?",
        category_id: "G7_INTERESTS_GROWTH",
        sub_category: "social",
        weight: 2,
        difficulty: "easy",
        priority: 13,
        options: [
            { label: "Rất rộng, thích kết giao thêm nhiều người mới", mappings: [{ criteria_id: "social_circle", score_delta: 0.9 }, { criteria_id: "extroversion", score_delta: 0.6 }], meta_hint: "social_butterfly" },
            { label: "Vừa phải, tập trung vào một nhóm bạn thân thiết", mappings: [{ criteria_id: "social_circle", score_delta: -0.2 }], meta_hint: "loyal_circle" },
            { label: "Khá hẹp, chỉ có vài người thực sự tin tưởng", mappings: [{ criteria_id: "social_circle", score_delta: -0.7 }, { criteria_id: "extroversion", score_delta: -0.4 }], meta_hint: "private_social" }
        ]
    },
    {
        content: "Định nghĩa của bạn về sự chung thủy trong tình yêu?",
        category_id: "G2_CORE_VALUES",
        sub_category: "loyalty",
        weight: 5,
        difficulty: "hard",
        priority: 14,
        options: [
            { label: "Tuyệt đối không có bất kỳ mối quan hệ mập mờ nào", mappings: [{ criteria_id: "loyalty_definition", score_delta: 1.0 }], meta_hint: "strict_loyalty" },
            { label: "Quan trọng là sự thành thật và tôn trọng lẫn nhau", mappings: [{ criteria_id: "loyalty_definition", score_delta: 0.5 }], meta_hint: "honest_loyalty" },
            { label: "Mối quan hệ mở (Open Relationship) là một lựa chọn", mappings: [{ criteria_id: "loyalty_definition", score_delta: -0.8 }], meta_hint: "open_relationship" }
        ]
    }
];

async function seedQuizV2() {
    try {
        await sequelize.authenticate();
        console.log('Connected to DB for seeding Quiz V2...');

        for (const q of quizData) {
            const question = await QuizQuestion.create({
                content: q.content,
                category_id: q.category_id,
                sub_category: q.sub_category,
                weight: q.weight,
                difficulty: q.difficulty,
                priority: q.priority,
                type: 'mcq',
                status: 'active'
            });

            for (const opt of q.options) {
                await QuizOption.create({
                    question_id: question.id,
                    label: opt.label,
                    mappings: opt.mappings,
                    meta_hint: opt.meta_hint
                });
            }
        }

        console.log(`Successfully seeded ${quizData.length} new DNA questions with advanced AI mappings!`);
        process.exit();
    } catch (error) {
        console.error('Seed Quiz V2 Failed:', error);
        process.exit(1);
    }
}

seedQuizV2();
