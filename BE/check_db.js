const sequelize = require('./src/config/db');
const { QueryTypes } = require('sequelize');

async function check() {
    try {
        const tables = await sequelize.query("SHOW TABLES", { type: QueryTypes.SELECT });
        console.log('Tables in database:', tables);
        
        for (const tableObj of tables) {
            const tableName = Object.values(tableObj)[0];
            const columns = await sequelize.query(`DESCRIBE ${tableName}`, { type: QueryTypes.SELECT });
            console.log(`\nColumns in ${tableName}:`, columns.map(c => c.Field));
        }
        
    } catch (error) {
        console.error('Error checking DB:', error);
    } finally {
        process.exit();
    }
}

check();
