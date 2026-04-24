const bcrypt = require('bcryptjs');
const { User, Profile, sequelize } = require('./src/models');
require('dotenv').config();

const seedAdmin = async () => {
    try {
        await sequelize.authenticate();
        console.log('Database connection established.');

        const adminEmail = 'admin@lovesense.vn';
        const adminPassword = 'admin123@Password'; // Bạn nên đổi mật khẩu này ngay sau khi đăng nhập

        const existingAdmin = await User.findOne({ where: { email: adminEmail } });
        if (existingAdmin) {
            console.log('Admin already exists. Updating role...');
            existingAdmin.role = 'admin';
            existingAdmin.status = 'active';
            await existingAdmin.save();
            console.log('Admin account updated.');
            return;
        }

        const hashedPassword = await bcrypt.hash(adminPassword, 10);
        const admin = await User.create({
            email: adminEmail,
            password: hashedPassword,
            role: 'admin',
            status: 'active'
        });

        await Profile.create({
            user_id: admin.id,
            display_name: 'Admin Toàn Cầu',
            location: sequelize.fn('ST_GeomFromText', 'POINT(105.8342 21.0278)'), // Hà Nội
        });

        console.log('Admin account created successfully!');
        console.log(`Email: ${adminEmail}`);
        console.log(`Password: ${adminPassword}`);
    } catch (error) {
        console.error('Error seeding admin:', error);
    } finally {
        process.exit();
    }
};

seedAdmin();
