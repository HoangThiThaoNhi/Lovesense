const { Notification } = require('../models');

exports.getNotifications = async (req, res) => {
    try {
        const userId = req.user.id;
        const notifications = await Notification.findAll({
            where: { user_id: userId },
            order: [['id', 'DESC']],
            limit: 50
        });
        res.json(notifications);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.markAsRead = async (req, res) => {
    try {
        const { id } = req.params;
        const userId = req.user.id;
        await Notification.update({ is_read: true }, {
            where: { id, user_id: userId }
        });
        res.json({ message: 'Notification marked as read' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.markAllAsRead = async (req, res) => {
    try {
        const userId = req.user.id;
        await Notification.update({ is_read: true }, {
            where: { user_id: userId, is_read: false }
        });
        res.json({ message: 'All notifications marked as read' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
