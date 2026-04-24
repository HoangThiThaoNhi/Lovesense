const express = require('express');
const router = express.Router();
const messageController = require('../controllers/messageController');
const { protect } = require('../middleware/authMiddleware');

router.get('/:matchId', protect, messageController.getMessages);
router.post('/', protect, messageController.sendMessage);
router.delete('/:id', protect, messageController.deleteMessage);
router.delete('/conversation/:matchId', protect, messageController.deleteConversation);

module.exports = router;
