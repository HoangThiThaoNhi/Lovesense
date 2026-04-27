const { Profile, Swipe, User } = require('./src/models');
const { Op } = require('sequelize');

async function run() {
    try {
        console.log('\n========================================================================');
        console.log('🤖 KIỂM TRA CHẾ ĐỘ THUẦN AI (DEEP LEARNING / TỰ ĐỘNG HỌC GU)');
        console.log('========================================================================\n');

        const userIdArg = process.argv[2];

        let profiles;

        if (userIdArg) {
            profiles = await Profile.findAll({ 
                where: { user_id: userIdArg }
            });
            if (profiles.length === 0) {
                console.log(`❌ Không tìm thấy thông tin Profile nào cho User ID: ${userIdArg}`);
                process.exit(0);
            }
        } else {
            console.log('(Không nhập ID cụ thể, hệ thống sẽ tự động lấy 3 người dùng gần nhất có dữ liệu AI)\n');
            // Lấy 3 user có dữ liệu học máy từ AI (ai_ideal_description không rỗng)
            profiles = await Profile.findAll({ 
                where: {
                    ai_ideal_description: { [Op.not]: null }
                },
                order: [['updated_at', 'DESC']], 
                limit: 3 
            });
        }

        if (profiles.length === 0) {
            console.log('⚠️ Chưa có dữ liệu học máy AI nào được ghi nhận.');
            console.log('Hãy mở app, thực hiện quẹt Like 5 người để AI bắt đầu phân tích Gu của bạn!');
            process.exit(0);
        }

        for (let i = 0; i < profiles.length; i++) {
            const p = profiles[i];
            
            // Tính số lượt đã quẹt Like/SuperLike để xem AI đã học được bao nhiêu dữ liệu
            const likesCount = await Swipe.count({ 
                where: { 
                    swiper_id: p.user_id, 
                    type: { [Op.in]: ['like', 'superlike'] } 
                } 
            });

            console.log(`\n👨‍🎓 USER ${i + 1}: ${p.display_name} (ID: ${p.user_id}) - Đã Thích: ${likesCount} người`);
            console.log('--------------------------------------------------');
            
            // 1. In ra Dữ liệu Thuật toán Thu thập Ngầm (Heuristics Preferences)
            let prefs = p.ai_preferences;
            if (typeof prefs === 'string') {
                try { prefs = JSON.parse(prefs); } catch(e) {}
            }
            if (!prefs || Object.keys(prefs).length === 0) prefs = { "Chưa có dữ liệu": 0 };
            
            console.log('👉 [DỮ LIỆU THU THẬP NGẦM] Trọng số sở thích từ thao tác quẹt:');
            console.table(prefs);

            // 2. In ra Phân tích Sâu của AI (Deep Learning Analysis)
            console.log('\n👉 [KẾT QUẢ AI PHÂN TÍCH GU NGƯỜI YÊU (Deep Learning)]');
            console.log(`   📝 Mô tả Gu Nửa kia: ${p.ai_ideal_description || '(Chưa có)'}`);
            
            let keywords = p.ai_match_keywords;
            if (typeof keywords === 'string') {
                try { keywords = JSON.parse(keywords); } catch(e) {}
            }
            console.log(`   🏷️ Các từ khóa AI tự học được để tìm kiếm:`);
            if (Array.isArray(keywords) && keywords.length > 0) {
                console.log(`      [ ${keywords.join(', ')} ]`);
            } else {
                console.log('      (Trống)');
            }
            
            console.log('\n========================================================================');
        }

        process.exit(0);
    } catch(e) {
        console.error(e);
        process.exit(1);
    }
}

run();
