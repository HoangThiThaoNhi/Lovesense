const { sequelize, Profile, PointHistory, Badge, UserBadge, User, Notification, Voucher, UserVoucher } = require('../models');
const { Op } = require('sequelize');

class GamificationService {
    static async awardPoints(userId, points, action, options = {}) {
        const t = await sequelize.transaction();
        try {
            // 1. Update Profile points
            const profile = await Profile.findOne({ where: { user_id: userId }, transaction: t });
            if (!profile) {
                await t.rollback();
                console.warn(`[Gamification] Profile not found for user ${userId}, skipping points.`);
                return null;
            }

            const numericPoints = parseInt(points) || 0;
            profile.points = (profile.points || 0) + numericPoints;
            await profile.save({ transaction: t });

            // 2. Record history only if points are awarded
            if (points !== 0) {
                await PointHistory.create({ user_id: userId, points, action }, { transaction: t });
            }

            // 3. Check for new badges
            const currentPoints = profile.points;
            const eligibleBadges = await Badge.findAll({
                where: { points_required: { [Op.lte]: currentPoints } },
                transaction: t
            });

            const newlyEarnedBadges = [];
            for (const badge of eligibleBadges) {
                const [userBadge, created] = await UserBadge.findOrCreate({
                    where: { user_id: userId, badge_id: badge.id },
                    defaults: { user_id: userId, badge_id: badge.id },
                    transaction: t
                });

                // If this is a newly earned badge, check for associated vouchers within valid date range
                if (created) {
                    newlyEarnedBadges.push(badge.toJSON());
                    const now = new Date();
                    const vouchers = await Voucher.findAll({
                        where: { 
                            badge_id: badge.id, 
                            is_active: true,
                            start_date: { [Op.lte]: now },
                            end_date: { [Op.gte]: now }
                        },
                        transaction: t
                    });

                    for (const voucher of vouchers) {
                        await UserVoucher.findOrCreate({
                            where: { user_id: userId, voucher_id: voucher.id },
                            defaults: { user_id: userId, voucher_id: voucher.id },
                            transaction: t
                        });
                        
                        // Notify user about the gift
                        await Notification.create({
                            user_id: userId,
                            type: 'gift',
                            title: `Bạn nhận được quà tặng: ${voucher.name}! 🎁`,
                            content: `Chúc mừng! Bạn đã nhận được một voucher quà tặng nhờ đạt huy hiệu ${badge.name}. Kiểm tra Kho Voucher ngay!`,
                            metadata: { voucher_id: voucher.id },
                            transaction: t
                        });
                    }
                }
            }

            // 4. Update title to highest earned badge
            const topBadge = await Badge.findOne({
                include: [{
                    model: User,
                    as: 'users',
                    where: { id: userId },
                    through: { attributes: [] }
                }],
                order: [['points_required', 'DESC']],
                transaction: t
            });

            // 5. Create notifications
            if (points !== 0 && !options.skipNotification) {
                await Notification.create({
                    user_id: userId,
                    type: 'xp',
                    title: `Bạn vừa nhận được +${points} XP! ⭐`,
                    content: `Tuyệt vời! Bạn vừa được cộng thêm ${points} điểm kinh nghiệm cho hành động: ${action}.`,
                    metadata: { points, action },
                    transaction: t
                });
            }

            if (topBadge && topBadge.name !== profile.current_title) {
                await Notification.create({
                    user_id: userId,
                    type: 'title',
                    title: `Thăng cấp danh hiệu mới: ${topBadge.name}! 🏆`,
                    content: `Chúc mừng! Bạn đã đạt được điểm số cần thiết để trở thành "${topBadge.name}".`,
                    metadata: { title: topBadge.name },
                    transaction: t
                });
                profile.current_title = topBadge.name;
                await profile.save({ transaction: t });
            }

            await t.commit();
            console.log(`[Gamification] +${points} pts awarded to user ${userId} for: ${action}`);
            return {
                pointsAwarded: points,
                totalPoints: currentPoints,
                newTitle: profile.current_title,
                newlyEarnedBadges: newlyEarnedBadges
            };
        } catch (error) {
            await t.rollback();
            // Log but don't throw — gamification errors should never break core features
            console.error('[Gamification] awardPoints error:', error.message);
            return null;
        }
    }

    static async getStatus(userId) {
        try {
            console.log(`  -> Step 1: Fetching profile for ${userId}`);
            let profile = await Profile.findOne({
                where: { user_id: userId },
                attributes: ['points', 'current_title']
            });

            // If profile doesn't exist (new user who hasn't finished setup), use defaults
            if (!profile) {
                profile = { points: 0, current_title: 'Thành viên mới' };
            }

            console.log(`  -> Step 2: Fetching badges (with Auto-Sync)`);
            const allBadges = await Badge.findAll({
                order: [['points_required', 'ASC']]
            });

            const userBadges = await UserBadge.findAll({
                where: { user_id: userId }
            });

            // AUTO-SYNC: If user has points but missing badges, award them now
            const userPoints = profile.points || 0;
            
            // Fix: Only sync badges if points_required > 0, or if it's the very first badge (0 points)
            // This prevents "filling all levels" if multiple badges are misconfigured with 0 points.
            const missingBadges = allBadges.filter((b, index) => 
                b.points_required <= userPoints && 
                !userBadges.some(ub => ub.badge_id === b.id) &&
                (b.points_required > 0 || index === 0)
            );

            if (missingBadges.length > 0) {
                console.log(`[Gamification] Auto-syncing ${missingBadges.length} badges for user ${userId}`);
                const { Voucher, UserVoucher, Notification } = require('../models');
                const now = new Date();
                
                for (const badge of missingBadges) {
                    await UserBadge.create({
                        user_id: userId,
                        badge_id: badge.id,
                        earned_at: now
                    });
                    
                    // Award vouchers for this synced badge
                    const vouchers = await Voucher.findAll({
                        where: { badge_id: badge.id, is_active: true }
                    });

                    for (const voucher of vouchers) {
                        await UserVoucher.findOrCreate({
                            where: { user_id: userId, voucher_id: voucher.id },
                            defaults: { user_id: userId, voucher_id: voucher.id }
                        });
                    }
                }

                // Update current_title if new badges were synced
                const eligibleBadgeIds = allBadges
                    .filter(b => b.points_required <= userPoints)
                    .map(b => b.id);

                if (eligibleBadgeIds.length > 0) {
                    const topBadge = await Badge.findOne({
                        where: { id: { [Op.in]: eligibleBadgeIds } },
                        order: [['points_required', 'DESC']]
                    });

                    if (topBadge) {
                        if (profile.save) profile.current_title = topBadge.name;
                        await Profile.update({ current_title: topBadge.name }, { where: { user_id: userId } });
                    }
                }
                
                // Re-fetch user badges after sync
                const updatedUserBadges = await UserBadge.findAll({ where: { user_id: userId } });
                userBadges.length = 0;
                userBadges.push(...updatedUserBadges);
            }

            // Merge earned info
            const badges = allBadges.map(b => {
                const badgeJson = b.toJSON();
                const earned = userBadges.find(ub => ub.badge_id === b.id);
                return {
                    ...badgeJson,
                    users: earned ? [{ UserBadge: { earned_at: earned.earned_at || earned.createdAt } }] : []
                };
            });

            console.log(`  -> Step 3: Fetching active challenges`);
            const { Challenge } = require('../models');
            const challenges = await Challenge.findAll({
                where: { status: 'active' },
                order: [['reward_xp', 'ASC']]
            });

            console.log(`  -> Step 4: Fetching history`);
            const history = await PointHistory.findAll({
                where: { user_id: userId },
                order: [['created_at', 'DESC']],
                limit: 20
            }) || [];

            console.log(`  -> Step 5: Fetching unused vouchers count`);
            const { UserVoucher } = require('../models');
            const unusedVouchersCount = await UserVoucher.count({
                where: { user_id: userId, is_used: false }
            });

            return { profile, badges, history, challenges, unusedVouchersCount };
        } catch (error) {
            console.error('[Gamification] getStatus error:', error);
            return { 
                profile: { points: 0, current_title: 'Lỗi tải' }, 
                badges: [], 
                history: [], 
                challenges: [], 
                unusedVouchersCount: 0 
            };
        }
    }

    static async getLeaderboard(userId) {
        try {
            // 1. Fetch top 10 users (not 50 for performance)
            const topUsers = await Profile.findAll({
                attributes: ['user_id', 'points', 'current_title'],
                include: [{
                    model: User,
                    as: 'user',
                    attributes: ['display_name', 'avatar_url']
                }],
                order: [['points', 'DESC']],
                limit: 10
            });

            // 2. Efficiently find user rank using COUNT
            const userPointsResult = await Profile.findOne({
                where: { user_id: userId },
                attributes: ['points']
            });

            const userPoints = userPointsResult ? userPointsResult.points : 0;
            const rankResult = await Profile.count({
                where: {
                    points: { [Op.gt]: userPoints }
                }
            });

            return {
                top_users: topUsers,
                user_rank: rankResult + 1,
                user_points: userPoints
            };
        } catch (error) {
            console.error('[Gamification] getLeaderboard error:', error);
            return { top_users: [], user_rank: 0, user_points: 0 };
        }
    }
}

module.exports = GamificationService;
