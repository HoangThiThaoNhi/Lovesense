const mysql = require('mysql2/promise');
require('dotenv').config();

// Cấu hình Database lấy từ file .env của dự án
const dbConfig = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'lovesense'
};

// Hàm hỗ trợ tạo số ngẫu nhiên trong khoảng
const range = (min, max) => Math.floor(Math.random() * (max - min + 1)) + min;

/**
 * Phân loại các nhóm người dùng (User Personas)
 */
const UserPersonas = {
  // 1. Nhóm tập trung sự nghiệp & tham vọng
  CAREER_DRIVEN: () => ({
    ambition_score: range(80, 100),
    personality_score: range(70, 95), // Thường quyết đoán
    career_score: range(80, 100),
    core_values_score: range(60, 90),
    interests_score: range(40, 70),
    lifestyle_score: range(70, 100), // Sang chảnh/Bận rộn
    family_orientation_score: range(20, 50)
  }),

  // 2. Nhóm hướng về gia đình & truyền thống
  FAMILY_FIRST: () => ({
    ambition_score: range(30, 60),
    personality_score: range(40, 70), 
    career_score: range(30, 60),
    core_values_score: range(80, 100),
    interests_score: range(50, 80),
    lifestyle_score: range(40, 70),
    family_orientation_score: range(85, 100)
  }),

  // 3. Nhóm nghệ sĩ/Tự do & Sở thích
  LIFE_ENTHUSIAST: () => ({
    ambition_score: range(20, 50),
    personality_score: range(80, 100), // Hướng ngoại/Sáng tạo
    career_score: range(20, 50),
    core_values_score: range(40, 70),
    interests_score: range(85, 100),
    lifestyle_score: range(80, 100),
    family_orientation_score: range(30, 60)
  }),

  // 4. Nhóm cân bằng (Trung bình)
  BALANCED: () => ({
    ambition_score: range(50, 75),
    personality_score: range(50, 75),
    career_score: range(50, 75),
    core_values_score: range(50, 75),
    interests_score: range(50, 75),
    lifestyle_score: range(50, 75),
    family_orientation_score: range(50, 75)
  })
};

async function seedUserScores() {
  let connection;
  try {
    connection = await mysql.createConnection(dbConfig);
    console.log("🚀 Đang kết nối tới database:", dbConfig.database);
    console.log("🚀 Đang bắt đầu điền dữ liệu phân loại...");

    const [users] = await connection.execute('SELECT id FROM users');
    
    if (users.length === 0) {
      console.log("❌ Không tìm thấy user nào để fill dữ liệu.");
      return;
    }

    console.log(`📊 Tìm thấy ${users.length} users. Đang xử lý...`);

    for (let user of users) {
      const rand = Math.random();
      let scores;

      if (rand < 0.2) scores = UserPersonas.CAREER_DRIVEN();
      else if (rand < 0.4) scores = UserPersonas.FAMILY_FIRST();
      else if (rand < 0.6) scores = UserPersonas.LIFE_ENTHUSIAST();
      else scores = UserPersonas.BALANCED();

      await connection.execute(
        `UPDATE users SET 
          ambition_score = ?, 
          personality_score = ?, 
          career_score = ?, 
          core_values_score = ?, 
          interests_score = ?, 
          lifestyle_score = ?, 
          family_orientation_score = ? 
        WHERE id = ?`,
        [
          scores.ambition_score, 
          scores.personality_score, 
          scores.career_score, 
          scores.core_values_score, 
          scores.interests_score, 
          scores.lifestyle_score, 
          scores.family_orientation_score, 
          user.id
        ]
      );
    }

    console.log(`✅ Thành công! Đã phân loại và cập nhật cho ${users.length} users.`);

  } catch (error) {
    console.error("🛑 Lỗi khi seed dữ liệu:", error.message);
  } finally {
    if (connection) await connection.end();
    process.exit();
  }
}

seedUserScores();
