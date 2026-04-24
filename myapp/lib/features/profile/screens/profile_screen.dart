import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../shared_widgets/glass_container.dart';
import '../../../shared_widgets/gradient_button.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/gamification_provider.dart';
import '../../../theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/utils/toast_utils.dart';
import '../../../core/utils/api_service.dart';
import '../../../models/gamification_model.dart';
import 'dart:ui';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  double _distance = 10;
  bool _distanceHidden = false;
  int _currentPhotoIndex = 0;
  bool _isLocationEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLocationStatus();
    });
  }

  Future<void> _checkLocationStatus() async {
    final permission = await Geolocator.checkPermission();
    if (mounted) {
      setState(() {
        _isLocationEnabled = (permission == LocationPermission.always || 
                             permission == LocationPermission.whileInUse);
      });
    }
  }

  Future<void> _toggleLocation(bool value) async {
    if (value) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ToastUtils.showModernToast(context, 'Vui lòng bật dịch vụ định vị (GPS) trên thiết bị', type: ToastType.warning);
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ToastUtils.showModernToast(context, 'Vui lòng cấp quyền trong Cài đặt điện thoại', type: ToastType.warning);
        }
        setState(() => _isLocationEnabled = false);
        return;
      }

      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        setState(() => _isLocationEnabled = true);
        
        // Actually get and save location
        try {
          final position = await Geolocator.getCurrentPosition();
          final token = ref.read(authProvider).token;
          if (token != null) {
            await ApiService.post('/profile/update', {
              'lat': position.latitude,
              'lng': position.longitude,
            }, token: token);
            // Refresh profile to update local state
            await ref.read(authProvider.notifier).fetchProfile();
            if (mounted) {
              ToastUtils.showModernToast(context, 'Đã cập nhật vị trí của bạn', type: ToastType.success);
            }
          }
        } catch (e) {
          print('Error saving location: $e');
        }
      } else {
        setState(() => _isLocationEnabled = false);
      }
    } else {
      setState(() => _isLocationEnabled = false);
      if (mounted) {
        ToastUtils.showModernToast(context, 'Đã tắt chia sẻ vị trí', type: ToastType.info);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: Text("Vui lòng đăng nhập")));
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: Stack(
          children: [


          RefreshIndicator(
            onRefresh: () async {
              await ref.read(authProvider.notifier).fetchProfile();
              await ref.read(gamificationProvider.notifier).loadStatus();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // Header with Photo Carousel
                  _buildPhotoCarousel(user),
                  
                  const SizedBox(height: 12),

                // Name & Premium Layout
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        '${user.name}, ${user.age}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.work_outline, size: 14, color: Colors.blue),
                                const SizedBox(width: 4),
                                Text(
                                  user.job.isNotEmpty ? user.job : 'Nghề nghiệp',
                                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (user.isVerified)
                            const Icon(Icons.verified, color: Colors.blue, size: 20),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Main Actions
                _buildActionRow(context),

                const SizedBox(height: 40),

                // Sections
                _buildBioSection(user),
                const SizedBox(height: 24),
                _buildInterestsSection(user),
                const SizedBox(height: 24),
                _buildBadgesDisplay(),
                const SizedBox(height: 32),

                // QUYỀN RIÊNG TƯ & CÀI ĐẶT
                _buildPrivacySettingsSection(context),
                const SizedBox(height: 24),

                // HỖ TRỢ & PHÁP LÝ
                _buildSupportLegalSection(context),

                const SizedBox(height: 48),
                
                // Logout Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(authProvider.notifier).logout();
                      context.go('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: Colors.redAccent.withOpacity(0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.logout_rounded, size: 22),
                        SizedBox(width: 12),
                        Text(
                          'ĐĂNG XUẤT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
}

  Widget _buildPhotoCarousel(user) {
    return Stack(
      children: [
        Container(
          height: 420,
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: user.imageUrls.isNotEmpty 
              ? Stack(
                  children: [
                    PageView.builder(
                      itemCount: user.imageUrls.length,
                      onPageChanged: (index) => setState(() => _currentPhotoIndex = index),
                      itemBuilder: (context, index) => CachedNetworkImage(
                        imageUrl: user.imageUrls[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (user.imageUrls.length > 1)
                      Positioned(
                        top: 48, // Increased padding to avoid status bar overlap
                        left: 20,
                        right: 20,
                        child: Row(
                          children: List.generate(
                            user.imageUrls.length,
                            (index) => Expanded(
                              child: Container(
                                height: 4,
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
                )
              : Container(color: Colors.grey[300], child: const Icon(Icons.person, size: 80, color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildActionRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCircleButton(
          icon: Icons.settings_rounded,
          label: 'Cài đặt',
          onTap: () => context.push('/settings/account'),
        ),
        const SizedBox(width: 24),
        _buildCircleButton(
          icon: Icons.edit_rounded,
          label: 'Sửa hồ sơ',
          primary: true,
          onTap: () => context.push('/profile-setup'),
        ),
        const SizedBox(width: 24),
        _buildCircleButton(
          icon: Icons.security_rounded,
          label: 'An toàn',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildCircleButton({required IconData icon, required String label, required VoidCallback onTap, bool primary = false}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: primary ? 76 : 60,
            height: primary ? 76 : 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              gradient: primary ? AppColors.primaryGradient : null,
              boxShadow: [
                BoxShadow(
                  color: (primary ? AppColors.primary : Colors.grey).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(icon, color: primary ? Colors.white : Colors.grey[700], size: primary ? 32 : 28),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: Colors.black87, // Darker color for better contrast
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }



  Widget _buildBioSection(user) {
    if (user.bio.isEmpty) return const SizedBox.shrink();
    return _buildCardSection(
      title: 'Giới thiệu',
      child: Text(
        user.bio,
        style: TextStyle(fontSize: 16, color: Colors.grey[800], height: 1.5),
      ),
    );
  }

  Widget _buildInterestsSection(user) {
    if (user.interests.isEmpty) return const SizedBox.shrink();
    return _buildCardSection(
      title: 'Sở thích của tôi',
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: user.interests.map<Widget>((interest) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
            color: AppColors.primary.withOpacity(0.05),
          ),
          child: Text(
            interest,
            style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        )).toList(),
      ),
    );
  }



  Widget _buildPrivacySettingsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionLabel('QUYỀN RIÊNG TƯ'),
          const SizedBox(height: 8),
          _buildMenuCard([
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.location_on_rounded, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Chia sẻ vị trí', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                        Text('Cho phép tìm người ở gần bạn', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: _isLocationEnabled,
                    activeColor: AppColors.primary,
                    onChanged: _toggleLocation,
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildCardSection({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildSupportLegalSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HỖ TRỢ
          _buildSectionLabel('HỖ TRỢ'),
          const SizedBox(height: 8),
          _buildMenuCard([
            _buildMenuItem(
              context,
              icon: Icons.help_outline_rounded,
              iconColor: Colors.blue,
              label: 'Trợ giúp & Hỗ trợ',
              onTap: () => context.push('/settings/support'),
            ),
          ]),
          const SizedBox(height: 20),

          // PHÁP LÝ
          _buildSectionLabel('PHÁP LÝ'),
          const SizedBox(height: 8),
          _buildMenuCard([
            _buildMenuItem(
              context,
              icon: Icons.description_outlined,
              iconColor: Colors.indigo,
              label: 'Điều khoản dịch vụ',
              onTap: () => context.push('/settings/terms'),
            ),
            const Divider(height: 0, indent: 56, endIndent: 16),
            _buildMenuItem(
              context,
              icon: Icons.shield_outlined,
              iconColor: Colors.teal,
              label: 'Chính sách quyền riêng tư',
              onTap: () => context.push('/settings/privacy'),
            ),
            const Divider(height: 0, indent: 56, endIndent: 16),
            _buildMenuItem(
              context,
              icon: Icons.verified_outlined,
              iconColor: Colors.green,
              label: 'Giấy phép',
              onTap: () => context.push('/settings/license'),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required Color iconColor, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
            Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgesDisplay() {
    final statusAsync = ref.watch(gamificationProvider);
    return statusAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (status) {
        final earnedBadges = status.badges.where((b) => b.earnedAt != null).toList();
        if (earnedBadges.isEmpty) return const SizedBox.shrink();
        return _buildCardSection(
          title: 'Huy hiệu của tôi',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.start,
            children: earnedBadges.map((b) => _buildMiniBadge(b)).toList(),
          ),
        );
      },
    );
  }

  Widget _buildMiniBadge(BadgeModel badge) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 54,
          height: 54,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(badge.color).withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: Color(badge.color).withOpacity(0.2)),
          ),
          child: badge.buildIcon(size: 28),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 65,
          child: Text(
            badge.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: HSLColor.fromColor(Color(badge.color)).withLightness(0.3).toColor(),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}