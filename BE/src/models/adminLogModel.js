const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const AdminLog = sequelize.define('AdminLog', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    admin_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: 'users',
            key: 'id'
        }
    },
    action: {
        type: DataTypes.STRING(255),
        allowNull: false
    },
    target: {
        type: DataTypes.STRING(255)
    },
    details: {
        type: DataTypes.TEXT
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {
    tableName: 'admin_logs',
    timestamps: false
});

module.exports = AdminLog;
