const sequelize = require('./src/config/db');

async function migrate() {
    try {
        // Try to add the column, if it fails because it exists, that's fine
        await sequelize.query('ALTER TABLE messages ADD COLUMN is_read BOOLEAN DEFAULT FALSE;');
        console.log('Migration successful: Added is_read column');
        process.exit(0);
    } catch (error) {
        if (error.message.includes('Duplicate column name') || error.parent?.errno === 1060) {
            console.log('Column is_read already exists');
            process.exit(0);
        }
        console.error('Migration failed:', error);
        process.exit(1);
    }
}

migrate();
