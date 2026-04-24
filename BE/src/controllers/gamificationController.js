const GamificationService = require('../services/gamificationService');

exports.getStatus = async (req, res) => {
    try {
        const userId = req.user.id;
        console.log(`[GamificationController] getStatus started for user: ${userId}`);
        
        const status = await GamificationService.getStatus(userId);
        
        console.log(`[GamificationController] getStatus completed successfully`);
        res.json(status);
    } catch (error) {
        console.error('[GamificationController Error]:', error);
        res.status(500).json({ error: error.message });
    }
};

exports.awardPointsManual = async (req, res) => {
    try {
        const { points, action } = req.body;
        const userId = req.user.id;
        const result = await GamificationService.awardPoints(userId, points, action);
        res.json(result);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getLeaderboard = async (req, res) => {
    try {
        const userId = req.user.id;
        const leaderboard = await GamificationService.getLeaderboard(userId);
        res.json(leaderboard);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
