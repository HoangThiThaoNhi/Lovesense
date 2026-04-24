const fs = require('fs');

/**
 * Script to generate 500+ realistic dummy users for LoveSense
 * Locations are centered around Ho Chi Minh City with random variation
 */

const DISPLAY_NAMES = [
    'Anh', 'Bình', 'Chi', 'Dũng', 'Hương', 'Huy', 'Lan', 'Nam', 'Ngọc', 'Phúc',
    'Quân', 'Sơn', 'Thảo', 'Tuấn', 'Vân', 'Yến', 'Minh', 'Thanh', 'Ly', 'Linh'
];

const BIOS = [
    'Thích du lịch và khám phá.',
    'Yêu mèo, ghét sự giả dối.',
    'Tìm kiếm một mối quan hệ nghiêm túc.',
    'Đam mê code và cà phê.',
    'Thích xem phim và nghe nhạc.',
    'Người hướng nội nhưng thích nói chuyện.',
    'Yêu thể thao và lối sống lành mạnh.',
    'Tìm người đồng hành cùng đi phượt.'
];

const JOBS = [
    'Designer', 'Developer', 'Sinh viên', 'Giáo viên', 'Kinh doanh', 'Bác sĩ', 'Nghệ sĩ'
];

const INTERESTS = [
    ['Âm nhạc', 'Du lịch'],
    ['Ẩm thực', 'Phim ảnh', 'Nghệ thuật'],
    ['Công nghệ', 'Thể hình'],
    ['Sách', 'Chơi game', 'Thiên nhiên'],
    ['Thú cưng', 'Thời trang']
];

const PHOTOS = [
    'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500',
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
    'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500',
    'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500'
];

// HCM City Coordinates
const BASE_LAT = 10.762622;
const BASE_LNG = 106.660172;

let sql = `USE lovesense;\n\n`;

for (let i = 1; i <= 500; i++) {
    const phone = `0${Math.floor(100000000 + Math.random() * 900000000)}`;
    const name = DISPLAY_NAMES[Math.floor(Math.random() * DISPLAY_NAMES.length)] + ' ' + i;
    const age = 18 + Math.floor(Math.random() * 22);
    const bio = BIOS[Math.floor(Math.random() * BIOS.length)];
    const job = JOBS[Math.floor(Math.random() * JOBS.length)];
    const interest = JSON.stringify(INTERESTS[Math.floor(Math.random() * INTERESTS.length)]);

    // Add randomness to location (within ~50km)
    const lat = BASE_LAT + (Math.random() - 0.5) * 0.5;
    const lng = BASE_LNG + (Math.random() - 0.5) * 0.5;

    sql += `-- User ${i}\n`;
    sql += `INSERT INTO users (phone) VALUES ('${phone}');\n`;
    sql += `SET @user_id = LAST_INSERT_ID();\n`;
    sql += `INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) ` +
        `VALUES (@user_id, '${name}', ${age}, '${job}', '${bio}', '${interest}', POINT(${lat}, ${lng}));\n`;

    // Add a main photo for each
    const photo = PHOTOS[Math.floor(Math.random() * PHOTOS.length)];
    sql += `INSERT INTO photos (user_id, image_url, is_main, \`order\`) VALUES (@user_id, '${photo}', 1, 0);\n\n`;
}

fs.writeFileSync('seed_data.sql', sql);
console.log('Successfully generated seed_data.sql with 500 users!');
