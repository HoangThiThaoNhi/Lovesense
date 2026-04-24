const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const AIChat = sequelize.define('AIChat', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    session_id: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
    role: {
        type: DataTypes.ENUM('user', 'assistant'),
        allowNull: false
    },
    content: {
        type: DataTypes.TEXT,
        allowNull: false
    },
    type: {
        type: DataTypes.ENUM('interview', 'consult'),
        allowNull: false
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {
    tableName: 'ai_chats'
});

module.exports = AIChat;
