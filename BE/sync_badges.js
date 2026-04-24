const { Profile, Badge } = require('./src/models');
const GamificationService = require('./src/services/gamificationService');
const { Op } = require('sequelize');

async function syncBadges() {
    try {
        console.log('Starting badge synchronization...');
        const badges = await Badge.findAll();
        for (const badge of badges) {
            const eligibleProfiles = await Profile.findAll({
                where: { points: { [Op.gte]: badge.points_required } }
            });
            console.log(`Badge ${badge.name} (${badge.points_required} XP): found ${eligibleProfiles.length} eligible users.`);
            
            for (const profile of eligibleProfiles) {
                await GamificationService.awardPoints(profile.user_id, 0, 'Hệ thống cập nhật yêu cầu huy hiệu');
            }
        }
        console.log('Synchronization complete.');
        process.exit(0);
    } catch (e) {
        console.error('Error during synchronization:', e);
        process.exit(1);
    }
}

syncBadges();
