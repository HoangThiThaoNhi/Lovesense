const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const QuizQuestion = sequelize.define('QuizQuestion', {
    id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
    },
    content: {
        type: DataTypes.TEXT,
        allowNull: false
    },
    category_id: {
        type: DataTypes.STRING(50),
        allowNull: false // G1_PERSONALITY, G2_CORE_VALUES, etc.
    },
    status: {
        type: DataTypes.ENUM('draft', 'active', 'archived'),
        defaultValue: 'active'
    },
    priority: {
        type: DataTypes.INTEGER,
        defaultValue: 0
    },
    sub_category: {
        type: DataTypes.STRING(100),
        allowNull: true
    },
    weight: {
        type: DataTypes.INTEGER,
        defaultValue: 1
    },
    difficulty: {
        type: DataTypes.ENUM('easy', 'medium', 'hard'),
        defaultValue: 'medium'
    },
    type: {
        type: DataTypes.ENUM('mcq', 'open'),
        defaultValue: 'mcq'
    }
}, {
    tableName: 'quiz_questions',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at'
});

module.exports = QuizQuestion;
