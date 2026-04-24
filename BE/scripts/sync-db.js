require('dotenv').config({ path: 'BE/.env' });
const sequelize = require('../src/config/db');
const models = require('../src/models');

async function syncDB() {
    try {
        console.log('Syncing all tables with { alter: true }...');
        await sequelize.sync({ alter: true });
        console.log('Database synced successfully!');
        process.exit(0);
    } catch (error) {
        console.error('Error syncing database:', error);
        process.exit(1);
    }
}

syncDB();
