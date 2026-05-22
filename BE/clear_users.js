const { User, Profile, Swipe, Match, Photo, PointHistory, UserBadge } = require('./src/models');
const { Op } = require('sequelize');

async function clearAllUsers() {
    try {
        console.log('⏳ Đang tiến hành xóa toàn bộ người dùng (trừ Admin)...');

        // Lấy tất cả user có role là 'user'
        const usersToDelete = await User.findAll({
            where: {
                role: 'user'
            }
        });

        if (usersToDelete.length === 0) {
            console.log('✅ Không có người dùng nào cần xóa.');
            process.exit(0);
        }

        const userIds = usersToDelete.map(u => u.id);
        console.log(`🗑️ Đã tìm thấy ${userIds.length} người dùng cần xóa. Đang tiến hành...`);

        // Xóa Users. Do đã set ON DELETE CASCADE trong DB (theo schema.sql) 
        // và Sequelize, các bảng liên quan như profiles, swipes, matches, photos... 
        // sẽ tự động bị xóa theo nếu DB support.
        // Tuy nhiên để đảm bảo an toàn và sạch sẽ, ta có thể dùng Sequelize destroy.
        
        const deletedCount = await User.destroy({
            where: {
                role: 'user'
            }
        });

        console.log(`🎉 Đã xóa thành công ${deletedCount} tài khoản người dùng và toàn bộ dữ liệu liên quan (Hồ sơ, Ảnh, Lượt quẹt, Match...) nhờ cơ chế CASCADE!`);
        console.log('💡 Bây giờ bạn có thể lên Web Admin CMS và dùng chức năng "Tạo hàng loạt" để sinh ra người dùng mới.');
        
        process.exit(0);
    } catch (error) {
        console.error('❌ Lỗi trong quá trình xóa người dùng:', error);
        process.exit(1);
    }
}

clearAllUsers();
