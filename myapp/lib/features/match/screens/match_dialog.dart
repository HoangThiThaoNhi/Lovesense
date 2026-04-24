import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../models/user_model.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../shared_widgets/gradient_button.dart';
import '../../../theme.dart';

class MatchDialog extends ConsumerWidget {
  final User matchedUser;
  
  const MatchDialog({super.key, required this.matchedUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authProvider).currentUser;
    final currentUserPhoto = (currentUser?.imageUrls.isNotEmpty ?? false) 
        ? currentUser!.imageUrls.first 
        : 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?auto=format&fit=crop&w=800&q=80';

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Premium Blurred Background with moving colors
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
              ),
            ),
          ),
          
          // 2. Main Content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header Text with Glow
                ShaderMask(
                  shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                  child: Text(
                    "Bạn đã thích một ai đó!",
                    style: AppTextStyles.displayLarge.copyWith(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ).animate().scale(duration: 800.ms, curve: Curves.elasticOut).fadeIn(),
                
                const SizedBox(height: 40),
                
                // 3D Cards Section
                SizedBox(
                  height: 320,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Aura/Glow behind cards
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 100,
                              spreadRadius: 20,
                            ),
                          ],
                        ),
                      ).animate(onPlay: (c) {
                        c.repeat(reverse: true);
                      })
                       .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 2.seconds),

                      // Current User Card (3D Perspective Left)
                      Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(-0.2)
                          ..rotateZ(-0.1)
                          ..translate(-70.0, 0.0, 0.0),
                        alignment: Alignment.center,
                        child: _build3DCard(currentUserPhoto),
                      ).animate().slideX(begin: -1, end: 0, duration: 900.ms, curve: Curves.easeOutBack),
                      
                      // Matched User Card (3D Perspective Right)
                      Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(0.2)
                          ..rotateZ(0.1)
                          ..translate(70.0, 0.0, 0.0),
                        alignment: Alignment.center,
                        child: _build3DCard(matchedUser.imageUrls.isNotEmpty ? matchedUser.imageUrls.first : ''),
                      ).animate().slideX(begin: 1, end: 0, duration: 900.ms, curve: Curves.easeOutBack),
                      
                      // Central Pulsing Heart
                      _buildFloatingHeart().animate(onPlay: (c) {
                        c.repeat();
                      })
                        .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 1.seconds, curve: Curves.easeInOut)
                        .then().scale(begin: const Offset(1.2, 1.2), end: const Offset(1, 1), duration: 1.seconds),
                    ],
                  ),
                ),
                
                const SizedBox(height: 40),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Bạn đã yêu thích ${matchedUser.name}.\nHãy gửi lời chào để bắt đầu trò chuyện nhé!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: Colors.white, 
                      height: 1.6,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ).animate().fadeIn(delay: 600.ms).moveY(begin: 20, end: 0),
                ),
                
                const SizedBox(height: 50),
                
                // Animated Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: GradientButton(
                    text: 'Gửi tin nhắn',
                    onPressed: () {
                      context.pop();
                      context.go('/matches');
                    },
                    width: double.infinity,
                    icon: Icons.chat_bubble_rounded,
                  ).animate().scale(delay: 800.ms, curve: Curves.easeOutBack),
                ),
                
                const SizedBox(height: 20),
                
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text(
                    'Tiếp tục khám phá',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white30,
                    ),
                  ),
                ).animate().fadeIn(delay: 1000.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _build3DCard(String photoUrl) {
    return Container(
      width: 170,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(photoUrl.isNotEmpty ? photoUrl : 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500&auto=format&fit=crop&q=60'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingHeart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.6),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Icon(Icons.favorite, color: AppColors.primary, size: 44),
    );
  }
}
