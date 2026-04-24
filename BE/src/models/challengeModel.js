const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Challenge = sequelize.define('Challenge', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    title: {
        type: DataTypes.STRING(255),
        allowNull: false
    },
    description: {
        type: DataTypes.TEXT
    },
    trigger_condition: {
        type: DataTypes.STRING(255), // e.g., 'after_match', 'after_1_day_chat'
        allowNull: false
    },
    reward_xp: {
        type: DataTypes.INTEGER,
        defaultValue: 0
    },
    reward_badge_id: {
        type: DataTypes.INTEGER,
        references: {
            model: 'badges',
            key: 'id'
        }
    },
    status: {
        type: DataTypes.ENUM('active', 'inactive'),
        defaultValue: 'active'
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {
    tableName: 'challenges',
    timestamps: false
});

module.exports = Challenge;
