const { User, Profile, Photo, Badge, UserBadge } = require('../models');

// Helper to fetch badges for a user
async function getBadgesForUser(userId) {
    try {
        return await Badge.findAll({
            include: [{
                model: UserBadge,
                where: { user_id: userId },
                attributes: ['earned_at']
            }],
            order: [['points_required', 'ASC']]
        });
    } catch (e) {
        return [];
    }
}
const { cloudinary } = require('../config/cloudinaryConfig');
const fs = require('fs');

exports.getMyProfile = async (req, res) => {
    try {
        const profile = await Profile.findByUserId(req.user.id);
        if (!profile) return res.status(404).json({ message: 'Profile not found' });
        const photos = await Photo.findAll({
            where: { user_id: req.user.id },
            order: [['order', 'ASC']],
            attributes: ['id', 'image_url', 'is_main', 'order']
        });
        const badges = await getBadgesForUser(req.user.id);
        const host = req.get('host');
        const protocol = req.protocol;
        const baseUrl = `${protocol}://${host}`;

        // Map gender back to App format
        if (profile.gender === 'male') profile.gender = 'nam';
        else if (profile.gender === 'female') profile.gender = 'nữ';
        else if (profile.gender === 'other') profile.gender = 'khác';

        res.json({
            ...profile,
            email: req.user.email,
            phone: req.user.phone,
            badges,
            photos: photos.map(p => {
                const photo = p.toJSON();
                if (photo.image_url && photo.image_url.startsWith('/uploads/')) {
                    photo.image_url = `${baseUrl}${photo.image_url}`;
                }
                return photo;
            })
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.updateProfile = async (req, res) => {
    try {
        const userId = req.user.id;
        const profileData = { ...req.body, user_id: userId };
        
        // Map Vietnamese gender from App to Backend ENUM
        if (profileData.gender) {
            const g = profileData.gender.toLowerCase();
            if (g === 'nam' || g === 'male') profileData.gender = 'male';
            else if (g === 'nữ' || g === 'female') profileData.gender = 'female';
            else profileData.gender = 'other';
        }

        // 1. Update Profile table
        const id = await Profile.upsert(profileData);

        // 2. Sync shared fields to User table
        const userUpdates = {};
        if (profileData.display_name) userUpdates.full_name = profileData.display_name;
        if (profileData.bio) userUpdates.bio = profileData.bio;
        if (profileData.gender) userUpdates.gender = profileData.gender;
        
        if (profileData.looking_for) {
            // If it's an array, join it into a string
            userUpdates.target_gender = Array.isArray(profileData.looking_for) 
                ? profileData.looking_for.join(',') 
                : profileData.looking_for;
        }
        
        if (Object.keys(userUpdates).length > 0) {
            await User.update(userUpdates, { where: { id: userId } });
        }

        res.json({ message: 'Profile updated successfully', id });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.uploadPhotos = async (req, res) => {
    try {
        if (!req.files || req.files.length === 0) {
            return res.status(400).json({ error: 'No files uploaded' });
        }

        const currentPhotos = await Photo.findAll({ where: { user_id: req.user.id } });
        if (currentPhotos.length + req.files.length > 9) {
            req.files.forEach(f => fs.unlinkSync(f.path));
            return res.status(400).json({ error: 'Maximum 9 photos allowed' });
        }

        const uploadedPhotoUrls = [];
        for (const file of req.files) {
            try {
                const result = await cloudinary.uploader.upload(file.path, {
                    folder: 'lovesense_profiles',
                    transformation: [{ width: 800, height: 800, crop: 'limit' }],
                    timeout: 120000
                });
                uploadedPhotoUrls.push(result.secure_url);
                fs.unlinkSync(file.path);
            } catch (err) {
                req.files.forEach(f => { if (fs.existsSync(f.path)) fs.unlinkSync(f.path); });
                throw err;
            }
        }

        const uploadPromises = uploadedPhotoUrls.map((imageUrl, index) => {
            const order = currentPhotos.length + index;
            return Photo.create({
                user_id: req.user.id,
                image_url: imageUrl,
                is_main: order === 0 && currentPhotos.length === 0,
                order: order
            });
        });

        await Promise.all(uploadPromises);
        res.json({ message: 'Photos uploaded successfully', photos: uploadedPhotoUrls });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getUploadSignature = async (req, res) => {
    try {
        const timestamp = Math.round(new Date().getTime() / 1000);
        const folder = 'lovesense_profiles';
        const signature = cloudinary.utils.api_sign_request(
            { timestamp, folder },
            process.env.CLOUDINARY_API_SECRET
        );
        res.json({
            signature,
            timestamp,
            cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
            api_key: process.env.CLOUDINARY_API_KEY,
            folder
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.addPhotoUrls = async (req, res) => {
    try {
        const { urls } = req.body;
        if (!urls || !Array.isArray(urls) || urls.length === 0) {
            return res.status(400).json({ error: 'No photo URLs provided' });
        }

        const currentPhotos = await Photo.findAll({ where: { user_id: req.user.id } });
        const uploadPromises = urls.map((imageUrl, index) => {
            const order = currentPhotos.length + index;
            return Photo.create({
                user_id: req.user.id,
                image_url: imageUrl,
                is_main: order === 0 && currentPhotos.length === 0,
                order: order
            });
        });

        await Promise.all(uploadPromises);
        res.json({ message: 'Photos saved successfully' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.deletePhoto = async (req, res) => {
    try {
        const { photoId } = req.params;
        await Photo.destroy({ where: { id: photoId, user_id: req.user.id } });
        res.json({ message: 'Photo deleted' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getUserProfile = async (req, res) => {
    try {
        const { id } = req.params;
        const profile = await Profile.findByUserId(id);
        if (!profile) return res.status(404).json({ message: 'Profile not found' });

        const photos = await Photo.findAll({
            where: { user_id: id },
            order: [['order', 'ASC']],
            attributes: ['id', 'image_url', 'is_main', 'order']
        });
        const badges = await getBadgesForUser(id);

        const host = req.get('host');
        const protocol = req.protocol;
        const baseUrl = `${protocol}://${host}`;

        // Map gender back to App format
        if (profile.gender === 'male') profile.gender = 'nam';
        else if (profile.gender === 'female') profile.gender = 'nữ';
        else if (profile.gender === 'other') profile.gender = 'khác';

        res.json({
            ...profile,
            badges,
            photos: photos.map(p => {
                const photo = p.toJSON();
                if (photo.image_url && photo.image_url.startsWith('/uploads/')) {
                    photo.image_url = `${baseUrl}${photo.image_url}`;
                }
                return photo;
            })
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
