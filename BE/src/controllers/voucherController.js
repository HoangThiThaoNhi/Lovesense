const { Voucher, UserVoucher, Badge, User, Notification } = require('../models');
const { Op } = require('sequelize');

// User Controllers
exports.getMyVouchers = async (req, res) => {
    try {
        const userId = req.user.id;
        const vouchers = await Voucher.findAll({
            include: [{
                model: User,
                as: 'users',
                where: { id: userId },
                through: { attributes: ['is_used', 'used_at', 'created_at'] }
            }, {
                model: Badge,
                as: 'badge',
                attributes: ['name', 'icon_url']
            }]
        });

        // Format the response to be cleaner for the frontend
        const formattedVouchers = vouchers.map(v => {
            const userVoucher = v.users[0].UserVoucher;
            return {
                id: v.id,
                code: v.code,
                name: v.name,
                description: v.description,
                badge: v.badge,
                is_used: userVoucher.is_used,
                used_at: userVoucher.used_at,
                earned_at: userVoucher.created_at,
                start_date: v.start_date,
                end_date: v.end_date,
                expiry_date: v.end_date // Alias for backward compatibility if needed
            };
        });

        // Sắp xếp theo thời gian nhận mới nhất
        formattedVouchers.sort((a, b) => new Date(b.earned_at) - new Date(a.earned_at));

        res.json(formattedVouchers);
    } catch (error) {
        console.error('[getMyVouchers] Error:', error);
        res.status(500).json({ error: error.message });
    }
};

// Admin Controllers
exports.adminGetAllVouchers = async (req, res) => {
    try {
        const vouchers = await Voucher.findAll({
            include: [{ model: Badge, as: 'badge', attributes: ['name'] }],
            order: [['created_at', 'DESC']]
        });
        res.json(vouchers);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.adminCreateVoucher = async (req, res) => {
    try {
        const { code, name, description, badge_id, start_date, end_date } = req.body;
        
        const now = new Date();
        const start = new Date(start_date);
        const end = new Date(end_date);

        if (start < now.setHours(0,0,0,0)) {
            return res.status(400).json({ error: 'Ngày bắt đầu phải là ngày hiện tại hoặc tương lai' });
        }
        if (end <= start) {
            return res.status(400).json({ error: 'Ngày kết thúc phải sau ngày bắt đầu' });
        }

        const existing = await Voucher.findOne({ where: { code } });
        if (existing) return res.status(400).json({ error: 'Mã voucher đã tồn tại' });

        const voucher = await Voucher.create({
            code,
            name,
            description,
            badge_id,
            start_date,
            end_date
        });

        // 3. Retroactive Assignment: Find all users who already have this badge
        const eligibleUsers = await User.findAll({
            include: [{
                model: Badge,
                as: 'badges',
                where: { id: badge_id },
                through: { attributes: [] }
            }]
        });

        if (eligibleUsers.length > 0) {
            const userVoucherPromises = eligibleUsers.map(user => {
                return UserVoucher.findOrCreate({
                    where: { user_id: user.id, voucher_id: voucher.id },
                    defaults: { user_id: user.id, voucher_id: voucher.id }
                }).then(([uv, created]) => {
                    if (created) {
                        return Notification.create({
                            user_id: user.id,
                            type: 'gift',
                            title: `Bạn nhận được quà tặng mới: ${voucher.name}! 🎁`,
                            content: `Tuyệt vời! Hệ thống vừa bổ sung một voucher mới cho huy hiệu "${eligibleUsers[0].badges[0].name}" bạn đang sở hữu.`,
                            metadata: { voucher_id: voucher.id }
                        });
                    }
                });
            });
            await Promise.all(userVoucherPromises);
        }

        res.status(201).json(voucher);
    } catch (error) {
        console.error('[adminCreateVoucher] Error:', error);
        res.status(500).json({ error: error.message });
    }
};

exports.adminUpdateVoucher = async (req, res) => {
    try {
        const { id } = req.params;
        const updates = req.body;
        
        const voucher = await Voucher.findByPk(id);
        if (!voucher) return res.status(404).json({ error: 'Voucher không tồn tại' });

        await voucher.update(updates);
        res.json(voucher);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.adminDeleteVoucher = async (req, res) => {
    try {
        const { id } = req.params;
        const voucher = await Voucher.findByPk(id);
        if (!voucher) return res.status(404).json({ error: 'Voucher không tồn tại' });

        await voucher.destroy();
        res.json({ message: 'Voucher đã được xóa thành công' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
