import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared_widgets/gradient_button.dart';
import '../../../shared_widgets/glass_container.dart';
import '../providers/auth_provider.dart';
import '../../../theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/toast_utils.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isRegistering = false;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedAccount();
  }

  Future<void> _loadRememberedAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('remembered_email');
    if (savedEmail != null) {
      setState(() {
        _emailController.text = savedEmail;
        _rememberMe = true;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleAuth() async {
    if (ref.read(authProvider).isLoading) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ToastUtils.showModernToast(context, 'Vui lòng điền đầy đủ thông tin', type: ToastType.warning);
      return;
    }

    if (_isRegistering) {
      if (password != confirmPassword) {
        ToastUtils.showModernToast(context, 'Mật khẩu không khớp', type: ToastType.error);
        return;
      }
      await ref.read(authProvider.notifier).register(email, password);
    } else {
      final prefs = await SharedPreferences.getInstance();
      if (_rememberMe) {
        await prefs.setString('remembered_email', email);
      } else {
        await prefs.remove('remembered_email');
      }
      await ref.read(authProvider.notifier).login(email, password);
    }

    if (!mounted) return;
    
    final authState = ref.read(authProvider);
    if (authState.error != null) {
      ToastUtils.showModernToast(context, authState.error!, type: ToastType.error);
    }
    // Success navigation is handled automatically by GoRouter redirect listener in nav.dart
  }

  void _handleSocialLogin(String provider) async {
    await ref.read(authProvider.notifier).loginWithSocial(provider);
    final authState = ref.read(authProvider);
    if (authState.error != null && mounted) {
      ToastUtils.showModernToast(context, authState.error!, type: ToastType.error);
    } else if (authState.isAuthenticated && mounted) {
      context.go('/profile-setup');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo / Title
                  Container(
                    width: 120,
                    height: 120,
                    child: Center(
                      child: Image.asset(
                        'assets/images/new_double_heart_3d.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  )
                  .animate(onPlay: (controller) {
                    controller.repeat();
                  })
                  .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 800.ms, curve: Curves.easeInOut)
                  .then()
                  .scale(begin: const Offset(1.1, 1.1), end: const Offset(1, 1), duration: 800.ms, curve: Curves.easeInOut),
                  
                  const SizedBox(height: 20),
                  
                  Text(
                    'LoveSense',
                    style: AppTextStyles.displayLarge.copyWith(
                      fontSize: 40,
                      color: AppColors.primary,
                      letterSpacing: 2,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                  
                  Text(
                    'Tìm kiếm một nửa hoàn hảo',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ).animate().fadeIn(delay: 400.ms),

                  const SizedBox(height: 40),

                  // Auth Form
                  GlassContainer(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          _isRegistering ? 'Tạo tài khoản' : 'Chào mừng quay trở lại',
                          style: AppTextStyles.titleLarge.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 25),
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
                        const SizedBox(height: 15),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: 'Mật khẩu',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        if (_isRegistering) ...[
                          const SizedBox(height: 15),
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintText: 'Xác nhận mật khẩu',
                              prefixIcon: const Icon(Icons.lock_reset_outlined),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: Colors.grey,
                                ),
                                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ],
                        
                        if (!_isRegistering) ...[
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      value: _rememberMe,
                                      onChanged: (val) => setState(() => _rememberMe = val ?? false),
                                      activeColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () => setState(() => _rememberMe = !_rememberMe),
                                    child: const Text('Ghi nhớ', style: TextStyle(fontSize: 12, color: Colors.black54)),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                                  );
                                },
                                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                child: Text(
                                  'Quên mật khẩu?',
                                  style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 20),
                        GradientButton(
                          text: _isRegistering ? 'Đăng ký' : 'Đăng nhập',
                          onPressed: _handleAuth,
                          isLoading: authState.isLoading,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () => setState(() => _isRegistering = !_isRegistering),
                          child: Text(
                            _isRegistering 
                              ? 'Đã có tài khoản? Đăng nhập' 
                              : 'Chưa có tài khoản? Đăng ký',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),

                  const SizedBox(height: 30),

                  // Social Login
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Hoặc tiếp tục với',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ).animate().fadeIn(delay: 800.ms),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _SocialButton(
                        icon: FontAwesomeIcons.google,
                        color: Colors.red,
                        onTap: () => _handleSocialLogin('Google'),
                      ),
                      _SocialButton(
                        icon: FontAwesomeIcons.facebook,
                        color: Colors.blue,
                        onTap: () => _handleSocialLogin('Facebook'),
                      ),
                      _SocialButton(
                        icon: FontAwesomeIcons.apple,
                        color: Colors.black,
                        onTap: () => _handleSocialLogin('Apple'),
                      ),
                    ],
                  ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.1, end: 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: FaIcon(
          icon,
          color: color,
          size: 24,
        ),
      ),
    );
  }
}
