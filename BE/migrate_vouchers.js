const { sequelize } = require('./src/models');

async function migrate() {
    try {
        const queryInterface = sequelize.getQueryInterface();
        const tableInfo = await queryInterface.describeTable('vouchers');

        if (!tableInfo.start_date) {
            console.log('Adding start_date column...');
            await queryInterface.addColumn('vouchers', 'start_date', {
                type: require('sequelize').DataTypes.DATE,
                allowNull: false,
                defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
            });
        }

        if (!tableInfo.end_date) {
            console.log('Adding end_date column...');
            await queryInterface.addColumn('vouchers', 'end_date', {
                type: require('sequelize').DataTypes.DATE,
                allowNull: false,
                defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
            });
        }

        // Also remove expiry_date if it exists
        if (tableInfo.expiry_date) {
            console.log('Removing expiry_date column...');
            await queryInterface.removeColumn('vouchers', 'expiry_date');
        }

        console.log('Migration completed successfully.');
        process.exit(0);
    } catch (error) {
        console.error('Migration failed:', error);
        process.exit(1);
    }
}

migrate();
