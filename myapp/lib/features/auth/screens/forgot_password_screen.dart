import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../../../shared_widgets/gradient_button.dart';
import '../../../shared_widgets/glass_container.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/toast_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  bool _otpSent = false;

  void _handleResetPassword() async {
    if (_emailController.text.trim().isEmpty) {
      ToastUtils.showModernToast(context, 'Vui lòng nhập Email', type: ToastType.warning);
      return;
    }

    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() {
        _isLoading = false;
        _otpSent = true;
      });
      ToastUtils.showModernToast(context, 'Mã OTP đã được gửi đến email của bạn', type: ToastType.success);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quên mật khẩu'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_reset_rounded, size: 80, color: AppColors.primary)
                    .animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                const SizedBox(height: 24),
                Text(
                  _otpSent ? 'Kiểm tra Email' : 'Khôi phục mật khẩu',
                  style: AppTextStyles.displayLarge.copyWith(fontSize: 28, color: AppColors.primary),
                ),
                const SizedBox(height: 12),
                Text(
                  _otpSent 
                    ? 'Chúng tôi đã gửi mã xác nhận đến ${_emailController.text}'
                    : 'Nhập email đã đăng ký để nhận hướng dẫn khôi phục mật khẩu',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 40),
                GlassContainer(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      if (!_otpSent) ...[
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 24),
                        GradientButton(
                          text: 'Gửi yêu cầu',
                          onPressed: _handleResetPassword,
                          isLoading: _isLoading,
                          width: double.infinity,
                        ),
                      ] else ...[
                        const Text('Luồng đặt lại mật khẩu thực tế sẽ được tích hợp với Backend.'),
                        const SizedBox(height: 20),
                        GradientButton(
                          text: 'Quay lại Đăng nhập',
                          onPressed: () => Navigator.pop(context),
                          width: double.infinity,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
