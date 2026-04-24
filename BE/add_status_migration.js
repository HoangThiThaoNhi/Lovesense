const sequelize = require('./src/config/db');

async function migrate() {
    try {
        console.log('Running migration...');
        await sequelize.query("ALTER TABLE matches ADD COLUMN status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending';");
        console.log('Migration successful: Added status to matches.');
    } catch (e) {
        if (e.message.includes('Duplicate column name')) {
            console.log('Column status already exists.');
        } else {
            console.error('Migration failed:', e.message);
        }
    } finally {
        process.exit();
    }
}

migrate();
