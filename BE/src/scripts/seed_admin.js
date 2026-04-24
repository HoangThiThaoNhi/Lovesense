const { User, Profile } = require('../models');
const bcrypt = require('bcryptjs');

const seedAdmin = async () => {
    try {
        console.log('Seeding initial admin user...');
        
        // Check if admin already exists
        const existingAdmin = await User.findOne({ where: { email: 'admin@lovesense.vn' } });
        
        if (existingAdmin) {
            console.log('Admin user already exists.');
            process.exit(0);
        }

        // Create Admin User
        const hashedPassword = await bcrypt.hash('admin123@Password', 10);
        const admin = await User.create({
            email: 'admin@lovesense.vn',
            password: hashedPassword,
            role: 'admin',
            status: 'active'
        });

        // Create Admin Profile
        await Profile.create({
            user_id: admin.id,
            display_name: 'LOVESENSE Admin',
            age: 25,
            gender: 'other',
            bio: 'Hệ thống quản trị viên LOVESENSE',
            interests: JSON.stringify(['AI', 'Technology', 'Matching']),
            location: { type: 'Point', coordinates: [105.8342, 21.0278] } // Hà Nội
        });

        console.log('Admin user seeded successfully!');
        console.log('Email: admin@lovesense.vn');
        console.log('Password: admin123@Password');
        process.exit(0);
    } catch (error) {
        console.error('Error seeding admin:', error);
        process.exit(1);
    }
};

seedAdmin();
