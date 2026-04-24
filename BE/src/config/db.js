const { Sequelize } = require('sequelize');
require('dotenv').config();

const sequelize = new Sequelize(
    process.env.DB_NAME,
    process.env.DB_USER,
    process.env.DB_PASSWORD,
    {
        host: process.env.DB_HOST,
        dialect: 'mysql',
        logging: false, // Tắt logging để console sạch hơn
        define: {
            timestamps: false, // Đã có sẵn cột created_at thủ công trong schema
            underscored: true
        }
    }
);

// Test kết nối
sequelize.authenticate()
    .then(() => console.log('Sequelize connected to MySQL.'))
    .catch(err => console.error('Sequelize connection error:', err));

module.exports = sequelize;
