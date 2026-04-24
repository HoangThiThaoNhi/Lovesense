const { Match } = require('../models');
const sequelize = require('../config/db');
const { QueryTypes } = require('sequelize');

exports.getMatches = async (req, res) => {
    try {
        const userId = req.user.id;
        console.log(`[MatchController] Fetching matches for user: ${userId}`);

        // Optimized query: Use MAX(id) for last message to avoid timestamp collision
        const matches = await sequelize.query(`
            SELECT m.id as match_id, m.created_at as match_date, m.status, m.user1_id, m.user2_id,
                   p.user_id as profile_userid, p.display_name, p.age,
                   (SELECT image_url FROM photos WHERE user_id = p.user_id AND is_main = 1 LIMIT 1) as main_photo,
                   msg.content as last_message, 
                   msg.message_type as last_message_type,
                   msg.sender_id as last_sender_id,
                   msg.created_at as last_message_date,
                   msg.is_read
            FROM matches m
            JOIN profiles p ON (p.user_id = m.user1_id OR p.user_id = m.user2_id)
            LEFT JOIN (
                SELECT m1.*
                FROM messages m1
                WHERE m1.id IN (
                    SELECT MAX(id)
                    FROM messages
                    GROUP BY match_id
                )
            ) msg ON m.id = msg.match_id
            WHERE (m.user1_id = ? OR m.user2_id = ?) AND p.user_id != ? AND m.status != 'rejected'
            ORDER BY COALESCE(msg.created_at, m.created_at) DESC
        `, {
            replacements: [userId, userId, userId],
            type: QueryTypes.SELECT
        });

        console.log(`[MatchController] Found ${matches.length} matches`);

        const host = req.get('host') || '';
        const protocol = req.protocol || 'http';
        
        // Safety check for host to avoid crash
        let baseUrl = `${protocol}://${host}`;
        if (host.includes('localhost') || host.includes('127.0.0.1')) {
            baseUrl = `http://10.0.2.2:5000`; 
        }

        const formattedMatches = matches.map(m => {
            if (m.main_photo && m.main_photo.startsWith('/uploads/')) {
                m.main_photo = m.main_photo.startsWith('http') ? m.main_photo : `${baseUrl}${m.main_photo}`;
            }
            return m;
        });

        res.json(formattedMatches);
    } catch (error) {
        console.error('[MatchController Error]:', error);
        res.status(500).json({ error: error.message });
    }
};

exports.markAsRead = async (req, res) => {
    try {
        const { id } = req.params; // match_id
        const userId = req.user.id;

        // Mark all messages in this match sent by the OTHER user as read
        const { Message, Match } = require('../models');

        // Security check: ensure user is part of the match
        const match = await Match.findOne({
            where: {
                id,
                [require('sequelize').Op.or]: [
                    { user1_id: userId },
                    { user2_id: userId }
                ]
            }
        });

        if (!match) {
            return res.status(404).json({ error: 'Match not found' });
        }

        await Message.update(
            { is_read: true },
            {
                where: {
                    match_id: id,
                    sender_id: { [require('sequelize').Op.ne]: userId },
                    is_read: false
                }
            }
        );

        res.json({ message: 'Messages marked as read' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.deleteMatch = async (req, res) => {
    try {
        const { id } = req.params;
        const userId = req.user.id;

        const match = await Match.findOne({
            where: {
                id,
                [require('sequelize').Op.or]: [
                    { user1_id: userId },
                    { user2_id: userId }
                ]
            }
        });

        if (!match) {
            return res.status(404).json({ error: 'Match not found' });
        }

        await match.destroy();
        res.json({ message: 'Match deleted' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.acceptMatch = async (req, res) => {
    try {
        const { id } = req.params;
        const userId = req.user.id;
        const { Match } = require('../models');

        const match = await Match.findOne({
            where: {
                id: id,
                user2_id: userId, // Only the receiver can accept
                status: 'pending'
            }
        });

        if (!match) {
            return res.status(404).json({ error: 'Pending match not found' });
        }

        await match.update({ status: 'accepted' });
        res.json({ message: 'Match accepted' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.rejectMatch = async (req, res) => {
    try {
        const { id } = req.params;
        const userId = req.user.id;
        const { Match } = require('../models');

        const match = await Match.findOne({
            where: {
                id: id,
                user2_id: userId, // Only the receiver can reject
                status: 'pending'
            }
        });

        if (!match) {
            return res.status(404).json({ error: 'Pending match not found' });
        }

        await match.update({ status: 'rejected' });
        // Alternatively, we could destroy it: await match.destroy();
        res.json({ message: 'Match rejected' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
