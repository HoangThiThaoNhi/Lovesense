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
    full_name: {
        type: DataTypes.STRING(191),
        allowNull: true
    },
    birthday: {
        type: DataTypes.DATEONLY,
        allowNull: true
    },
    email: {
        type: DataTypes.STRING(191),
        unique: true
    },
    password: {
        type: DataTypes.STRING(255)
    },
    gender: {
        type: DataTypes.STRING(20),
        allowNull: true
    },
    target_gender: {
        type: DataTypes.STRING(20),
        allowNull: true
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
    avatar_url: {
        type: DataTypes.TEXT,
        allowNull: true
    },
    bio: {
        type: DataTypes.TEXT,
        allowNull: true
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    },
    role: {
        type: DataTypes.ENUM('user', 'admin'),
        defaultValue: 'user'
    },
    status: {
        type: DataTypes.ENUM('active', 'banned', 'flagged', 'inactive'),
        defaultValue: 'active'
    },
    // DNA Scores
    ambition_score: {
        type: DataTypes.FLOAT,
        defaultValue: 0
    },
    personality_score: {
        type: DataTypes.FLOAT,
        defaultValue: 0
    },
    career_score: {
        type: DataTypes.FLOAT,
        defaultValue: 0
    },
    core_values_score: {
        type: DataTypes.FLOAT,
        defaultValue: 0
    },
    interests_score: {
        type: DataTypes.FLOAT,
        defaultValue: 0
    },
    lifestyle_score: {
        type: DataTypes.FLOAT,
        defaultValue: 0
    },
    family_orientation_score: {
        type: DataTypes.FLOAT,
        defaultValue: 0
    }
}, {
    tableName: 'users',
    timestamps: false
});

// Helper methods
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
