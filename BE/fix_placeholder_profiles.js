const { sequelize } = require('./src/models');

async function fixProfiles() {
    await sequelize.authenticate();
    
    console.log('\n=== FIXING "Người dùng mới" PROFILES ===\n');
    
    // Find all profiles with 'Người dùng mới' display_name
    const [badProfiles] = await sequelize.query(`
        SELECT 
            p.id as profile_id,
            p.user_id,
            p.display_name,
            u.email,
            u.full_name,
            u.phone
        FROM profiles p
        JOIN users u ON p.user_id = u.id
        WHERE p.display_name = 'Người dùng mới' OR p.display_name = ''
    `);
    
    console.log(`Found ${badProfiles.length} profiles to fix:\n`);
    
    for (const p of badProfiles) {
        let newName = '';
        if (p.full_name && p.full_name.trim()) {
            newName = p.full_name.trim();
        } else if (p.email) {
            newName = p.email.split('@')[0];
        } else if (p.phone) {
            newName = `User_${p.phone.slice(-4)}`;
        }
        
        if (newName && newName !== 'Người dùng mới') {
            await sequelize.query(
                `UPDATE profiles SET display_name = ? WHERE id = ?`,
                { replacements: [newName, p.profile_id] }
            );
            console.log(`✅ Fixed profile ${p.profile_id} for user ${p.email}: 'Người dùng mới' → '${newName}'`);
        } else {
            console.log(`⚠️  Cannot fix profile ${p.profile_id} for user ${p.email}: no valid name source`);
        }
    }
    
    // Also fix users with NO profile that have DNA scores
    const [noProfileUsers] = await sequelize.query(`
        SELECT u.id, u.email, u.full_name, u.phone, u.ambition_score
        FROM users u
        LEFT JOIN profiles p ON u.id = p.user_id
        WHERE p.id IS NULL AND u.email IS NOT NULL
    `);
    
    if (noProfileUsers.length > 0) {
        console.log(`\n=== CREATING MISSING PROFILES for ${noProfileUsers.length} users ===\n`);
        for (const u of noProfileUsers) {
            let name = u.full_name?.trim() || u.email.split('@')[0] || `User_${(u.phone || '0000').slice(-4)}`;
            await sequelize.query(
                `INSERT INTO profiles (user_id, display_name, points, current_title) VALUES (?, ?, 0, 'Newbie')`,
                { replacements: [u.id, name] }
            );
            console.log(`✅ Created profile for user ${u.email} (id=${u.id}) with name='${name}'`);
        }
    }
    
    console.log('\n=== DONE ===');
    process.exit(0);
}

fixProfiles().catch(e => { console.error('ERROR:', e.message); process.exit(1); });
