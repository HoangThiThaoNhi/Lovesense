const express = require('express');
const router = express.Router();
const adminController = require('../controllers/adminController');
const voucherController = require('../controllers/voucherController');
const { protect, isAdmin } = require('../middleware/authMiddleware');
const upload = require('../middleware/uploadMiddleware');

// Protect and verify admin for all routes in this file
router.use(protect);
router.use(isAdmin);

// Dashboard & Stats
router.get('/stats', adminController.getStats);
router.get('/logs', adminController.getAdminLogs);
router.get('/ai-stats', adminController.getAIStats);

// User Management
router.get('/users', adminController.getAllUsers);
router.post('/users', adminController.createUser);
router.put('/users/:id/status', adminController.updateUserStatus);
router.put('/users/:id/reset-password', adminController.resetUserPassword);
router.put('/users/:id/points', adminController.updateUserPoints);
router.post('/users/bulk-generate', upload.array('images'), adminController.bulkGenerateUsers);

// AI Question Management
router.get('/questions', adminController.getQuestions);
router.post('/questions', adminController.createQuestion);
router.post('/questions/suggest-logic', adminController.aiSuggestMappings);
router.put('/questions/:id', adminController.updateQuestion);
router.delete('/questions/:id', adminController.deleteQuestion);

// Gamification Management - Challenges
router.get('/challenges', adminController.getChallenges);
router.post('/challenges', adminController.createChallenge);
router.put('/challenges/:id', adminController.updateChallenge);
router.delete('/challenges/:id', adminController.deleteChallenge);

// Gamification Management - Badges
router.get('/badges', adminController.getBadges);
router.post('/badges', upload.single('icon'), adminController.createBadge);
router.put('/badges/:id', upload.single('icon'), adminController.updateBadge);
router.delete('/badges/:id', adminController.deleteBadge);

router.get('/gamification-stats', adminController.getGamificationStats);
router.get('/leaderboard', adminController.getLeaderboard);

// Voucher Management
router.get('/vouchers', voucherController.adminGetAllVouchers);
router.post('/vouchers', voucherController.adminCreateVoucher);
router.put('/vouchers/:id', voucherController.adminUpdateVoucher);
router.delete('/vouchers/:id', voucherController.adminDeleteVoucher);

module.exports = router;


