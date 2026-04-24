const { Swipe, Profile, sequelize } = require('./src/models');

async function testDiscovery() {
    try {
        const userId = 1; // Assuming user index starts at 1
        const profile = await Profile.findOne({ where: { user_id: userId } });
        if (!profile) {
            console.log('No profile for user 1');
            return;
        }
        
        console.log('User 1 profile:', { id: profile.id, lat: profile.lat, lng: profile.lng });
        
        const list = await Swipe.getDiscoveryList(userId, 10.762622, 106.660172); // Test with HCM coords
        console.log('Discovery List Count:', list.length);
        if (list.length > 0) {
            console.log('First user:', list[0].display_name);
        } else {
            // Check why it is empty
            const totalProfiles = await Profile.count();
            console.log('Total Profiles:', totalProfiles);
            
            const [rows] = await sequelize.query('SELECT p.id, u.role FROM profiles p INNER JOIN users u ON u.id = p.user_id LIMIT 5');
            console.log('Sample profiles with user roles:', rows);
        }
    } catch (error) {
        console.error('Test Error:', error);
    } finally {
        process.exit();
    }
}

testDiscovery();
