const { sequelize } = require('./src/models');

async function migrate() {
    try {
        await sequelize.authenticate();
        const queryInterface = sequelize.getQueryInterface();
        const tableInfo = await queryInterface.describeTable('profiles');

        if (!tableInfo.ai_preferences) {
            await queryInterface.addColumn('profiles', 'ai_preferences', {
                type: require('sequelize').DataTypes.JSON,
                allowNull: true,
                defaultValue: {}
            });
            console.log('Added ai_preferences column.');
        }

        console.log('Migration completed successfully.');
    } catch (error) {
        console.error('Migration failed:', error);
    } finally {
        process.exit();
    }
}

migrate();
