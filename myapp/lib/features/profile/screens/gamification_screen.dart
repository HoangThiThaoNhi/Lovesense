import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../models/gamification_model.dart';
import '../providers/gamification_provider.dart';
import '../../../theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/utils/api_service.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'voucher_screen.dart';


class GamificationScreen extends ConsumerStatefulWidget {
  const GamificationScreen({super.key});

  @override
  ConsumerState<GamificationScreen> createState() => _GamificationScreenState();
}

class _GamificationScreenState extends ConsumerState<GamificationScreen> {
  int _historyLimit = 3;

  @override
  void initState() {
    super.initState();
    // Status is already loaded by the provider's constructor
  }

  @override
  Widget build(BuildContext context) {
    final statusAsync = ref.watch(gamificationProvider);
    final lastSeenCount = ref.watch(lastSeenVoucherCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thành tích & Gamification', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, color: Colors.black87),
            onPressed: () => _showHowToEarnGuide(context),
            tooltip: 'Làm sao để nhận XP?',
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: statusAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Không thể tải: $e')),
          data: (status) => RefreshIndicator(
            onRefresh: () => ref.read(gamificationProvider.notifier).loadStatus(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 100, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPointsCard(status),
                  const SizedBox(height: 32),
                    // Rewards Button
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        ref.read(lastSeenVoucherCountProvider.notifier).state = status.unusedVouchersCount;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const VoucherScreen()));
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: (status.unusedVouchersCount > lastSeenCount)
                                      ? Colors.orange.withOpacity(0.3) 
                                      : Colors.red.withOpacity(0.15), 
                                  blurRadius: 16, 
                                  offset: const Offset(0, 8)
                                ),
                              ],
                              border: (status.unusedVouchersCount > lastSeenCount)
                                  ? Border.all(color: Colors.orange.withOpacity(0.5), width: 2)
                                  : null,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  (status.unusedVouchersCount > lastSeenCount) ? '🎁' : '📦', 
                                  style: TextStyle(
                                    fontSize: 34, 
                                    shadows: [
                                      Shadow(
                                        color: (status.unusedVouchersCount > lastSeenCount) ? Colors.orange.withOpacity(0.4) : Colors.red.withOpacity(0.2), 
                                        blurRadius: 12, 
                                        offset: const Offset(0, 4)
                                      )
                                    ]
                                  )
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  (status.unusedVouchersCount > lastSeenCount) ? 'MỞ QUÀ NGAY!' : 'Phần thưởng', 
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900, 
                                    fontSize: 13, 
                                    color: (status.unusedVouchersCount > lastSeenCount) ? Colors.orange[800] : Colors.black87, 
                                    letterSpacing: -0.2
                                  )
                                ),
                              ],
                            ),
                          ).animate(
                            onPlay: (controller) {
                              if (status.unusedVouchersCount > lastSeenCount) {
                                controller.repeat();
                              } else {
                                controller.stop();
                              }
                            },
                          ).shimmer(duration: 1500.ms, color: Colors.orange.withOpacity(0.4))
                           .shake(hz: 3, curve: Curves.easeInOutSine, rotation: 0.05)
                           .scale(begin: const Offset(1, 1), end: const Offset(1.06, 1.06), duration: 800.ms, curve: Curves.easeInOutSine),
                          
                          // Enhanced Notification Badge - Only show 'MỚI' if not clicked
                          if (status.unusedVouchersCount > lastSeenCount)
                            Positioned(
                              top: -12,
                              right: -12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(color: Colors.red.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 4)),
                                  ],
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Text(
                                  'MỚI',
                                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                                ),
                              ).animate(onPlay: (c) {
                                c.repeat();
                              }).scale(duration: 500.ms, curve: Curves.elasticOut).shimmer(delay: 1000.ms),
                            ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  _buildEarningActionsSection(context, status.challenges),
                  const SizedBox(height: 32),
                  _buildBadgesSection(status.badges),
                  const SizedBox(height: 24),
                  _buildRoadmapSection(status.badges),
                  const SizedBox(height: 24),
                  _buildHistorySection(status.history),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showHowToEarnGuide(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Làm sao để nhận XP?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Hãy tích cực hoạt động để nhận nhiều phần quà hấp dẫn từ Lovesense',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: _buildHowToEarnXPContent(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Đã hiểu', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildHowToEarnXPContent() {
    return Column(
      children: [
        // Bước 1: Định nghĩa bản thân (Xây dựng Profile)
        _buildGuideItem(
          icon: '🌟',
          title: 'Hoàn thiện hồ sơ',
          desc: 'Xây dựng chân dung thật ấn tượng',
          xp: '+10 mỗi mục',
          color: Colors.orange,
        ),
        _buildDivider(),

        // Bước 2: Tạo sự tin tưởng (Hình ảnh thực tế)
        _buildGuideItem(
          icon: '📸',
          title: 'Xác thực hình ảnh',
          desc: 'Khẳng định vẻ đẹp chân thực của bạn',
          xp: '+5 từ ảnh thứ 2',
          color: Colors.blue,
        ),
        _buildDivider(),

        // Bước 3: Chủ động tìm kiếm (Quẹt và Làm mới)
        _buildGuideItem(
          icon: '💖',
          title: 'Làm mới khám phá',
          desc: 'Mở rộng cơ hội gặp gỡ người mới',
          xp: '+10 mỗi lượt',
          color: Colors.pink,
        ),
        _buildDivider(),

        // Bước 4: Chuẩn bị chiến thuật (Sử dụng AI hỗ trợ)
        _buildGuideItem(
          icon: '🤖',
          title: 'Hỏi ý kiến Cố vấn AI',
          desc: 'Để AI giúp bạn thấu hiểu đối phương',
          xp: '+40 mỗi lượt',
          color: Colors.purple,
        ),
        _buildDivider(),

        // Bước 5: Hành động (Trò chuyện kết nối)
        _buildGuideItem(
          icon: '💬',
          title: 'Trò chuyện kết nối',
          desc: 'Gửi những lời nhắn chân thành nhất',
          xp: '+10 mỗi tin nhắn',
          color: Colors.green,
        ),
      ],
    );
  }
  Widget _buildGuideItem({
    required String icon,
    required String title,
    required String desc,
    required String xp,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(icon, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  desc,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              xp,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey.withOpacity(0.1), height: 1);
  }

  Widget _buildEarningActionsSection(BuildContext context, List<ChallengeModel> challenges) {
    if (challenges.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gợi ý tích điểm',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...challenges.map((challenge) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                   // Generic navigation based on title keywords
                   final t = challenge.title.toLowerCase();
                   if (t.contains('ảnh') || t.contains('hồ sơ')) {
                     context.go('/profile');
                   } else {
                     context.go('/home');
                   }
                },
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: Center(
                          child: challenge.emoji == '🤖'
                            ? Image.asset('assets/images/bot_3d.png', width: 90, height: 90, fit: BoxFit.contain)
                            : Text(challenge.emoji, style: const TextStyle(fontSize: 36)),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               challenge.title,
                               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                             ),
                             const SizedBox(height: 3),
                             Text(
                               challenge.description,
                               style: TextStyle(color: Colors.grey[600], fontSize: 12),
                             ),
                             const SizedBox(height: 4),
                             Text(
                               '+${challenge.rewardXp} XP',
                               style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
                             ),
                           ],
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }


  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: Colors.black87, letterSpacing: -0.2)),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsCard(GamificationStatus status) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text('Tổng điểm', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600, shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))])),
          const SizedBox(height: 8),
          Text(
            '${status.points}',
            style: const TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.w900, height: 1.0, shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))]),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status.currentTitle,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15, shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))]),
            ),
          ),
          const SizedBox(height: 20),
          _buildProgressBar(status),
        ],
      ),
    );
  }

  Widget _buildProgressBar(GamificationStatus status) {
    if (status.badges.isEmpty) return const SizedBox.shrink();

    // Badges should be sorted by pointsRequired on the server
    final badges = status.badges;
    
    // Find next milestone
    BadgeModel? nextBadge;
    try {
      nextBadge = badges.firstWhere((b) => b.pointsRequired > status.points);
    } catch (_) {
      nextBadge = null;
    }

    // Find previous milestone (current level)
    BadgeModel? prevBadge;
    try {
      prevBadge = badges.lastWhere((b) => b.pointsRequired <= status.points);
    } catch (_) {
      prevBadge = null;
    }

    int prevPoints = prevBadge?.pointsRequired ?? 0;
    int nextPoints = nextBadge?.pointsRequired ?? (prevPoints + 1000); // Fallback if maxed
    
    double progress = 0.0;
    if (nextPoints > prevPoints) {
      progress = (status.points - prevPoints) / (nextPoints - prevPoints);
    } else {
      // If next milestone is same as prev (misconfiguration), show full if user has enough points
      progress = status.points >= nextPoints ? 1.0 : 0.0;
    }
    progress = progress.clamp(0.0, 1.0);

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        const SizedBox(height: 12),
        if (nextBadge != null)
          Text(
            'Cần ${nextBadge.pointsRequired - status.points} điểm nữa để nhận huy hiệu ${nextBadge.name} và nhận quà',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))]),
          )
        else
          const Text(
            'Bạn đã đạt cấp độ cao nhất!',
            style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))]),
          ),
      ],
    );
  }


  Widget _buildBadgesSection(List<BadgeModel> badges) {
    final earnedBadges = badges.where((b) => b.earnedAt != null).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Danh hiệu đã đạt được',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 16),
        if (earnedBadges.isEmpty)
          _emptyCard('Chưa có danh hiệu nào. Tích điểm để mở khóa!')
        else
          Wrap(
            spacing: 12,
            runSpacing: 16,
            alignment: WrapAlignment.start,
            children: earnedBadges.map((b) => _buildBadgeChip(b)).toList(),
          ),
      ],
    );
  }

  Widget _buildBadgeChip(BadgeModel badge) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth == 0) return const SizedBox.shrink();
    final cardWidth = (screenWidth - 32 - 24) / 3; // 3 columns with spacing

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Color(badge.color).withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Color(badge.color).withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Larger Icon at top
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(badge.color).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: badge.buildIcon(size: 36),
          ),
          const SizedBox(height: 10),
          // Name in middle
          Text(
            badge.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: HSLColor.fromColor(Color(badge.color)).withLightness(0.3).toColor(),
              fontSize: 12,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Date at bottom
          if (badge.earnedAt != null)
            Text(
              '${badge.earnedAt!.day}/${badge.earnedAt!.month}',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[400],
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }


  Widget _buildHistorySection(List<PointHistoryEntry> history) {
    if (history.isEmpty) return const SizedBox.shrink();

    final displayedHistory = history.take(_historyLimit).toList();
    final hasMore = history.length > _historyLimit;

    return _buildCardSection(
      title: 'Lịch sử điểm',
      child: Column(
        children: [
          ...displayedHistory.map((h) => _buildHistoryItem(h)).toList(),
          if (hasMore)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _historyLimit += 10;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Xem thêm',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.primary),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(PointHistoryEntry h) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star_rounded, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(h.action, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(
                  '${h.createdAt.day}/${h.createdAt.month}/${h.createdAt.year}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            '+${h.points}',
            style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _emptyCard(String msg) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(msg, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
    );
  }

  Widget _buildCardSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.black.withOpacity(0.03)),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildRoadmapSection(List<BadgeModel> badges) {
    if (badges.isEmpty) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tất cả danh hiệu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text('Hành trình chinh phục trái tim', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 16),
        ...badges.map((badge) => _buildRoadmapItem(badge)).toList(),
      ],
    );
  }

  Widget _buildRoadmapItem(BadgeModel badge) {
    final isEarned = badge.earnedAt != null;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isEarned 
              ? Color(badge.color).withOpacity(0.3) 
              : Colors.black.withOpacity(0.05)
        ),
        boxShadow: isEarned 
            ? [BoxShadow(color: Color(badge.color).withOpacity(0.1), blurRadius: 10)] 
            : null,
      ),
      child: Row(
        children: [
          Opacity(
            opacity: isEarned ? 1.0 : 0.3,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(badge.color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: badge.buildIcon(size: 28),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  badge.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: isEarned ? Colors.black87 : Colors.grey[400],
                  ),
                ),
                Text(
                  badge.description,
                  style: TextStyle(fontSize: 12, color: isEarned ? Colors.grey[600] : Colors.grey[400]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${badge.pointsRequired} XP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isEarned ? Color(badge.color) : Colors.grey[400],
                ),
              ),
              if (isEarned)
                const Icon(Icons.check_circle_rounded, color: Colors.green, size: 16)
              else
                const Icon(Icons.lock_outline_rounded, color: Colors.grey, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}

