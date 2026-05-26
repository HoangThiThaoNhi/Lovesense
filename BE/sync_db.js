const { QuizQuestion, Profile, sequelize } = require('./src/models');

async function syncDB() {
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');
        
        // Sync only modified models
        await QuizQuestion.sync({ alter: true });
        await Profile.sync({ alter: true });
        console.log('QuizQuestion and Profile models were synchronized successfully.');
        
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    } finally {
        process.exit();
    }
}

syncDB();
