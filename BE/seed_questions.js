require('dotenv').config();
const { Sequelize } = require('sequelize');
const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD, {
    host: process.env.DB_HOST,
    dialect: 'mysql',
    logging: false
});

const questions = [
    // 1. QUAN ĐIỂM & HỆ GIÁ TRỊ (Values & Vision) - Trọng số cao nhất
    {
        text: "Quan điểm của bạn về việc kết hôn và xây dựng gia đình trong 2-3 năm tới?",
        category: "Values",
        sub_category: "Marriage",
        weight: 5,
        options: JSON.stringify(["Sẵn sàng kết hôn", "Đang tìm hiểu nghiêm túc", "Chưa vội, ưu tiên sự nghiệp", "Muốn tận hưởng cuộc sống độc thân"])
    },
    {
        text: "Bạn mong muốn đối phương có quan điểm thế nào về việc quản lý tài chính sau khi kết hôn?",
        category: "Values",
        sub_category: "Finances",
        weight: 5,
        options: JSON.stringify(["Quỹ chung hoàn toàn", "Quỹ chung một phần, quỹ riêng một phần", "Tài chính ai nấy giữ", "Đàn ông/Phụ nữ giữ tay hòm chìa khóa"])
    },
    {
        text: "Về vấn đề con cái, bạn dự định như thế nào?",
        category: "Values",
        sub_category: "Children",
        weight: 5,
        options: JSON.stringify(["Yêu trẻ con và muốn có con sớm", "Muốn có con nhưng cần thời gian chuẩn bị", "Chưa quyết định", "Muốn cuộc sống không con cái (DINK)"])
    },

    // 2. TÍNH CÁCH & CẢM XÚC (Personality & Emotion)
    {
        text: "Cách bạn thường giải quyết mâu thuẫn trong một mối quan hệ là gì?",
        category: "Personality",
        sub_category: "Conflict",
        weight: 4,
        options: JSON.stringify(["Ngồi lại nói chuyện thẳng thắn ngay", "Cần không gian riêng để bình tĩnh rồi mới nói", "Nhường nhịn để giữ hòa khí", "Im lặng chờ đối phương chủ động"])
    },
    {
        text: "Ngôn ngữ tình yêu (Love Language) chủ đạo của bạn là?",
        category: "Personality",
        sub_category: "LoveLanguage",
        weight: 4,
        options: JSON.stringify(["Lời nói ngọt ngào", "Hành động chăm sóc", "Sự tiếp xúc cơ thể", "Thời gian chất lượng bên nhau", "Quà tặng"])
    },

    // 3. LỐI SỐNG & THÓI QUEN (Lifestyle)
    {
        text: "Bạn là kiểu người của buổi sáng hay buổi đêm?",
        category: "Lifestyle",
        sub_category: "Routine",
        weight: 3,
        options: JSON.stringify(["Morning Person (Thích dậy sớm)", "Night Owl (Cú đêm)", "Linh hoạt tùy công việc"])
    },
    {
        text: "Về thói quen chi tiêu và hưởng thụ?",
        category: "Lifestyle",
        sub_category: "Spending",
        weight: 3,
        options: JSON.stringify(["Tiết kiệm, lo cho tương lai", "Biết hưởng thụ nhưng có kế hoạch", "Thoải mái, sống cho hiện tại", "Săn sale và tối ưu chi phí"])
    },

    // 4. SỞ THÍCH & ĐAM MÊ (Interests)
    {
        text: "Phong cách du lịch yêu thích của bạn?",
        category: "Interests",
        sub_category: "Travel",
        weight: 2,
        options: JSON.stringify(["Nghỉ dưỡng sang chảnh", "Khám phá mạo hiểm", "Du lịch tâm linh/về với thiên nhiên", "Phượt bụi tự do"])
    }
];

async function seed() {
    try {
        await sequelize.authenticate();
        console.log('Database connected.');
        
        // Clear old questions first (Optional, but good for reset)
        await sequelize.query('DELETE FROM questions');
        
        for (const q of questions) {
            await sequelize.query(
                'INSERT INTO questions (text, category, sub_category, weight, options, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, "active", NOW(), NOW())',
                { replacements: [q.text, q.category, q.sub_category, q.weight, q.options] }
            );
        }
        
        console.log('Successfully seeded professional partner criteria!');
        process.exit(0);
    } catch (error) {
        console.error('Seeding failed:', error);
        process.exit(1);
    }
}

seed();
