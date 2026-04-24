import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../shared_widgets/glass_container.dart';
import '../../../shared_widgets/gradient_button.dart';
import '../../../theme.dart';
import '../../../core/utils/api_service.dart';
import '../../../core/utils/toast_utils.dart';

class AccountSettingsScreen extends ConsumerStatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  ConsumerState<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends ConsumerState<AccountSettingsScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _isLoading = false;

  void _showChangePasswordDialog() {
    // Existing password dialog...
    _showPasswordDialog(context);
  }



  void _showEditPhoneDialog(String currentPhone) {
    final controller = TextEditingController(text: currentPhone);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cập nhật Số điện thoại'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(labelText: 'Số điện thoại mới', hintText: '036...'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          TextButton(
            onPressed: () async {
              try {
                await ref.read(authProvider.notifier).updateAccount(phone: controller.text);
                if (mounted) {
                  Navigator.pop(context);
                  ToastUtils.showModernToast(context, 'Đã cập nhật Số điện thoại', type: ToastType.success);
                }
              } catch (e) {
                ToastUtils.showModernToast(context, 'Lỗi: $e', type: ToastType.error);
              }
            },
            child: const Text('Cập nhật'),
          ),
        ],
      ),
    );
  }

  void _showPasswordDialog(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool obscureOld = true;
    bool obscureNew = true;
    bool obscureConfirm = true;
    bool isSubmitting = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Thay đổi mật khẩu', style: TextStyle(fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: oldPasswordController,
                    obscureText: obscureOld,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu hiện tại',
                      suffixIcon: IconButton(
                        icon: Icon(obscureOld ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => obscureOld = !obscureOld),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: newPasswordController,
                    obscureText: obscureNew,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu mới',
                      suffixIcon: IconButton(
                        icon: Icon(obscureNew ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => obscureNew = !obscureNew),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: obscureConfirm,
                    decoration: InputDecoration(
                      labelText: 'Xác nhận mật khẩu mới',
                      suffixIcon: IconButton(
                        icon: Icon(obscureConfirm ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => obscureConfirm = !obscureConfirm),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isSubmitting ? null : () => Navigator.pop(context),
                child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                onPressed: isSubmitting
                    ? null
                    : () async {
                        final oldPass = oldPasswordController.text;
                        final newPass = newPasswordController.text;
                        final confirmPass = confirmPasswordController.text;

                        if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
                          ToastUtils.showModernToast(context, 'Vui lòng điền đầy đủ thông tin', type: ToastType.warning);
                          return;
                        }
                        if (newPass.length < 6) {
                          ToastUtils.showModernToast(context, 'Mật khẩu mới phải có ít nhất 6 ký tự', type: ToastType.warning);
                          return;
                        }
                        if (newPass != confirmPass) {
                          ToastUtils.showModernToast(context, 'Mật khẩu xác nhận không khớp', type: ToastType.warning);
                          return;
                        }

                        setState(() => isSubmitting = true);
                        try {
                          await ref.read(authProvider.notifier).changePassword(oldPass, newPass);
                          if (mounted) {
                            Navigator.pop(context);
                            ToastUtils.showModernToast(context, 'Đổi mật khẩu thành công!', type: ToastType.success);
                          }
                        } catch (e) {
                          if (mounted) {
                            ToastUtils.showModernToast(context, e.toString().replaceAll('Exception: ', ''), type: ToastType.error);
                          }
                        } finally {
                          if (mounted) {
                            setState(() => isSubmitting = false);
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                child: isSubmitting
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Xác nhận', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDeleteAccountDialog() {
    final confirmController = TextEditingController();
    bool isDeleting = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: const [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
              SizedBox(width: 8),
              Text('Xóa tài khoản', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hành động này không thể hoàn tác. Toàn bộ dữ liệu, kết đôi, tin nhắn của bạn sẽ bị xóa vĩnh viễn.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              const Text('Nhập "XÓA TÀI KHOẢN" để xác nhận:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 8),
              TextField(
                controller: confirmController,
                decoration: InputDecoration(
                  hintText: 'XÓA TÀI KHOẢN',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: isDeleting ? null : () => Navigator.pop(context),
              child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: isDeleting
                  ? null
                  : () async {
                      if (confirmController.text.trim() != 'XÓA TÀI KHOẢN') {
                        ToastUtils.showModernToast(context, 'Vui lòng nhập đúng cụm từ xác nhận', type: ToastType.warning);
                        return;
                      }
                      setState(() => isDeleting = true);
                      try {
                        final token = ref.read(authProvider).token;
                        await ApiService.delete('/auth/delete-account', token: token);
                        if (mounted) {
                          Navigator.pop(context);
                          ref.read(authProvider.notifier).logout();
                        }
                      } catch (e) {
                        if (mounted) {
                          ToastUtils.showModernToast(context, 'Lỗi: $e', type: ToastType.error);
                          setState(() => isDeleting = false);
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: isDeleting
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text('Xóa vĩnh viễn'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Cài đặt tài khoản'),
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
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              'THÔNG TIN LIÊN HỆ',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12),
            ),
          ),
          GlassContainer(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.phone, color: AppColors.primary),
                  title: const Text('Số điện thoại'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Builder(builder: (context) {
                        final phone = user?.phone ?? '';
                        return Text(
                          phone.isNotEmpty ? phone : 'Chưa cập nhật',
                          style: const TextStyle(color: Colors.grey),
                        );
                      }),
                      const SizedBox(width: 8),
                      const Icon(Icons.edit, size: 16, color: Colors.grey),
                    ],
                  ),
                  onTap: () => _showEditPhoneDialog(user?.phone ?? ''),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.email, color: AppColors.primary),
                  title: const Text('Email'),
                  trailing: Builder(builder: (context) {
                    final email = user?.email ?? '';
                    return Text(
                      email.isNotEmpty ? email : 'Chưa cập nhật',
                      style: const TextStyle(color: Colors.grey),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              'BẢO MẬT',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12),
            ),
          ),
          GlassContainer(
            child: ListTile(
              leading: const Icon(Icons.lock_outline, color: AppColors.primary),
              title: const Text('Thay đổi mật khẩu'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _showChangePasswordDialog,
            ),
          ),
          const SizedBox(height: 32),
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              'VÙNG NGUY HIỂM',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 12),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red.withOpacity(0.2)),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete_forever_rounded, color: Colors.red, size: 22),
              ),
              title: const Text('Xóa tài khoản', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              subtitle: const Text('Xóa vĩnh viễn mọi dữ liệu của bạn', style: TextStyle(fontSize: 12, color: Colors.red)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
              onTap: _showDeleteAccountDialog,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Lưu ý: Bạn chỉ có thể thay đổi Số điện thoại. Email là thông tin định danh cố định.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}
}
