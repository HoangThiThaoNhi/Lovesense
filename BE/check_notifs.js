const sequelize = require('./src/config/db');

async function checkNotifications() {
  try {
    const [results] = await sequelize.query("SELECT * FROM notifications ORDER BY created_at DESC LIMIT 10");
    console.log('Latest Notifications:', JSON.stringify(results, null, 2));
    
    const [counts] = await sequelize.query("SELECT COUNT(*) as total FROM notifications");
    console.log('Total Notifications:', counts[0].total);
    
    const [users] = await sequelize.query("SELECT id, email, phone FROM users LIMIT 10");
    console.log('Recent Users:', JSON.stringify(users, null, 2));
  } catch (err) {
    console.error('Error:', err);
  } finally {
    process.exit();
  }
}

checkNotifications();
