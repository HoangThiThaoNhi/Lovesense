const express = require('express');
const router = express.Router();
const aiController = require('../controllers/aiController');
const { protect } = require('../middleware/authMiddleware');

router.post('/interview', protect, aiController.interview);
router.post('/consult', protect, aiController.consult);
router.post('/recommendations', protect, aiController.getRecommendations);
router.get('/questions', protect, aiController.getQuestions);
router.get('/history/:type/:session_id', protect, aiController.getChatHistory);
router.get('/sessions/:type', protect, aiController.getSessions);
router.post('/sessions', protect, aiController.createSession);
router.delete('/sessions/:id', protect, aiController.deleteSession);

module.exports = router;
