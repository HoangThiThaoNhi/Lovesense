const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const UserChallenge = sequelize.define('UserChallenge', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: 'users',
            key: 'id'
        }
    },
    challenge_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: 'challenges',
            key: 'id'
        }
    },
    status: {
        type: DataTypes.ENUM('in_progress', 'completed', 'failed'),
        defaultValue: 'in_progress'
    },
    progress: {
        type: DataTypes.INTEGER,
        defaultValue: 0
    },
    completed_at: {
        type: DataTypes.DATE
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {
    tableName: 'user_challenges',
    timestamps: false
});

module.exports = UserChallenge;
