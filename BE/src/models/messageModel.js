const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Message = sequelize.define('Message', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    match_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    sender_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    content: {
        type: DataTypes.TEXT,
        allowNull: true // Can be null if it's an image-only message
    },
    message_type: {
        type: DataTypes.ENUM('text', 'image'),
        defaultValue: 'text'
    },
    image_url: {
        type: DataTypes.STRING(255),
        allowNull: true
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    },
    is_read: {
        type: DataTypes.BOOLEAN,
        defaultValue: false
    }
}, {
    tableName: 'messages'
});

// Helper methods cho controller cũ
Message.getByMatchId = async function (matchId) {
    return await Message.findAll({
        where: { match_id: matchId },
        order: [['created_at', 'ASC']]
    });
};

module.exports = Message;
