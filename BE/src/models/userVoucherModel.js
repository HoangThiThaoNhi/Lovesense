const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const UserVoucher = sequelize.define('UserVoucher', {
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
    voucher_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: 'vouchers',
            key: 'id'
        }
    },
    is_used: {
        type: DataTypes.BOOLEAN,
        defaultValue: false
    },
    used_at: {
        type: DataTypes.DATE,
        allowNull: true
    }
}, {
    tableName: 'user_vouchers',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at'
});

module.exports = UserVoucher;
