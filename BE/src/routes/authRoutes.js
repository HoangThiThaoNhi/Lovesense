const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

const { protect } = require('../middleware/authMiddleware');

router.post('/register', authController.register);
router.post('/login', authController.login);
router.post('/social-login', authController.socialLogin);
router.put('/update-password', protect, authController.updatePassword);
router.put('/update-account', protect, authController.updateAccount);
router.delete('/deactivate', protect, authController.deactivateAccount);
router.delete('/delete-account', protect, authController.deleteAccount);

module.exports = router;
