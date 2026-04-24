const fs = require('fs');
const mysql = require('mysql2/promise');
require('dotenv').config();

async function migrate() {
    let connection;
    try {
        console.log('Connecting to MySQL...');
        connection = await mysql.createConnection({
            host: process.env.DB_HOST,
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            multipleStatements: true
        });

        console.log('Reading migration.sql...');
        const migrationSql = fs.readFileSync('migration.sql', 'utf8');
        
        // Split by semicolon but ignore semicolons inside parentheses or quotes
        // For simplicity, we'll split by common SQL statement boundaries
        const statements = migrationSql
            .split(';')
            .map(s => s.trim())
            .filter(s => s.length > 0);

        console.log(`Executing ${statements.length} statements...`);

        for (let statement of statements) {
            try {
                await connection.query(statement);
            } catch (err) {
                // Ignore "Duplicate column name" error (ER_DUP_FIELDNAME)
                if (err.errno === 1060) {
                    console.log(`> Column already exists, skipping: ${statement.substring(0, 50)}...`);
                } 
                // Ignore "Table already exists" error (ER_TABLE_EXISTS_ERROR) - though we use IF NOT EXISTS
                else if (err.errno === 1050) {
                    console.log(`> Table already exists, skipping: ${statement.substring(0, 50)}...`);
                }
                else {
                    console.error(`> Error executing statement: ${statement.substring(0, 100)}...`);
                    console.error(`  Error message: ${err.message}`);
                }
            }
        }

        console.log('\nDatabase update completed!');

    } catch (error) {
        console.error('Critical error during migration:', error);
    } finally {
        if (connection) await connection.end();
    }
}

migrate();
