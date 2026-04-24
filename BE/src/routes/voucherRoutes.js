const express = require('express');
const router = express.Router();
const voucherController = require('../controllers/voucherController');
const { protect } = require('../middleware/authMiddleware');

router.get('/my', protect, voucherController.getMyVouchers);

module.exports = router;
