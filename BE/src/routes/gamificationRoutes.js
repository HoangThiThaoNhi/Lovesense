const express = require('express');
const router = express.Router();
const gamificationController = require('../controllers/gamificationController');
const { protect } = require('../middleware/authMiddleware');

router.get('/status', protect, gamificationController.getStatus);
router.get('/leaderboard', protect, gamificationController.getLeaderboard);
router.post('/award', protect, gamificationController.awardPointsManual); // For testing or specific events

module.exports = router;
