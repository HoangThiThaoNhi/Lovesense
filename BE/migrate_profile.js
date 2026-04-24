const sequelize = require('./src/config/db');

async function migrate() {
    try {
        await sequelize.query('ALTER TABLE profiles ADD COLUMN hide_distance BOOLEAN DEFAULT FALSE;');
        console.log('Migration successful: Added hide_distance column to profiles');
        process.exit(0);
    } catch (error) {
        if (error.message.includes('Duplicate column name') || error.parent?.errno === 1060) {
            console.log('Column hide_distance already exists');
            process.exit(0);
        }
        console.error('Migration failed:', error);
        process.exit(1);
    }
}

migrate();
burial_place
