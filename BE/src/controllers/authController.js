const { User, Profile } = require('../models');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

const generateToken = (id) => {
    return jwt.sign({ id }, process.env.JWT_SECRET, {
        expiresIn: process.env.JWT_EXPIRES_IN
    });
};

// Simulated OTP storage (In-memory for demo, use Redis for production)
const otpStore = {};

exports.requestOTP = async (req, res) => {
    try {
        const { phone } = req.body;
        if (!phone) return res.status(400).json({ error: 'Phone number is required' });

        // Generate a random 6-digit OTP
        const otp = Math.floor(100000 + Math.random() * 900000).toString();
        otpStore[phone] = otp;

        // In a real app, send via SMS. Here, we return it for free testing.
        res.json({
            message: 'OTP sent (simulated)',
            otp: otp,
            note: 'In production, this would be sent via SMS and not returned in the API response.'
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.verifyOTP = async (req, res) => {
    try {
        const { phone, otp } = req.body;
        if (!phone || !otp) return res.status(400).json({ error: 'Phone and OTP are required' });

        if (otpStore[phone] !== otp) {
            return res.status(400).json({ error: 'Invalid OTP' });
        }

        // Clear OTP after use
        delete otpStore[phone];

        let user = await User.findByPhone(phone);
        if (!user) {
            // Auto-register if user doesn't exist
            const newUser = await User.create({ phone });
            
            // Initialize profile for new user
            await Profile.create({
                user_id: newUser.id,
                display_name: `User_${phone.slice(-4)}`,
                points: 0,
                current_title: 'Newbie'
            });

            user = { id: newUser.id, phone, status: newUser.status };
        }

        if (user.status === 'banned') {
            return res.status(403).json({ error: 'Tài khoản của bạn đã bị khóa. Vui lòng liên hệ hỗ trợ.' });
        }

        const token = generateToken(user.id);
        
        // AUTO-FIX: Ensure profile exists and get full user data
        let profile = await Profile.findOne({ where: { user_id: user.id } });
        if (!profile) {
            profile = await Profile.create({
                user_id: user.id,
                display_name: `User_${phone.slice(-4)}`,
                points: 0,
                current_title: 'Newbie'
            });
        }

        const fullUser = await User.findByPk(user.id);

        res.json({ 
            message: 'Login successful', 
            token, 
            user: { 
                id: fullUser.id, 
                phone: fullUser.phone, 
                full_name: fullUser.full_name,
                status: fullUser.status,
                ambition_score: fullUser.ambition_score,
                personality_score: fullUser.personality_score,
                career_score: fullUser.career_score,
                core_values_score: fullUser.core_values_score,
                interests_score: fullUser.interests_score,
                lifestyle_score: fullUser.lifestyle_score,
                family_orientation_score: fullUser.family_orientation_score
            } 
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.register = async (req, res) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) {
            return res.status(400).json({ error: 'Email and password are required' });
        }

        const existingUser = await User.findByEmail(email);
        if (existingUser) {
            return res.status(400).json({ error: 'Email already in use' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        const newUser = await User.create({ email, password: hashedPassword });

        // Initialize profile for new user
        await Profile.create({
            user_id: newUser.id,
            display_name: email.split('@')[0],
            points: 0,
            current_title: 'Newbie'
        });

        const user = { 
            id: newUser.id, 
            email: newUser.email, 
            role: newUser.role, 
            status: newUser.status,
            ambition_score: 0,
            personality_score: 0,
            career_score: 0,
            core_values_score: 0,
            interests_score: 0,
            lifestyle_score: 0,
            family_orientation_score: 0
        };
        const token = generateToken(newUser.id);

        console.log(`[AUTH] User registered: ${email}`);
        res.status(201).json({ message: 'User registered successfully', token, user });
    } catch (error) {
        console.error('[AUTH ERROR] Register:', error.message);
        res.status(500).json({ error: error.message });
    }
};

exports.login = async (req, res) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) {
            return res.status(400).json({ error: 'Email and password are required' });
        }

        const user = await User.findByEmail(email);
        if (!user || !user.password) {
            return res.status(401).json({ error: 'Sai tài khoản hoặc mật khẩu' });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(401).json({ error: 'Sai tài khoản hoặc mật khẩu' });
        }

        if (user.status === 'banned') {
            return res.status(403).json({ error: 'Tài khoản của bạn đã bị khóa. Vui lòng liên hệ hỗ trợ.' });
        }

        const token = generateToken(user.id);
        
        // SAFE RECOVERY: Only create profile if truly missing - NEVER overwrite existing data
        const existingProfile = await Profile.findOne({ where: { user_id: user.id } });
        if (!existingProfile) {
            console.log(`[AUTH] No profile for user ${user.id}, creating minimal profile...`);
            let defaultName = '';
            if (user.full_name && user.full_name.trim() !== '') {
                defaultName = user.full_name.trim();
            } else if (email) {
                defaultName = email.split('@')[0];
            } else if (user.phone) {
                defaultName = `User_${user.phone.slice(-4)}`;
            }

            await Profile.create({
                user_id: user.id,
                display_name: defaultName,
                points: 0,
                current_title: 'Newbie'
            });
            console.log(`[AUTH] Minimal profile created for user ${user.id}`);
        } else {
            console.log(`[AUTH] Existing profile found (ID: ${existingProfile.id}) for user ${user.id} - keeping intact`);
        }

        console.log(`[AUTH] User logged in: ${email}`);
        
        // Fetch profile data to include in login response
        const profileData = await Profile.findByUserId(user.id);
        
        res.json({ 
            message: 'Login successful', 
            token, 
            user: { 
                id: user.id, 
                email: user.email, 
                full_name: user.full_name,
                role: user.role, 
                status: user.status,
                ambition_score: user.ambition_score,
                personality_score: user.personality_score,
                career_score: user.career_score,
                core_values_score: user.core_values_score,
                interests_score: user.interests_score,
                lifestyle_score: user.lifestyle_score,
                family_orientation_score: user.family_orientation_score,
                // Include profile data directly in login response
                display_name: profileData?.display_name || user.full_name || '',
                age: profileData?.age || 0,
                bio: profileData?.bio || '',
                occupation: profileData?.occupation || '',
                gender: profileData?.gender || '',
                interests: profileData?.interests || [],
                living_at: profileData?.living_at || '',
                city: profileData?.city || '',
                district: profileData?.district || '',
                height: profileData?.height,
                purpose: profileData?.purpose,
                points: profileData?.points || 0,
                current_title: profileData?.current_title || 'Newbie',
            } 
        });
    } catch (error) {
        console.error('[AUTH ERROR] Login:', error.message);
        res.status(500).json({ error: error.message });
    }
};

exports.socialLogin = async (req, res) => {
    try {
        const { type, socialId, email, name } = req.body; // type: 'google', 'facebook', 'apple'
        // Mocking social login verification logic
        let user;
        // In real app, verify socialId with provider's token

        res.status(501).json({ message: 'Social login logic implementation placeholder' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.updatePassword = async (req, res) => {
    try {
        const { oldPassword, newPassword } = req.body;
        const userId = req.user.id;

        const user = await User.findByPk(userId);
        if (!user || !user.password) {
            return res.status(401).json({ error: 'User not found or password not set' });
        }

        const isMatch = await bcrypt.compare(oldPassword, user.password);
        if (!isMatch) {
            return res.status(400).json({ error: 'Mật khẩu cũ không chính xác' });
        }

        const hashedPassword = await bcrypt.hash(newPassword, 10);
        await user.update({ password: hashedPassword });

        res.json({ message: 'Đổi mật khẩu thành công' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.updateAccount = async (req, res) => {
    try {
        const { phone } = req.body;
        const userId = req.user.id;

        if (!phone) {
            return res.status(400).json({ message: 'Vui lòng cung cấp số điện thoại' });
        }

        await User.update({ phone }, { where: { id: userId } });

        res.json({
            status: 'success',
            message: 'Cập nhật số điện thoại thành công',
            data: { phone }
        });
    } catch (error) {
        console.error('Update Account Error:', error);
        res.status(500).json({ error: error.message });
    }
};

exports.deactivateAccount = async (req, res) => {
    try {
        const userId = req.user.id;
        await User.update({ status: 'inactive' }, { where: { id: userId } });
        res.json({ message: 'Tài khoản đã được chuyển sang chế độ không hoạt động' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.deleteAccount = async (req, res) => {
    try {
        const userId = req.user.id;
        // Permanently destroy the user (cascades to related data via DB constraints)
        await User.destroy({ where: { id: userId } });
        res.json({ message: 'Tài khoản đã được xóa vĩnh viễn' });
    } catch (error) {
        console.error('Delete Account Error:', error);
        res.status(500).json({ error: error.message });
    }
};
