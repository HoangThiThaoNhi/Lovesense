import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared_widgets/glass_container.dart';
import '../../../core/utils/toast_utils.dart';
import '../../../theme.dart';
import '../../auth/providers/auth_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        title: const Text('Cài đặt'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: ListView(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 100, bottom: 16),
        children: [
          _buildSectionHeader('Tài khoản'),
          GlassContainer(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person_outline, color: AppColors.primary),
                  title: const Text('Cài đặt tài khoản'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.pushNamed('settings_account'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Hỗ trợ'),
          GlassContainer(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.help_outline, color: AppColors.primary),
                  title: const Text('Trợ giúp & Hỗ trợ'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.pushNamed('settings_support'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Pháp lý'),
          GlassContainer(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.description_outlined, color: AppColors.primary),
                  title: const Text('Điều khoản dịch vụ'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.pushNamed('settings_terms'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined, color: AppColors.primary),
                  title: const Text('Chính sách quyền riêng tư'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.pushNamed('settings_privacy'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.verified_user_outlined, color: AppColors.primary),
                  title: const Text('Giấy phép'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.pushNamed('settings_license'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          
          // NÚT ĐĂNG XUẤT LÀM MỚI TOÀN BỘ VỚI BACKGROUND ĐỎ RÕ RÀNG
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                ref.read(authProvider.notifier).logout();
                ToastUtils.showModernToast(context, 'Đã đăng xuất');
                context.go('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Nền đỏ rực rỡ
                foregroundColor: Colors.white, // Chữ trắng
                minimumSize: const Size(double.infinity, 56), // Độ cao nút
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5, // Đổ bóng rõ ràng
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.logout, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'ĐĂNG XUẤT',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          Center(
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Xác nhận xóa tài khoản?'),
                    content: const Text('Tài khoản của bạn sẽ không còn hoạt động trên hệ thống. Bạn có chắc chắn muốn tiếp tục?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('HỦY'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          try {
                            await ref.read(authProvider.notifier).deactivateAccount();
                            if (mounted) {
                              ToastUtils.showModernToast(context, 'Tài khoản đã được xóa');
                              context.go('/login');
                            }
                          } catch (e) {
                            if (mounted) {
                              ToastUtils.showModernToast(context, 'Lỗi: ${e.toString()}', type: ToastType.error);
                            }
                          }
                        },
                        child: const Text('XÓA', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                'XÓA TÀI KHOẢN',
                style: TextStyle(
                  color: Colors.red.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 48),
          Center(
            child: Text(
              'Phiên bản 1.0.0',
              style: TextStyle(color: Colors.grey.withOpacity(0.5), fontSize: 12),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    ),
  );
}

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
