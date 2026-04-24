const { sequelize } = require('./src/models');

async function syncDB() {
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');
        
        // Sync models. alter: true will match the database to the models
        await sequelize.sync({ alter: true });
        console.log('All models were synchronized successfully.');
        
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    } finally {
        process.exit();
    }
}

syncDB();
