const { Badge } = require('./src/models');
const sequelize = require('./src/config/db');

const badgesData = [
  {
    name: 'Trái Tim Đồng',
    description: 'Bắt đầu hành trình kết nối.',
    points_required: 100,
    icon_url: '/uploads/badges/badge_bronze_heart_1776884185608.png'
  },
  {
    name: 'Trái Tim Thuần Khiết',
    description: 'Gieo mầm những rung động đầu.',
    points_required: 250,
    icon_url: '/uploads/badges/badge_pure_heart_1776884202889.png'
  },
  {
    name: 'Trái Tim Bạc',
    description: 'Thành viên gắn kết chân thành.',
    points_required: 450,
    icon_url: '/uploads/badges/badge_silver_heart_1776884217529.png'
  },
  {
    name: 'Trái Tim Thấu Hiểu',
    description: 'Luôn mở lòng với mọi kết nối.',
    points_required: 700,
    icon_url: '/uploads/badges/badge_understanding_heart_1776884232886.png'
  },
  {
    name: 'Trái Tim Năng Động',
    description: 'Lan tỏa năng lượng tích cực.',
    points_required: 1000,
    icon_url: '/uploads/badges/badge_active_heart_1776884246912.png'
  },
  {
    name: 'Trái Tim Vàng',
    description: 'Người tình lý tưởng của cộng đồng.',
    points_required: 1400,
    icon_url: '/uploads/badges/badge_gold_heart_1776884261507.png'
  },
  {
    name: 'Trái Tim Tỏa Sáng',
    description: 'Sức hút khó cưỡng từ tâm hồn.',
    points_required: 1900,
    icon_url: '/uploads/badges/badge_shining_heart_1776884281225.png'
  },
  {
    name: 'Trái Tim Tinh Tú',
    description: 'Hội viên ưu tú và tin cậy.',
    points_required: 2500,
    icon_url: '/uploads/badges/badge_star_heart_1776884294425.png'
  },
  {
    name: 'Trái Tim Bạch Kim',
    description: 'Biểu tượng của sự gắn kết.',
    points_required: 3200,
    icon_url: '/uploads/badges/badge_platinum_heart_1776884308477.png'
  },
  {
    name: 'Trái Tim Kim Cương',
    description: 'Tri kỷ vĩnh cửu tại Lovesense.',
    points_required: 4000,
    icon_url: '/uploads/badges/badge_diamond_heart_1776884327176.png'
  }
];

async function seedBadges() {
  try {
    await sequelize.authenticate();
    console.log('Database connected.');

    // Optional: Clear existing badges if you want to replace them
    // await Badge.destroy({ where: {}, truncate: true });

    for (const badge of badgesData) {
      await Badge.findOrCreate({
        where: { name: badge.name },
        defaults: badge
      });
      console.log(`Created/Verified badge: ${badge.name}`);
    }

    console.log('Bulk badge creation complete!');
    process.exit(0);
  } catch (error) {
    console.error('Error seeding badges:', error);
    process.exit(1);
  }
}

seedBadges();
