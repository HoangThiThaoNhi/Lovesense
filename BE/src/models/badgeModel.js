const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Badge = sequelize.define('Badge', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    name: {
        type: DataTypes.STRING(100),
        allowNull: false
    },
    description: {
        type: DataTypes.TEXT
    },
    points_required: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    icon_url: {
        type: DataTypes.STRING(255)
    }
}, {
    tableName: 'badges'
});

module.exports = Badge;
