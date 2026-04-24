const fs = require('fs');
const mysql = require('mysql2/promise');
require('dotenv').config();

async function seed() {
    let connection;
    try {
        console.log('Connecting to MySQL...');
        connection = await mysql.createConnection({
            host: process.env.DB_HOST,
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            multipleStatements: true // Required to run the whole SQL file
        });

        console.log('Reading schema.sql...');
        const schema = fs.readFileSync('schema.sql', 'utf8');
        console.log('Executing schema...');
        await connection.query(schema);
        console.log('Schema imported successfully.');

        console.log('Reading seed.sql...');
        const seedData = fs.readFileSync('seed.sql', 'utf8');
        console.log('Executing seed data...');
        await connection.query(seedData);
        console.log('Seed data imported successfully!');

    } catch (error) {
        console.error('Error seeding database:', error);
        console.log('\nTIP: Make sure your MySQL is running and the credentials in BE/.env are correct.');
    } finally {
        if (connection) await connection.end();
    }
}

seed();
