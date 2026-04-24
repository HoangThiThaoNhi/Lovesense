const express = require('express');
const router = express.Router();
const matchController = require('../controllers/matchController');
const { protect } = require('../middleware/authMiddleware');

router.get('/', protect, matchController.getMatches);
router.post('/:id/read', protect, matchController.markAsRead);
router.delete('/:id', protect, matchController.deleteMatch);
router.put('/:id/accept', protect, matchController.acceptMatch);
router.put('/:id/reject', protect, matchController.rejectMatch);

module.exports = router;
