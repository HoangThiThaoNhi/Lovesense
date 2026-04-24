const { Question } = require('./src/models');
const sequelize = require('./src/config/db');

const questions = [
    // G1: PERSONALITY
    {
        text: "Khi đứng trước một đám đông hoàn toàn xa lạ, bạn thường:",
        category: "G1_PERSONALITY",
        sub_category: "extroversion",
        options: JSON.stringify(["Chủ động làm quen và dẫn dắt câu chuyện", "Quan sát và chỉ nói khi có người hỏi", "Cảm thấy không thoải mái và muốn rời đi sớm"]),
        weight: 4
    },
    {
        text: "Khi gặp stress nặng, bạn thường phản ứng như thế nào?",
        category: "G1_PERSONALITY",
        sub_category: "emotional_stability",
        options: JSON.stringify(["Bình tĩnh tìm nguyên nhân và giải quyết", "Dễ cáu gắt và mất kiểm soát cảm xúc", "Cần thời gian ở một mình để cân bằng lại"]),
        weight: 5
    },
    // G2: CORE VALUES
    {
        text: "Quan điểm của bạn về việc lập gia đình và có con?",
        category: "G2_CORE_VALUES",
        sub_category: "family_goal",
        options: JSON.stringify(["Là mục tiêu quan trọng nhất cuộc đời", "Chưa sẵn sàng, muốn tận hưởng cuộc sống tự do", "Có cũng được, không có cũng không sao"]),
        weight: 5
    },
    {
        text: "Theo bạn, hành động nào được coi là phản bội nặng nề nhất?",
        category: "G2_CORE_VALUES",
        sub_category: "loyalty_definition",
        options: JSON.stringify(["Ngoại tình thể xác", "Ngoại tình tư tưởng (nhắn tin, thả thính)", "Nói dối về những vấn đề tài chính quan trọng"]),
        weight: 5
    },
    // G3: FINANCIAL
    {
        text: "Nếu trúng số 1 tỷ đồng, bạn sẽ ưu tiên việc gì đầu tiên?",
        category: "G3_FINANCIAL_LIFESTYLE",
        sub_category: "spending_habit",
        options: JSON.stringify(["Gửi tiết kiệm hoặc đầu tư sinh lời", "Mua sắm những thứ mình thích từ lâu", "Dùng để đi du lịch và trải nghiệm"]),
        weight: 4
    },
    // G4: INTIMACY
    {
        text: "Bạn cảm thấy được yêu thương nhất khi đối phương thực hiện điều gì?",
        category: "G4_INTIMACY_ROMANCE",
        sub_category: "love_language",
        options: JSON.stringify(["Dành thời gian chất lượng bên nhau", "Trao lời khen ngợi và động viên", "Những cử chỉ thân mật (nắm tay, ôm hôn)"]),
        weight: 5
    },
    // G6: CONFLICT
    {
        text: "Khi có mâu thuẫn xảy ra, phong cách giải quyết của bạn là:",
        category: "G6_CONFLICT_RESOLUTION",
        sub_category: "communication_style",
        options: JSON.stringify(["Nói chuyện thẳng thắn ngay lập tức", "Im lặng để cả hai cùng bình tĩnh lại", "Viết thư hoặc nhắn tin để bày tỏ cảm xúc"]),
        weight: 4
    }
];

async function seed() {
    try {
        await sequelize.sync();
        
        // Disable foreign key checks to allow truncating the questions table
        await sequelize.query('SET FOREIGN_KEY_CHECKS = 0');
        
        // Clear old questions
        await Question.destroy({ where: {}, truncate: true });
        
        // Re-enable foreign key checks
        await sequelize.query('SET FOREIGN_KEY_CHECKS = 1');

        await Question.bulkCreate(questions);
        console.log('✅ Seeded new Criteria-based questions successfully!');
        process.exit(0);
    } catch (error) {
        // Ensure foreign key checks are re-enabled even on error
        await sequelize.query('SET FOREIGN_KEY_CHECKS = 1');
        console.error('❌ Error seeding questions:', error);
        process.exit(1);
    }
}

seed();
