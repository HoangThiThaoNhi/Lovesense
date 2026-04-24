const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Match = sequelize.define('Match', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    user1_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    user2_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    },
    status: {
        type: DataTypes.ENUM('pending', 'accepted', 'rejected'),
        defaultValue: 'pending'
    }
}, {
    tableName: 'matches'
});

// Legacy helpers cho controllers
Match.isMatched = async function (matchId, userId) {
    const { Op } = require('sequelize');
    const match = await Match.findOne({
        where: {
            id: matchId,
            [Op.or]: [
                { user1_id: userId },
                { user2_id: userId }
            ]
        }
    });
    return !!match;
};

module.exports = Match;
