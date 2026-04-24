const { Question, Challenge, UserChallenge, sequelize } = require('./src/models');

async function syncAll() {
    try {
        await sequelize.authenticate();
        console.log('Connection established.');
        
        // Sync all core models
        await Question.sync({ alter: true });
        console.log('Question table synced.');
        
        await Challenge.sync({ alter: true });
        console.log('Challenge table synced.');
        
        await UserChallenge.sync({ alter: true });
        console.log('UserChallenge table synced.');
        
        console.log('Final check: All tables are ready.');
    } catch (error) {
        console.error('Sync Error:', error);
    } finally {
        process.exit();
    }
}

syncAll();
