const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const QuizOption = sequelize.define('QuizOption', {
    id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
    },
    question_id: {
        type: DataTypes.UUID,
        allowNull: false
    },
    label: {
        type: DataTypes.TEXT,
        allowNull: false
    },
    /**
     * Mappings structure:
     * [
     *   {"criteria_id": "extroversion", "score_delta": 0.5},
     *   {"criteria_id": "career_ambition", "score_delta": -0.2}
     * ]
     */
    mappings: {
        type: DataTypes.JSON,
        allowNull: false,
        defaultValue: []
    },
    meta_hint: {
        type: DataTypes.STRING(100),
        allowNull: true
    }
}, {
    tableName: 'quiz_options',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at'
});

module.exports = QuizOption;
