import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../shared_widgets/glass_container.dart';
import '../../../shared_widgets/gradient_button.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/user_model.dart';
import '../../../core/utils/api_service.dart';
import '../../swipe/providers/swipe_provider.dart';
import '../../match/screens/match_dialog.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/toast_utils.dart';
import 'dart:ui';

class UserDetailScreen extends ConsumerStatefulWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  ConsumerState<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends ConsumerState<UserDetailScreen> {
  int _currentPhotoIndex = 0;
  User? _fullUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFullUser();
  }

  Future<void> _fetchFullUser() async {
    try {
      final token = ref.read(authProvider).token;
      if (token == null) return;

      final response = await ApiService.get('/profile/${widget.user.id}', token: token);
      
      if (mounted) {
        setState(() {
          _fullUser = User.fromJson(response);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final user = _fullUser ?? widget.user;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main Scrollable Content
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // 1. Photo Header with App Bar
              SliverToBoxAdapter(
                child: _buildPhotoHeader(user),
              ),

              // 2. Info Content
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Name & Basic Badge
                    _buildIdentitySection(user),
                    const SizedBox(height: 32),

                    // Quick Stats (Icons row)
                    _buildQuickStats(user),
                    const SizedBox(height: 32),

                    // Bio
                    if (user.bio.isNotEmpty) ...[
                      _buildSectionTitle('Giới thiệu'),
                      const SizedBox(height: 12),
                      Text(
                        user.bio,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],

                    // Basic Details Grid
                    _buildSectionTitle('Thông tin chi tiết'),
                    const SizedBox(height: 16),
                    _buildDetailsGrid(user),
                    const SizedBox(height: 32),

                    // Interests
                    if (user.interests.isNotEmpty) ...[
                      _buildSectionTitle('Sở thích'),
                      const SizedBox(height: 16),
                      _buildInterestsWrap(user),
                      const SizedBox(height: 32),
                    ],

                    // Looking For
                    if (user.lookingFor.isNotEmpty) ...[
                      _buildSectionTitle('Đang tìm kiếm'),
                      const SizedBox(height: 16),
                      _buildLookingForCard(user),
                      const SizedBox(height: 32),
                    ],

                    // Gamification
                    _buildGamificationCard(user),
                  ]),
                ),
              ),
            ],
          ),

          // Floating Actions at bottom
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: _buildBottomActions(context, user),
          ),

          // Top Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            child: _buildCircleIconButton(
              icon: Icons.arrow_back_ios_new,
              onTap: () => context.pop(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoHeader(User user) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height * 0.6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: user.imageUrls.isNotEmpty
              ? PageView.builder(
                  itemCount: user.imageUrls.length,
                  onPageChanged: (i) => setState(() => _currentPhotoIndex = i),
                  itemBuilder: (context, index) => CachedNetworkImage(
                    imageUrl: user.imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(Icons.person, size: 100, color: Colors.white),
        ),
        
        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.7, 1.0],
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                  Colors.white.withOpacity(1.0),
                ],
              ),
            ),
          ),
        ),

        // Photo Indicators
        if (user.imageUrls.length > 1)
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 60,
            right: 60,
            child: Row(
              children: List.generate(
                user.imageUrls.length,
                (index) => Expanded(
                  child: Container(
                    height: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: _currentPhotoIndex == index ? Colors.white : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildIdentitySection(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${user.name}, ${user.age}',
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            if (user.isVerified)
              const Icon(Icons.verified, color: Colors.blue, size: 28),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              'Cách bạn ${user.distanceKm} km',
              style: TextStyle(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickStats(User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem(Icons.height, user.height != null ? '${user.height}cm' : '--'),
        _buildStatItem(Icons.work_outline, user.job.isNotEmpty ? user.job : 'Nghề nghiệp'),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[100]!),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildDetailsGrid(User user) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        children: [
          _buildDetailRow(Icons.transgender, 'Giới tính', user.gender.isNotEmpty ? user.gender : 'Chưa cập nhật'),
          const Divider(height: 32),
          _buildDetailRow(Icons.favorite_border, 'Mục đích', user.purpose ?? 'Hẹn hò'),
          const Divider(height: 32),
          _buildDetailRow(Icons.home_outlined, 'Sống tại', user.livingAt ?? 'Việt Nam'),
          const Divider(height: 32),
          _buildDetailRow(Icons.height, 'Chiều cao', user.height != null ? '${user.height} cm' : 'Chưa cập nhật'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 15)),
        const Spacer(),
        Text(
          value[0].toUpperCase() + value.substring(1),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildInterestsWrap(User user) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: user.interests.map((interest) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Text(
          interest,
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 14),
        ),
      )).toList(),
    );
  }

  Widget _buildLookingForCard(User user) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary.withOpacity(0.1), AppColors.secondary.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: AppColors.primary, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Đang tìm kiếm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primary)),
                const SizedBox(height: 4),
                Text(
                  user.lookingFor.join(', '),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGamificationCard(User user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF00BCD4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('THÀNH TÍCH', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
                const SizedBox(height: 8),
                Text('${user.points} ĐIỂM', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                  child: Text(user.currentTitle, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
          ),
          const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 60),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _buildCircleIconButton(
            icon: Icons.close,
            color: Colors.red,
            onTap: () => context.pop(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GradientButton(
              text: 'TƯƠNG HỢP NGAY',
              onPressed: () async {
                final isMatch = await ref.read(swipeProvider.notifier).likeUser(user);
                if (mounted) {
                  if (isMatch) {
                    showDialog(context: context, builder: (context) => MatchDialog(matchedUser: user));
                  } else {
                    ToastUtils.showModernToast(context, 'Đã gửi lượt thích! 💖', type: ToastType.success);
                    context.pop();
                  }
                }
              },
            ),
          ),
          const SizedBox(width: 16),
          _buildCircleIconButton(
            icon: Icons.star,
            color: Colors.blue,
            onTap: () async {
               final isMatch = await ref.read(swipeProvider.notifier).superLikeUser(user);
               if (mounted) {
                 if (isMatch) {
                   showDialog(context: context, builder: (context) => MatchDialog(matchedUser: user));
                 } else {
                   ToastUtils.showModernToast(context, 'Đã Super Like! ⭐', type: ToastType.info);
                   context.pop();
                 }
               }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIconButton({required IconData icon, required VoidCallback onTap, Color color = Colors.black87}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}
