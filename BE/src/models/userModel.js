const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const User = sequelize.define('User', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    phone: {
        type: DataTypes.STRING(20),
        unique: true
    },
    email: {
        type: DataTypes.STRING(191),
        unique: true
    },
    password: {
        type: DataTypes.STRING(255)
    },
    google_id: {
        type: DataTypes.STRING(191),
        unique: true
    },
    facebook_id: {
        type: DataTypes.STRING(191),
        unique: true
    },
    apple_id: {
        type: DataTypes.STRING(191),
        unique: true
    },
    role: {
        type: DataTypes.ENUM('user', 'admin'),
        defaultValue: 'user'
    },
    status: {
        type: DataTypes.ENUM('active', 'banned', 'flagged', 'inactive'),
        defaultValue: 'active'
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {
    tableName: 'users',
    timestamps: false // Giả định timestamps đã có trong schema
});

// Giữ lại các helper method cũ để hạn chế sửa controller quá nhiều
User.findById = async function (id) {
    return await User.findByPk(id);
};

User.findByPhone = async function (phone) {
    if (!phone) return null;
    return await User.findOne({ where: { phone } });
};

User.findByEmail = async function (email) {
    if (!email) return null;
    return await User.findOne({ where: { email } });
};

module.exports = User;
