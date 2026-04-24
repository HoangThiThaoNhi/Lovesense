const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Survey = sequelize.define('Survey', {
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
    category: {
        type: DataTypes.STRING(50),
        allowNull: true
    },
    question_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
        references: {
            model: 'questions',
            key: 'id'
        }
    },
    answer: {
        type: DataTypes.TEXT,
        allowNull: false
    },
    weight: {
        type: DataTypes.INTEGER,
        defaultValue: 1
    }
}, {
    tableName: 'surveys',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at'
});

module.exports = Survey;
