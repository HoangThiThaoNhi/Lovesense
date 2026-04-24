const express = require('express');
const router = express.Router();
const profileController = require('../controllers/profileController');
const { protect } = require('../middleware/authMiddleware');
const upload = require('../middleware/uploadMiddleware');

router.get('/me', protect, profileController.getMyProfile);
router.post('/update', protect, profileController.updateProfile);
router.get('/signature', protect, profileController.getUploadSignature);
router.get('/:id', protect, profileController.getUserProfile);
router.post('/photos', protect, upload.array('photos', 9), profileController.uploadPhotos);
router.post('/photo-urls', protect, profileController.addPhotoUrls);
router.delete('/photos/:photoId', protect, profileController.deletePhoto);

module.exports = router;
