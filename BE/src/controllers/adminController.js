const { User, Profile, AdminLog, Survey, Badge, Question, QuizQuestion, QuizOption, Challenge, UserChallenge, Match, Swipe, Message } = require('../models');
const { sequelize } = require('../models');
const { cloudinary } = require('../config/cloudinaryConfig');
const fs = require('fs');
const path = require('path');

const Photo = require('../models/photoModel');
const bcrypt = require('bcryptjs');
const aiService = require('../services/aiService');
const { Op, fn, col } = require('sequelize');

// Helper to log admin actions
const logAction = async (adminId, action, target, details = '') => {
    try {
        const newLog = await AdminLog.create({
            admin_id: adminId,
            action,
            target,
            details
        });
    } catch (error) {
        console.error('[logAction] Failed to log admin action:', error);
    }
};

exports.getAdminLogs = async (req, res) => {
    try {
        const { page = 1, limit = 15 } = req.query;
        const offset = (page - 1) * limit;

        const { count, rows: logs } = await AdminLog.findAndCountAll({
            include: [{
                model: User,
                as: 'admin',
                attributes: ['id', 'email'],
                include: [{ model: Profile, as: 'profile', attributes: ['display_name'] }]
            }],
            order: [['created_at', 'DESC']],
            offset: parseInt(offset),
            limit: parseInt(limit)
        });

        res.json({
            logs,
            total: count,
            page: parseInt(page),
            totalPages: Math.ceil(count / limit)
        });
    } catch (error) {
        console.error('[getAdminLogs] Error:', error);
        res.status(500).json({ error: error.message });
    }
};


exports.getStats = async (req, res) => {
    try {
        const totalUsers = await User.count();
        const activeUsers = await User.count({ where: { status: 'active' } });
        const bannedUsers = await User.count({ where: { status: 'banned' } });
        const flaggedUsers = await User.count({ where: { status: 'flagged' } });
        
        const totalMatches = await Match.count();
        const totalSwipes = await Swipe.count();
        const engagementRate = totalSwipes > 0 ? (totalMatches / totalSwipes * 100).toFixed(1) : 0;

        // Tỷ lệ tăng trưởng (tạm tính dựa trên số user so với mốc cơ bản hoặc tháng trước)
        const userGrowthRate = totalUsers > 0 ? ((activeUsers / totalUsers) * 100).toFixed(1) : 0;

        res.json({
            totalUsers,
            activeUsers,
            inactiveUsers: bannedUsers + flaggedUsers,
            newMatches: totalMatches, // Khớp với frontend
            engagementRate,           // Khớp với frontend
            userGrowthRate
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getAllUsers = async (req, res) => {
    try {
        const { search, status, page = 1, limit = 10 } = req.query;
        const offset = (page - 1) * limit;
        
        let where = {};
        
        if (status && status !== 'all') {
            where.status = status;
        }

        if (search) {
            where[Op.or] = [
                { email: { [Op.like]: `%${search}%` } },
                { id: { [Op.like]: `%${search}%` } },
                { '$profile.display_name$': { [Op.like]: `%${search}%` } }
            ];
        }

        const { count, rows: users } = await User.findAndCountAll({
            where,
            include: [{ model: Profile, as: 'profile' }],
            order: [['created_at', 'DESC']],
            offset: parseInt(offset),
            limit: parseInt(limit),
            subQuery: false // Required when searching on included model with limit
        });

        res.json({
            users,
            total: count,
            page: parseInt(page),
            totalPages: Math.ceil(count / limit)
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.createUser = async (req, res) => {
    try {
        const { email, password, role, status } = req.body;
        
        const existingUser = await User.findOne({ where: { email } });
        if (existingUser) return res.status(400).json({ error: 'Email đã tồn tại' });

        const hashedPassword = await bcrypt.hash(password, 10);
        const user = await User.create({
            email,
            password: hashedPassword,
            role: role || 'user',
            status: status || 'active'
        });

        // Initialize profile
        await Profile.create({
            user_id: user.id,
            display_name: email.split('@')[0],
            location: fn('ST_GeomFromText', 'POINT(0 0)')
        });

        await logAction(req.user.id, 'Tạo người dùng mới', `User ID: ${user.id}`);

        res.status(201).json(user);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.updateUserStatus = async (req, res) => {
    try {
        const { id } = req.params;
        const { status } = req.body;

        if (!['active', 'banned', 'flagged'].includes(status)) {
            return res.status(400).json({ error: 'Invalid status' });
        }

        const user = await User.findByPk(id);
        if (!user) return res.status(404).json({ error: 'User not found' });

        const oldStatus = user.status;
        user.status = status;
        await user.save();

        await logAction(
            req.user.id, 
            'Cập nhật trạng thái người dùng', 
            `User ID: ${id}`, 
            `Thay đổi từ ${oldStatus} sang ${status}`
        );

        res.json({ message: 'User status updated successfully', user });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.resetUserPassword = async (req, res) => {
    try {
        const { id } = req.params;
        const { newPassword } = req.body;

        if (!newPassword) return res.status(400).json({ error: 'New password is required' });

        const user = await User.findByPk(id);
        if (!user) return res.status(404).json({ error: 'User not found' });

        user.password = await bcrypt.hash(newPassword, 10);
        await user.save();

        await logAction(
            req.user.id, 
            'Đặt lại mật khẩu người dùng', 
            `User ID: ${id}`
        );

        res.json({ message: 'Password reset successfully' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.updateUserPoints = async (req, res) => {
    try {
        const { id } = req.params;
        const { points } = req.body;

        const profile = await Profile.findOne({ where: { user_id: id } });
        if (!profile) return res.status(404).json({ error: 'Profile not found' });

        const oldPoints = profile.points || 0;
        profile.points = parseInt(points);
        await profile.save();

        await logAction(
            req.user.id, 
            'Cập nhật điểm người dùng', 
            `User ID: ${id}`, 
            `Thay đổi từ ${oldPoints} sang ${points} XP`
        );

        res.json({ message: 'Cập nhật điểm thành công', points: profile.points });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.bulkGenerateUsers = async (req, res) => {
    const t = await sequelize.transaction();
    try {
        const { gender, looking_for } = req.body;
        const files = req.files;
        if (!files || files.length === 0) {
            return res.status(400).json({ error: 'Bạn phải upload ít nhất một ảnh để tạo người dùng.' });
        }

        const count = files.length;
        console.log(`[Bulk] Tạo nhanh ${count} người dùng (Local Random)...`);

        // Danh sách dữ liệu mẫu cực lớn để đảm bảo không trùng lặp cho 500+ người
        const surnames = ['Nguyễn', 'Trần', 'Lê', 'Phạm', 'Hoàng', 'Phan', 'Vũ', 'Đặng', 'Bùi', 'Đỗ', 'Hồ', 'Ngô', 'Dương', 'Lý', 'An', 'Trịnh', 'Đoàn', 'Mai', 'Trương', 'Lương', 'Võ', 'Đào', 'Đinh', 'Mã', 'Kim', 'Lâm', 'Thạch', 'Quách', 'Cổ', 'Giang', 'Uông', 'Tạ', 'Bạch', 'Sử', 'Khổng', 'Văn', 'Phùng', 'Lục', 'Mao', 'Tào'];
        const maleNames = ['Anh', 'Đức', 'Kiệt', 'Bảo', 'Huy', 'Nam', 'Phước', 'Thắng', 'Mạnh', 'Tùng', 'Tiệp', 'Hiếu', 'Quân', 'Vinh', 'Long', 'Hải', 'Tuân', 'Hùng', 'Minh', 'Khang', 'Duy', 'Cường', 'Sơn', 'Lâm', 'Thanh', 'Quang', 'Trung', 'Việt', 'Tâm', 'Phong', 'Thành', 'Hoàng', 'Khôi', 'Nhật', 'Sáng', 'Tú', 'Ân', 'Bình', 'Chính', 'Danh', 'Đại', 'Hợp', 'Kỳ', 'Lợi', 'Nghĩa', 'Phát', 'Quốc', 'Tấn', 'Uy', 'Trọng', 'Sơn', 'Lâm', 'Thạch', 'Hữu', 'Công', 'Toàn', 'Minh', 'Vũ', 'Trí', 'Tài', 'Khánh'];
        const femaleNames = ['Chi', 'Thảo', 'Trang', 'Ngọc', 'Anh', 'Giang', 'Dung', 'Diệp', 'Huyền', 'Uyên', 'Mai', 'Tuyết', 'Phương', 'Linh', 'Trinh', 'Nhi', 'Hà', 'Vy', 'Yến', 'My', 'Hạnh', 'Hoa', 'Thương', 'Quỳnh', 'Bích', 'Lan', 'Kim', 'Vân', 'Thư', 'Hương', 'Diệu', 'Ngân', 'Tâm', 'Ánh', 'Băng', 'Cát', 'Đào', 'Hạ', 'Khê', 'Liên', 'Mây', 'Nga', 'Oanh', 'Phúc', 'Quế', 'San', 'Trà', 'Xuyến', 'Kiều', 'Diễm', 'Lệ', 'Quyên', 'Gia', 'Bảo', 'Nguyệt', 'Hồng', 'Minh', 'Thanh', 'Thu', 'Đông', 'Xuân', 'Hạ'];
        
        const jobs = [
            'Freelancer', 'Designer', 'Software Engineer', 'KOC / TikToker', 'Marketing Agency', 'Student', 'Photographer', 'Business Owner', 
            'Chef', 'Barista', 'Model', 'Streamer', 'Teacher', 'Accountant', 'Sales Manager', 'Doctor', 'Architect', 'Nurse', 'Banker', 
            'Yoga Instructor', 'Makeup Artist', 'Lawyer', 'Flight Attendant', 'Dancer', 'Content Creator', 'Social Media Specialist',
            'Pilot', 'Web Developer', 'E-commerce Manager', 'Fashion Stylist', 'Interior Designer', 'Personal Trainer', 'Real Estate Agent',
            'Business Analyst', 'Project Manager', 'Data Scientist', 'Journalist', 'Copywriter', 'Pharmacist', 'Veterinary', 'Stock Trader',
            'Film Director', 'Music Producer', 'Illustrator', 'Barber', 'Travel Blogger', 'Event Planner', 'Human Resources', 'Nutritionist'
        ];
        
        const locations = ['Ha Noi', 'TP. Ho Chi Minh', 'Da Nang', 'Can Tho', 'Hai Phong', 'Da Lat', 'Nha Trang', 'Vung Tau', 'Hue', 'Buon Ma Thuot', 'Phu Quoc', 'Ha Long', 'Sapa', 'Quy Nhon', 'Phan Thiet', 'Pleiku', 'Vinh', 'Rach Gia', 'Long Xuyen', 'Soc Trang', 'Vinh Long', 'Bac Lieu', 'Ca Mau'];
        
        const interestsList = [
            'Âm nhạc', 'Du lịch', 'Xem phim', 'Chạy bộ', 'Nấu ăn', 'Boardgame', 'Cà phê', 'Tarot', 'Gym', 'Thú cưng', 'Đọc sách', 'Phượt', 
            'Liên quân', 'TikTok', 'Chụp ảnh', 'Vẽ tranh', 'Bơi lội', 'Yoga', 'Shopping', 'Cầu lông', 'Bóng đá', 'Netflix', 'Sơn móng tay', 'Chill',
            'Leo núi', 'Nhảy hiện đại', 'Boxing', 'Podcast', 'Thêu thùa', 'Làm gốm', 'Bắn cung', 'Camping', 'Đạp xe', 'Golf', 'Tennis', 'Meditation',
            'Lego', 'Thủy sinh', 'Đồng hồ', 'Nước hoa', 'Trà đạo', 'Sưu tầm giày', 'Vlog', 'Coding', 'Crypto', 'Kinh doanh', 'Phật pháp', 'Tình nguyện'
        ];
        
        const bios = [
            'Thích những thứ nhẹ nhàng, yêu màu hồng và ghét sự giả dối. ✨',
            'Tìm một người cùng đi ăn sập Sài Gòn. 🍕🍜',
            'Hướng nội nhưng khi gặp đúng người thì mỏ hỗn cực kỳ. 😎',
            'Life is short, smile while you still have teeth. 😁',
            'Thanh xuân như một tách trà, trà mà không sữa thì không vui. 🧋',
            'Mê chó, yêu mèo và muốn tìm người cùng yêu mình. 🐶🐱',
            'Không cần người quá tốt, chỉ cần người thương mình thật lòng. ❤️',
            'Nếu bạn đang tìm một người vừa xinh vừa điên thì là mình đây. 🤪',
            'Work hard, travel harder. ✈️🌍',
            'Chỉ muốn tìm một người cùng đi dạo phố buổi tối. 🌃',
            'Cafe không anh? ☕',
            'Thích sự chân thành và những cuộc trò chuyện sâu sắc. 🗣️',
            'Học cách yêu bản thân trước khi yêu người khác. ✨',
            'Gu mình là những người có chiều sâu. 🧠',
            'Mê mẩn những hoàng hôn rực rỡ. 🌅',
            'Một chút hướng ngoại, một chút hướng nội. 🌓',
            'Sống hết mình with đam mê. 🔥',
            'Yêu cái đẹp và sự tử tế. 🌸',
            'Thích những chuyến đi ngẫu hứng. 🚗',
            'Đơn giản là chính mình. 🙋‍♂️',
            'Yêu chó mèo, thích chill cuối tuần với một tách cà phê. ☕',
            'Cần một người để cùng đi phượt Đà Lạt ngay lúc này. 🛵💨',
            'Chỉ là một người bình thường đang đi tìm sự bình yên. 🌿',
            'Flex một chút về sự độc thân lâu năm của mình. 🚩',
            'Đi đâu cũng được, miễn là đi cùng nhau. ❤️',
            'Năng lượng tích cực, yêu đời, yêu người. 🔥',
            'Check var sự chân thành của bạn tại đây! ✅',
            'Bên ngoài lạnh lùng bên trong nhiều tiền (mơ thôi). 💸',
            'Thích đọc sách và nghe nhạc Indie. 🎶',
            'Mê đồ ăn ngon và những cuộc hẹn ngẫu hứng. 🍕',
            'Tìm người cùng tần số. 📶',
            'Sống đơn giản cho đời thanh thản. 🌱',
            'Đang học cách chữa lành tâm hồn bằng những chuyến đi. 🧘‍♀️',
            'Mê công nghệ và những món đồ gadget mới lạ. 💻',
            'Yêu âm thanh của mưa và mùi sách mới. 🌧️📚',
            'Cuộc đời là những chuyến đi, và mình vẫn đang đi tìm bến đỗ. ⚓',
            'Nghiện công việc nhưng vẫn muốn dành thời gian cho người quan trọng. 💼❤️',
            'Thích sự tối giản nhưng cảm xúc thì không. ☁️',
            'Nếu bạn có gu âm nhạc tốt, chúng ta là bạn. 🎧'
        ];

        const aiIdealDescriptions = [
            'Một người trưởng thành, có chí tiến thủ và biết lắng nghe.',
            'Bạn đời lý tưởng là người yêu động vật và thích du lịch khám phá.',
            'Tìm một người có cùng đam mê công nghệ và lối sống tối giản.',
            'Thích người vui vẻ, năng lượng tích cực và yêu thích thể thao.',
            'Hy vọng tìm được người chân thành, tinh tế và biết quan tâm.',
            'Người ấy nên là một người có tâm hồn nghệ sĩ và yêu cái đẹp.',
            'Tìm kiếm một người thông minh, có chiều sâu và cá tính mạnh.',
            'Thích người giản dị, mộc mạc và yêu thiên nhiên.'
        ];

        const aiKeywordGroups = [
            ['Chân thành', 'Lắng nghe', 'Trưởng thành'],
            ['Vui vẻ', 'Năng động', 'Thể thao'],
            ['Thông minh', 'Sáng tạo', 'Cá tính'],
            ['Tinh tế', 'Lãng mạn', 'Nhẹ nhàng'],
            ['Tự do', 'Du lịch', 'Khám phá'],
            ['Tối giản', 'Gia đình', 'Tử tế']
        ];

        const purposes = ['Người yêu', 'Bạn bè', 'Bất kỳ'];
        const titles = ['Newbie', 'Friendly Partner', 'Trusted Match', 'Top Choice', 'Golden Soul'];

        const createdUsers = [];

        // Lấy vị trí của admin để tạo người dùng xung quanh admin
        const adminProfile = await Profile.findOne({ where: { user_id: req.user.id } });
        let baseLng = 105.8544; // Mặc định Hà Nội
        let baseLat = 21.0285;

        if (adminProfile && adminProfile.location && adminProfile.location.coordinates) {
            baseLng = adminProfile.location.coordinates[0];
            baseLat = adminProfile.location.coordinates[1];
            console.log(`[Bulk] Tạo người dùng xung quanh vị trí Admin: ${baseLat}, ${baseLng}`);
        } else {
            console.log(`[Bulk] Admin chưa có vị trí, mặc định tạo tại Hà Nội`);
        }

        for (let i = 0; i < count; i++) {
            const currentGender = gender === 'Tất cả' ? (Math.random() > 0.5 ? 'Nam' : 'Nữ') : gender;
            const currentLookingFor = looking_for === 'Tất cả' ? (currentGender === 'Nam' ? 'Nữ' : 'Nam') : looking_for;
            
            const randomSurname = surnames[Math.floor(Math.random() * surnames.length)];
            const randomName = currentGender === 'Nam' 
                ? `${randomSurname} ${maleNames[Math.floor(Math.random() * maleNames.length)]}`
                : `${randomSurname} ${femaleNames[Math.floor(Math.random() * femaleNames.length)]}`;
            const randomAge = Math.floor(Math.random() * 28) + 18; // 18-45
            const randomJob = jobs[Math.floor(Math.random() * jobs.length)];
            const randomLocation = locations[Math.floor(Math.random() * locations.length)];
            const randomBio = bios[Math.floor(Math.random() * bios.length)];
            const interestCount = Math.floor(Math.random() * 4) + 3; // 3-6 interests
            const randomInterests = interestsList.sort(() => 0.5 - Math.random()).slice(0, interestCount);
            
            const randomIdeal = aiIdealDescriptions[Math.floor(Math.random() * aiIdealDescriptions.length)];
            const randomKeywords = aiKeywordGroups[Math.floor(Math.random() * aiKeywordGroups.length)];
            const randomPurpose = purposes[Math.floor(Math.random() * purposes.length)];
            const randomPoints = Math.floor(Math.random() * 800);
            const randomTitle = randomPoints > 600 ? 'Golden Soul' : (randomPoints > 400 ? 'Top Choice' : (randomPoints > 200 ? 'Trusted Match' : 'Newbie'));

            const email = `user${Date.now()}${i}@lovesense.ai`;
            const password = await bcrypt.hash('123456', 10);

            // 1. Create User
            const user = await User.create({
                email,
                password,
                role: 'user',
                status: 'active'
            }, { transaction: t });

            // 2. Upload image to Cloudinary
            let avatarUrl = '';
            if (files[i]) {
                const result = await cloudinary.uploader.upload(files[i].path, {
                    folder: 'lovesense/avatars'
                });
                avatarUrl = result.secure_url;
                if (fs.existsSync(files[i].path)) fs.unlinkSync(files[i].path);
            }

            // 3. Normalize gender for DB
            const dbGender = currentGender === 'Nam' ? 'male' : 'female';

            // 4. Create Profile
            await Profile.create({
                user_id: user.id,
                display_name: randomName,
                age: randomAge,
                gender: dbGender,
                looking_for: currentLookingFor,
                location: { type: 'Point', coordinates: [baseLng + (Math.random() * 0.05 - 0.025), baseLat + (Math.random() * 0.05 - 0.025)] },
                occupation: randomJob,
                living_at: randomLocation,
                height: Math.floor(Math.random() * 35) + 150, // 150-185
                bio: randomBio,
                purpose: randomPurpose, 
                interests: randomInterests,
                avatar: avatarUrl,
                points: randomPoints,
                current_title: randomTitle,
                ai_ideal_description: randomIdeal,
                ai_match_keywords: randomKeywords
            }, { transaction: t });

            // 5. Create Photo entry for Flutter carousel
            if (avatarUrl) {
                await Photo.create({
                    user_id: user.id,
                    image_url: avatarUrl,
                    is_main: true,
                    order: 0
                }, { transaction: t });
            }

            createdUsers.push(user.id);
        }

        await t.commit();

        await logAction(
            req.user.id,
            'Tạo người dùng hàng loạt (Local)',
            `Số lượng: ${count}`,
            `Đã tạo ${count} tài khoản demo bằng bộ sinh ngẫu nhiên`
        );

        res.json({ message: `Đã tạo thành công ${count} người dùng`, count });
    } catch (error) {
        if (t) await t.rollback();
        console.error("Bulk Generate Error:", error);
        res.status(500).json({ error: error.message });
    }
};


// AI Question Management (DNA Quiz System)
exports.getQuestions = async (req, res) => {
    try {
        const questions = await QuizQuestion.findAll({
            include: [{ model: QuizOption, as: 'options' }],
            order: [['created_at', 'DESC']]
        });

        // Map to old format for frontend compatibility
        const formattedQuestions = questions.map(q => {
            const data = q.toJSON();
            return {
                ...data,
                text: data.content,         // Map content to text
                category: data.category_id, // Map category_id to category
                // Options are already an array if fetched via Sequelize include
                options: data.options 
            };
        });

        res.json(formattedQuestions);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.createQuestion = async (req, res) => {
    try {
        const { content, text, category_id, category, priority, sub_category, weight, difficulty, type, options } = req.body;
        
        const finalContent = content || text;
        const finalCategoryId = category_id || category;

        if (!finalContent || !finalCategoryId) {
            return res.status(400).json({ error: 'Nội dung và phân loại là bắt buộc' });
        }

        const question = await QuizQuestion.create({ 
            content: finalContent, 
            category_id: finalCategoryId, 
            priority: priority || 0,
            sub_category,
            weight: weight || 1,
            difficulty: difficulty || 'medium',
            type: type || 'mcq',
            status: 'active'
        });
        
        if (options) {
            let optionsToCreate = [];
            if (typeof options === 'string' && options.trim().length > 0) {
                // Parse semi-colon separated string from CMS
                optionsToCreate = options.split(';').map(label => ({
                    label: label.trim(),
                    question_id: question.id,
                    mappings: [] // Will need AI mapping or manual edit later
                })).filter(opt => opt.label.length > 0);
            } else if (Array.isArray(options)) {
                optionsToCreate = options.map(opt => ({
                    ...opt,
                    question_id: question.id
                }));
            }

            if (optionsToCreate.length > 0) {
                await QuizOption.bulkCreate(optionsToCreate);
            }
        }
        
        await logAction(req.user.id, 'Tạo câu hỏi DNA Quiz mới', `Question ID: ${question.id}`);
        res.status(201).json(question);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

/**
 * AI Suggestion for CMS Logic Builder
 */
exports.aiSuggestMappings = async (req, res) => {
    try {
        const { question, options, category_id } = req.body;
        const suggestion = await aiService.suggestQuizLogic(question, options, category_id);
        res.json(suggestion);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.updateQuestion = async (req, res) => {
    try {
        const { id } = req.params;
        const { content, text, category_id, category, priority, sub_category, weight, difficulty, type, status, options } = req.body;
        const question = await QuizQuestion.findByPk(id);
        if (!question) return res.status(404).json({ error: 'Question not found' });

        await question.update({
            content: content || text,
            category_id: category_id || category,
            priority,
            sub_category,
            weight,
            difficulty,
            type,
            status
        });

        // Handle options update if provided
        if (options && typeof options === 'string') {
            await QuizOption.destroy({ where: { question_id: id } });
            const optionsToCreate = options.split(';').map(label => ({
                label: label.trim(),
                question_id: id,
                mappings: []
            })).filter(opt => opt.label.length > 0);
            
            if (optionsToCreate.length > 0) {
                await QuizOption.bulkCreate(optionsToCreate);
            }
        }
        await logAction(req.user.id, 'Cập nhật câu hỏi DNA', `Question ID: ${id}`);
        res.json(question);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.deleteQuestion = async (req, res) => {
    try {
        const { id } = req.params;
        const question = await QuizQuestion.findByPk(id);
        if (!question) return res.status(404).json({ error: 'Question not found' });

        await question.update({ status: 'archived' });
        await logAction(req.user.id, 'Lưu trữ câu hỏi DNA', `Question ID: ${id}`);
        res.json({ message: 'Question archived successfully' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// Gamification Management
exports.getChallenges = async (req, res) => {
    try {
        const challenges = await Challenge.findAll({
            include: [{ model: Badge, as: 'rewardBadge', attributes: ['name', 'icon_url'] }]
        });
        res.json(challenges);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.createChallenge = async (req, res) => {
    try {
        const { title, description, trigger_condition, reward_xp, reward_badge_id, status } = req.body;
        const challenge = await Challenge.create({
            title,
            description,
            trigger_condition,
            reward_xp,
            reward_badge_id,
            status: status || 'active'
        });
        await logAction(req.user.id, 'Tạo thử thách mới', `Challenge ID: ${challenge.id}`);
        res.status(201).json(challenge);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.updateChallenge = async (req, res) => {
    try {
        const { id } = req.params;
        const updates = req.body;
        const challenge = await Challenge.findByPk(id);
        if (!challenge) return res.status(404).json({ error: 'Challenge not found' });

        await challenge.update(updates);
        await logAction(req.user.id, 'Cập nhật thử thách', `Challenge ID: ${id}`);
        res.json(challenge);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// AI Statistics & Analytics
exports.getAIStats = async (req, res) => {
    try {
        // 1. Matching Metrics (Real Data)
        const totalSwipes = await Swipe.count();
        const totalMatches = await Match.count();
        const matchRate = totalSwipes > 0 ? (totalMatches / totalSwipes * 100).toFixed(1) : 0;

        // Matches with at least one message
        const matchesWithChat = await Message.count({
            distinct: true,
            col: 'match_id'
        });
        const chatRate = totalMatches > 0 ? (matchesWithChat / totalMatches * 100).toFixed(1) : 0;

        // 2. AI Effectiveness (Comparison)
        // AI matches could be defined as matches where both users have completed the survey
        const userIdsWithSurveys = await Survey.findAll({
            attributes: [
                [fn('DISTINCT', col('user_id')), 'user_id']
            ],
            raw: true
        });
        const surveyUserIds = userIdsWithSurveys.map(s => s.user_id);

        const aiMatches = await Match.count({
            where: {
                user1_id: { [Op.in]: surveyUserIds },
                user2_id: { [Op.in]: surveyUserIds }
            }
        });

        const aiEffectiveness = totalMatches > 0 ? (aiMatches / totalMatches * 100).toFixed(1) : 0;

        // 3. User Behavior
        const totalUserCount = await User.count({ where: { role: 'user' } });
        const surveyCompletionCount = surveyUserIds.length;
        const completionRate = totalUserCount > 0 ? (surveyCompletionCount / totalUserCount * 100).toFixed(1) : 0;

        // Generate simple time series for charts (last 7 days)
        const timeSeries = [];
        for (let i = 6; i >= 0; i--) {
            const date = new Date();
            date.setDate(date.getDate() - i);
            const dateString = date.toISOString().split('T')[0];
            
            const count = await Match.count({
                where: {
                    created_at: {
                        [Op.gte]: new Date(date.setHours(0,0,0,0)),
                        [Op.lte]: new Date(date.setHours(23,59,59,999))
                    }
                }
            });
            
            timeSeries.push({
                date: dateString,
                count: count
            });
        }

        res.json({
            totalSurveys: surveyCompletionCount,
            completionRate,
            effectiveness: aiEffectiveness,
            chatRate,
            matchRate,
            timeSeries
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.deleteChallenge = async (req, res) => {
    try {
        const { id } = req.params;
        const challenge = await Challenge.findByPk(id);
        if (!challenge) return res.status(404).json({ error: 'Challenge not found' });

        await challenge.destroy();
        await logAction(req.user.id, 'Xóa thử thách', `Challenge ID: ${id}`);
        res.json({ message: 'Challenge deleted successfully' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getGamificationStats = async (req, res) => {
    try {
        const totalChallenges = await Challenge.count();
        const totalCompletions = await UserChallenge.count({ where: { status: 'completed' } });
        const epicChallenges = await Challenge.count({
            where: {
                reward_xp: { [Op.gte]: 1000 }
            }
        });

        const totalUsers = await User.count({ where: { role: 'user' } });
        const avgCompletionRate = totalUsers > 0 ? ((totalCompletions / totalUsers) * 100).toFixed(1) : 0;

        res.json({
            totalChallenges,
            totalCompletions,
            epicChallenges,
            avgCompletionRate: `${avgCompletionRate}%`
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getLeaderboard = async (req, res) => {
    try {
        const leaderboard = await Profile.findAll({
            attributes: ['display_name', 'points', 'user_id'],
            include: [{
                model: User,
                attributes: ['email']
            }],
            order: [['points', 'DESC']],
            limit: 10
        });

        // Formatting for frontend
        const formattedLeaderboard = leaderboard.map((p, index) => ({
          rank: index + 1,
          name: p.display_name,
          points: p.points,
          email: p.User?.email,
          avatar: `https://api.dicebear.com/7.x/avataaars/svg?seed=${p.display_name}`
        }));

        res.json(formattedLeaderboard);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// Badge Management
exports.getBadges = async (req, res) => {
    try {
        const badges = await Badge.findAll({
            order: [['points_required', 'ASC']]
        });
        res.json(badges);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.createBadge = async (req, res) => {
    try {
        const { name, description, points_required } = req.body;
        let icon_url = req.body.icon_url;

        // If a file is uploaded, upload to Cloudinary and cleanup local file
        if (req.file) {
            try {
                const result = await cloudinary.uploader.upload(req.file.path, {
                    folder: 'lovesense_badges',
                    transformation: [{ width: 512, height: 512, crop: 'limit' }]
                });
                icon_url = result.secure_url;
                if (fs.existsSync(req.file.path)) fs.unlinkSync(req.file.path);
            } catch (err) {
                if (fs.existsSync(req.file.path)) fs.unlinkSync(req.file.path);
                console.error('[AdminBadge] Cloudinary upload error:', err);
                return res.status(500).json({ error: 'Failed to upload icon to Cloudinary' });
            }
        }



        const badge = await Badge.create({
            name,
            description,
            points_required,
            icon_url
        });

        await logAction(req.user.id, 'Tạo huy hiệu mới', `Badge ID: ${badge.id}`);
        res.status(201).json(badge);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.updateBadge = async (req, res) => {
    try {
        const { id } = req.params;
        const { name, description, points_required } = req.body;
        let icon_url = req.body.icon_url;

        const badge = await Badge.findByPk(id);
        if (!badge) return res.status(404).json({ error: 'Badge not found' });

        // If a new file is uploaded, upload to Cloudinary and cleanup local file
        if (req.file) {
            try {
                const result = await cloudinary.uploader.upload(req.file.path, {
                    folder: 'lovesense_badges',
                    transformation: [{ width: 512, height: 512, crop: 'limit' }]
                });
                icon_url = result.secure_url;
                if (fs.existsSync(req.file.path)) fs.unlinkSync(req.file.path);
            } catch (err) {
                if (fs.existsSync(req.file.path)) fs.unlinkSync(req.file.path);
                console.error('[AdminBadgeEdit] Cloudinary upload error:', err);
                // Continue with existing icon if upload fails during update? 
                // Better to throw error to inform user.
                return res.status(500).json({ error: 'Failed to upload new icon to Cloudinary' });
            }
        }


        await badge.update({
            name,
            description,
            points_required,
            icon_url: icon_url || badge.icon_url
        });

        // Trigger retroactive evaluation asynchronously
        const GamificationService = require('../services/gamificationService');
        const { Profile, Notification } = require('../models');
        const { Op } = require('sequelize');

        (async () => {
            try {
                // 1. Sync eligible users
                const eligibleProfiles = await Profile.findAll({
                    where: { points: { [Op.gte]: points_required } }
                });
                for (const profile of eligibleProfiles) {
                    await GamificationService.awardPoints(profile.user_id, 0, 'Hệ thống cập nhật yêu cầu huy hiệu');
                }
                console.log(`[Admin] Retroactively synced badges for ${eligibleProfiles.length} eligible users.`);

                // 2. Send broadcast notification to all users
                const allProfiles = await Profile.findAll({ attributes: ['user_id'] });
                const notificationsData = allProfiles.map(p => ({
                    user_id: p.user_id,
                    type: 'system',
                    title: 'Hệ thống cập nhật Huy hiệu! 📢',
                    content: 'Hệ thống vừa có sự thay đổi về yêu cầu điểm số (XP) của các huy hiệu. Hãy kiểm tra lại phần Thành tích của bạn ngay nhé!',
                    metadata: { badge_id: id }
                }));
                
                await Notification.bulkCreate(notificationsData);
                console.log(`[Admin] Broadcasted badge update notification to ${allProfiles.length} users.`);

            } catch (err) {
                console.error('[Admin] Error retroactively syncing badges:', err);
            }
        })();

        await logAction(req.user.id, 'Cập nhật huy hiệu', `Badge ID: ${id}`);
        res.json(badge);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.deleteBadge = async (req, res) => {
    try {
        const { id } = req.params;
        const badge = await Badge.findByPk(id);
        if (!badge) return res.status(404).json({ error: 'Badge not found' });

        await badge.destroy();
        await logAction(req.user.id, 'Xóa huy hiệu', `Badge ID: ${id}`);
        res.json({ message: 'Badge deleted successfully' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

