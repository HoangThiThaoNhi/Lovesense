const fs = require('fs');
const path = require('path');

async function run() {
    try {
        console.log('\n========================================================================');
        console.log('🔍 KIỂM TRA TÍNH NĂNG SINH KẾT QUẢ AI DNA DỰA TRÊN LỰA CHỌN CỦA USER');
        console.log('========================================================================\n');

        const logPath = path.join(__dirname, 'dna_test_history.json');
        
        if (!fs.existsSync(logPath)) {
            console.log('⚠️ Chưa có dữ liệu lịch sử bài Test nào được ghi nhận.');
            console.log('Hãy mở app và làm 1 bài test để hệ thống bắt đầu lưu lại!');
            process.exit(0);
        }

        const data = fs.readFileSync(logPath, 'utf8');
        const history = JSON.parse(data || '[]');
        
        if (history.length === 0) {
            console.log('⚠️ Lịch sử bài Test hiện đang trống.');
            process.exit(0);
        }

        // Lấy 3 bài test gần nhất
        const top3 = history.slice(0, 3);

        top3.forEach((record, index) => {
            const timeString = new Date(record.time).toLocaleString('vi-VN');
            console.log(`\n🕒 LẦN TEST ${index + 1} - Lúc: ${timeString}`);
            console.log(`👨‍🎓 USER: ${record.display_name} (ID: ${record.user_id})`);
            console.log('--------------------------------------------------');
            
            const vector = record.dna_vector || {};
            const sampleVector = {
                "Sự hướng ngoại (extroversion)": vector.extroversion || 0,
                "Tham vọng sự nghiệp (career_ambition)": vector.career_ambition || 0,
                "Tò mò trí tuệ (intellectual_curiosity)": vector.intellectual_curiosity || 0,
            };
            console.log('👉 [BỘ ĐÁP ÁN ĐÃ CHỌN] Vector Tính Cách Sinh Ra:');
            console.table(sampleVector);

            console.log('\n👉 [KẾT QUẢ AI PHÂN TÍCH TRẢ VỀ]');
            const report = record.report || {};
            if (report.highlights) {
                report.highlights.forEach(h => console.log(`   ${h}`));
            } else {
                console.log('   (Không có kết quả)');
            }
            console.log('\n========================================================================');
        });

        process.exit(0);
    } catch(e) {
        console.error(e);
        process.exit(1);
    }
}

run();
