const express = require('express');
const router = express.Router();
const swipeController = require('../controllers/swipeController');
const { protect } = require('../middleware/authMiddleware');

router.get('/discovery', protect, swipeController.getDiscovery);
router.post('/survey', protect, swipeController.saveSurvey);
router.post('/reset', protect, swipeController.resetSwipes);
router.post('/', protect, swipeController.swipe);

module.exports = router;
