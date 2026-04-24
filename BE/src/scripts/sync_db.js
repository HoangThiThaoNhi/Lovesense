const { sequelize } = require('../models');

const syncDb = async () => {
    try {
        console.log('Syncing database schema (this may take a few seconds)...');
        await sequelize.sync({ alter: true });
        console.log('Database schema synced successfully!');
        process.exit(0);
    } catch (error) {
        console.error('Error syncing database:', error);
        process.exit(1);
    }
};

syncDb();
