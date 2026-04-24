const sequelize = require('./src/config/db');

async function checkData() {
  try {
    const [results] = await sequelize.query("SELECT id, user_id, age, ST_AsText(location) as loc FROM profiles LIMIT 10");
    console.log('Profiles:', JSON.stringify(results, null, 2));
    
    const [counts] = await sequelize.query("SELECT COUNT(*) as total FROM profiles");
    console.log('Total Profiles:', counts[0].total);
    
    const [ageNull] = await sequelize.query("SELECT COUNT(*) as count FROM profiles WHERE age IS NULL");
    console.log('Profiles with age = NULL:', ageNull[0].count);
  } catch (err) {
    console.error('Error:', err);
  } finally {
    process.exit();
  }
}

checkData();
