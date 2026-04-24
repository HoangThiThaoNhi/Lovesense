const express = require('express');
const router = express.Router();
const quizController = require('../controllers/quizController');
const { protect, isAdmin } = require('../middleware/authMiddleware');

// App APIs
router.get('/', protect, (req, res) => quizController.getQuiz(req, res));
router.post('/submit', protect, (req, res) => quizController.submitAnswer(req, res));
router.get('/report', protect, (req, res) => quizController.generateDNAReport(req, res));

module.exports = router;
