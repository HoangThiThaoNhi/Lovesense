const { AdminLog, User, Profile } = require('./src/models');

async function checkLogs() {
    try {
        const count = await AdminLog.count();
        console.log(`Total logs in database: ${count}`);

        const logs = await AdminLog.findAll({
            include: [{
                model: User,
                as: 'admin',
                attributes: ['id', 'email'],
                include: [{ model: Profile, as: 'profile', attributes: ['display_name'] }]
            }],
            limit: 5,
            order: [['created_at', 'DESC']]
        });

        console.log('Last 5 logs:');
        console.log(JSON.stringify(logs, null, 2));
        process.exit(0);
    } catch (error) {
        console.error('Error checking logs:', error);
        process.exit(1);
    }
}

checkLogs();
