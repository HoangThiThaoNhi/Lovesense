const { User } = require('../models');
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
            user = { id: newUser.id, phone };
        }

        if (user.status === 'banned') {
            return res.status(403).json({ error: 'Tài khoản của bạn đã bị khóa. Vui lòng liên hệ hỗ trợ.' });
        }

        const token = generateToken(user.id);
        res.json({ message: 'Login successful', token, user: { id: user.id, phone: user.phone, status: user.status } });
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

        const user = { id: newUser.id, email, role: newUser.role, status: newUser.status };
        const token = generateToken(newUser.id);

        res.status(201).json({ message: 'User registered successfully', token, user });
    } catch (error) {
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
        res.json({ 
            message: 'Login successful', 
            token, 
            user: { 
                id: user.id, 
                email: user.email, 
                role: user.role, 
                status: user.status 
            } 
        });
    } catch (error) {
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
