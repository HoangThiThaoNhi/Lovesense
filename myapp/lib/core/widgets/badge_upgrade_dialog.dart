import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme.dart';

class BadgeUpgradeDialog extends StatelessWidget {
  final dynamic badge;

  const BadgeUpgradeDialog({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    // Trích xuất dữ liệu an toàn từ Map hoặc Model
    final String name = badge is Map ? (badge['name'] ?? '') : (badge.name ?? '');
    final String? description = badge is Map ? badge['description'] : badge.description;
    final String? iconUrl = badge is Map ? badge['icon_url'] : badge.icon_url;
    final String? emoji = badge is Map ? badge['emoji'] : (badge.emoji ?? '🏆');

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A).withOpacity(0.95),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.amber.withOpacity(0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(0.2),
              blurRadius: 40,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ánh hào quang phía sau
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ).animate(onPlay: (c) => c.repeat()).scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.5, 1.5),
                      duration: 2.seconds,
                      curve: Curves.easeInOut,
                    ).fadeIn(duration: 2.seconds).fadeOut(delay: 1.seconds),
                
                // Icon Huy hiệu
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.amber, Color(0xFFF59E0B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: iconUrl != null && iconUrl.isNotEmpty
                        ? Image.network(iconUrl, width: 60, height: 60, errorBuilder: (_, __, ___) => Text(emoji ?? '🏆', style: const TextStyle(fontSize: 50)))
                        : Text(emoji ?? '🏆', style: const TextStyle(fontSize: 50)),
                  ),
                ).animate().scale(delay: 300.ms, duration: 600.ms, curve: Curves.elasticOut),
              ],
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              'CHÚC MỪNG!',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
              ),
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),
            
            const SizedBox(height: 12),
            
            Text(
              'Bạn đã đạt Huy hiệu $name',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.1),
            
            const SizedBox(height: 16),
            
            Text(
              description ?? 'Bạn đã mở khóa một cột mốc mới trên hành trình tìm kiếm chân ái!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 15,
                height: 1.5,
              ),
            ).animate().fadeIn(delay: 1.seconds),
            
            const SizedBox(height: 40),
            
            // Nút bấm vjp
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'TUYỆT VỜI!',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
              ),
            ).animate().fadeIn(delay: 1.2.seconds).scale(),
            
            const SizedBox(height: 16),
            
            Text(
              'Hãy vào Kho Voucher để nhận quà ngay!',
              style: TextStyle(
                color: Colors.amber.shade200.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 1.5.seconds),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context, dynamic badge) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BadgeUpgradeDialog(badge: badge),
    );
  }
}
