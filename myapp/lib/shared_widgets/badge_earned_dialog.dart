import 'package:flutter/material.dart';
import '../models/gamification_model.dart';
import '../theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';

class BadgeEarnedDialog extends StatelessWidget {
  final BadgeModel badge;
  final int? points;

  const BadgeEarnedDialog({
    super.key,
    required this.badge,
    this.points,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Color(badge.color).withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Celebration Animation
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color(badge.color).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ).animate(onPlay: (c) {
                    c.repeat();
                  })
                   .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 2.seconds, curve: Curves.easeInOutSine)
                   .blurXY(begin: 10, end: 0, duration: 2.seconds),
                  
                  Text(
                    badge.emoji,
                    style: const TextStyle(fontSize: 80),
                  ).animate()
                   .scale(delay: 300.ms, duration: 600.ms, curve: Curves.elasticOut)
                   .rotate(begin: -0.2, end: 0),
                ],
              ),
              
              const SizedBox(height: 24),
              
              const Text(
                'CHÚC MỪNG!',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 2,
                ),
              ).animate().fadeIn(delay: 500.ms),
              
              const SizedBox(height: 8),
              
              Text(
                'Bạn đã đạt danh hiệu',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ).animate().fadeIn(delay: 700.ms),
              
              Text(
                badge.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ).animate().scale(delay: 900.ms, duration: 400.ms, curve: Curves.easeOutBack),
              
              const SizedBox(height: 16),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[100]!),
                ),
                child: Text(
                  badge.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ).animate().slideY(begin: 0.2, end: 0, delay: 1100.ms).fadeIn(),
              
              const SizedBox(height: 24),
              
              if (points != null && points! > 0)
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: AppColors.mainGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        '+$points XP',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ).animate().scale(delay: 1300.ms),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'TUYỆT VỜI!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ).animate().fadeIn(delay: 1500.ms),
            ],
          ),
        ),
      ),
    );
  }
}
