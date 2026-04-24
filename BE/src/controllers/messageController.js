const { Message, Match } = require('../models');

exports.getMessages = async (req, res) => {
    try {
        const { matchId } = req.params;
        const userId = req.user.id;

        const isMatch = await Match.isMatched(matchId, userId);
        if (!isMatch) {
            return res.status(403).json({ error: 'You are not a part of this match' });
        }

        const messages = await Message.findAll({
            where: { match_id: matchId },
            order: [['created_at', 'ASC']]
        });
        res.json(messages);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.sendMessage = async (req, res) => {
    try {
        const { matchId, content, messageType, imageUrl } = req.body;
        const senderId = req.user.id;

        const isMatch = await Match.isMatched(matchId, senderId);
        if (!isMatch) {
            return res.status(403).json({ error: 'You can only message users you have matched with' });
        }

        const message = await Message.create({
            match_id: matchId,
            sender_id: senderId,
            content,
            message_type: messageType || 'text',
            image_url: imageUrl
        });
        res.json({ message: 'Message sent', messageId: message.id, message: message.toJSON() });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.deleteMessage = async (req, res) => {
    try {
        const { id } = req.params;
        const userId = req.user.id;

        const message = await Message.findByPk(id);
        if (!message) {
            return res.status(404).json({ error: 'Message not found' });
        }

        if (message.sender_id !== userId) {
            return res.status(403).json({ error: 'You can only delete your own messages' });
        }

        await message.destroy();
        res.json({ message: 'Message deleted' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.deleteConversation = async (req, res) => {
    try {
        const { matchId } = req.params;
        const userId = req.user.id;

        // Security check: ensure user is part of the match
        const isMatch = await Match.isMatched(matchId, userId);
        if (!isMatch) {
            return res.status(403).json({ error: 'You are not a part of this match' });
        }

        await Message.destroy({
            where: { match_id: matchId }
        });

        res.json({ message: 'Conversation deleted' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
