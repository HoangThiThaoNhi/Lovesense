const { AdminLog, sequelize } = require('./src/models');

async function test() {
    try {
        await sequelize.authenticate();
        console.log('Connection established.');
        
        // Force sync ONLY this table
        await AdminLog.sync({ alter: true });
        console.log('AdminLog table synced.');
        
        const count = await AdminLog.count();
        console.log('AdminLog count:', count);
    } catch (error) {
        console.error('Error:', error);
    } finally {
        process.exit();
    }
}

test();
