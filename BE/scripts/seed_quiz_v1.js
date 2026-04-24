const { QuizQuestion, QuizOption, sequelize } = require('../src/models');

const quizData = [
    {
        content: "Bạn thường dành ngày Chủ nhật lý tưởng của mình như thế nào?",
        category_id: "G1_PERSONALITY",
        priority: 1,
        options: [
            { label: "Đi tiệc tùng, tụ tập bạn bè đông đúc", mappings: [{ criteria_id: "extroversion", score_delta: 0.8 }, { criteria_id: "social_circle", score_delta: 0.5 }], meta_hint: "extrovert_high" },
            { label: "Ở nhà đọc sách hoặc xem phim một mình", mappings: [{ criteria_id: "extroversion", score_delta: -0.7 }, { criteria_id: "intellectual_curiosity", score_delta: 0.4 }], meta_hint: "introvert_high" },
            { label: "Đi cafe chill với 1-2 người bạn thân", mappings: [{ criteria_id: "extroversion", score_delta: 0.2 }, { criteria_id: "social_circle", score_delta: -0.2 }], meta_hint: "balanced_social" }
        ]
    },
    {
        content: "Khi gặp một vấn đề khó khăn trong sự nghiệp, bạn sẽ:",
        category_id: "G3_FINANCIAL_LIFESTYLE",
        priority: 2,
        options: [
            { label: "Bất chấp tất cả để giải quyết và thăng tiến", mappings: [{ criteria_id: "career_ambition", score_delta: 0.9 }], meta_hint: "ambitious_high" },
            { label: "Cân bằng lại, gia đình và sức khỏe là trên hết", mappings: [{ criteria_id: "career_ambition", score_delta: -0.6 }, { criteria_id: "family_goal", score_delta: 0.4 }], meta_hint: "work_life_balance" }
        ]
    },
    {
        content: "Quan điểm của bạn về việc chi tiêu cho các kỳ nghỉ sang chảnh?",
        category_id: "G3_FINANCIAL_LIFESTYLE",
        priority: 3,
        options: [
            { label: "Đáng đồng tiền bát gạo, trải nghiệm là vô giá", mappings: [{ criteria_id: "spending_habit", score_delta: 0.7 }], meta_hint: "spender" },
            { label: "Nên tiết kiệm để đầu tư cho tương lai dài hạn", mappings: [{ criteria_id: "spending_habit", score_delta: -0.8 }], meta_hint: "saver" }
        ]
    },
    {
        content: "Cách bạn thường thể hiện tình cảm với đối phương là:",
        category_id: "G4_INTIMACY_ROMANCE",
        priority: 4,
        options: [
            { label: "Những cái ôm, nắm tay thật chặt", mappings: [{ criteria_id: "physical_touch_need", score_delta: 0.9 }], meta_hint: "physical_touch_lover" },
            { label: "Tặng những món quà ý nghĩa và thực tế", mappings: [{ criteria_id: "romance_style", score_delta: -0.3 }], meta_hint: "practical_romance" }
        ]
    }
];

async function seedQuiz() {
    try {
        await sequelize.authenticate();
        console.log('Connected to DB for seeding Quiz...');

        for (const q of quizData) {
            const question = await QuizQuestion.create({
                content: q.content,
                category_id: q.category_id,
                priority: q.priority
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

        console.log('Successfully seeded 4 sample DNA questions with logic mappings!');
        process.exit();
    } catch (error) {
        console.error('Seed Quiz Failed:', error);
        process.exit(1);
    }
}

seedQuiz();
