const cloudinary = require('cloudinary').v2;
const { CloudinaryStorage } = require('multer-storage-cloudinary');
const dotenv = require('dotenv');

dotenv.config();

console.log('Cloudinary Connection Initialized');

cloudinary.config({
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET,
    secure: true,
    timeout: 120000
});

const storage = new CloudinaryStorage({
    cloudinary: cloudinary,
    params: {
        folder: 'lovesense_profiles',
        allowed_formats: ['jpg', 'png', 'jpeg'],
        transformation: [{ width: 800, height: 800, crop: 'limit' }]
    },
});

module.exports = {
    cloudinary
};
