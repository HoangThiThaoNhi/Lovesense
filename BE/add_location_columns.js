const { sequelize } = require('./src/models');

async function migrate() {
    try {
        await sequelize.authenticate();
        console.log('Connected to Database.');

        const queryInterface = sequelize.getQueryInterface();
        const tableInfo = await queryInterface.describeTable('profiles');

        if (!tableInfo.city) {
            await queryInterface.addColumn('profiles', 'city', {
                type: require('sequelize').DataTypes.STRING(100),
                allowNull: true
            });
            console.log('Added city column.');
        }

        if (!tableInfo.district) {
            await queryInterface.addColumn('profiles', 'district', {
                type: require('sequelize').DataTypes.STRING(100),
                allowNull: true
            });
            console.log('Added district column.');
        }

        if (!tableInfo.address) {
            await queryInterface.addColumn('profiles', 'address', {
                type: require('sequelize').DataTypes.STRING(255),
                allowNull: true
            });
            console.log('Added address column.');
        }

        console.log('Migration completed successfully.');
    } catch (error) {
        console.error('Migration failed:', error);
    } finally {
        process.exit();
    }
}

migrate();
