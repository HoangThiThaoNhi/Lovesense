const { sequelize } = require('./src/models');

async function check() {
    await sequelize.authenticate();
    
    // Find huy01 specifically
    const [results] = await sequelize.query(`
        SELECT 
            u.id as user_id, 
            u.email, 
            u.full_name,
            u.ambition_score,
            u.personality_score,
            p.id as profile_id, 
            p.display_name, 
            p.age, 
            p.occupation, 
            p.gender
        FROM users u 
        LEFT JOIN profiles p ON u.id = p.user_id 
        WHERE u.email LIKE '%huy01%' OR u.email LIKE '%huy0%'
        ORDER BY u.id DESC
    `);
    
    console.log('\n=== HUY01 ACCOUNT CHECK ===');
    results.forEach(r => {
        const status = r.profile_id ? '✅ HAS PROFILE' : '❌ NO PROFILE';
        console.log(`${status}`);
        console.log(`  user_id=${r.user_id} | email=${r.email}`);
        console.log(`  full_name=${r.full_name} | ambition_score=${r.ambition_score}`);
        console.log(`  profile_id=${r.profile_id} | display_name=${r.display_name}`);
        console.log('---');
    });
    
    process.exit(0);
}

check().catch(e => { console.error(e.message); process.exit(1); });
