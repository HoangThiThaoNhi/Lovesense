const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Question = sequelize.define('Question', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    text: {
        type: DataTypes.TEXT,
        allowNull: false
    },
    category: {
        type: DataTypes.STRING(50),
        allowNull: false // e.g., 'Values', 'Lifestyle', 'Personality'
    },
    sub_category: {
        type: DataTypes.STRING(50),
        allowNull: true // e.g., 'Marriage', 'Finances', 'Communication'
    },
    weight: {
        type: DataTypes.INTEGER,
        defaultValue: 1 // 1-5 scale for importance
    },
    type: {
        type: DataTypes.ENUM('mcq', 'open'),
        defaultValue: 'mcq'
    },
    options: {
        type: DataTypes.TEXT, // Store JSON string for options
        allowNull: true
    },
    difficulty: {
        type: DataTypes.ENUM('easy', 'medium', 'hard'),
        defaultValue: 'medium'
    },
    status: {
        type: DataTypes.ENUM('active', 'draft', 'archived'),
        defaultValue: 'active'
    }
}, {
    tableName: 'questions',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at'
});

module.exports = Question;
