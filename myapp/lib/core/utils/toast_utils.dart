import 'package:flutter/material.dart';
import '../../theme.dart';

enum ToastType { success, error, warning, info }

class ToastUtils {
  static void showCustomToast(BuildContext context, String message, {ToastType type = ToastType.info}) {
    Color backgroundColor;
    IconData icon;
    List<Color> gradientColors;

    switch (type) {
      case ToastType.success:
        backgroundColor = Colors.green.shade800;
        icon = Icons.check_circle_outline_rounded;
        gradientColors = [const Color(0xFF00b09b), const Color(0xFF96c93d)];
        break;
      case ToastType.error:
        backgroundColor = Colors.red.shade800;
        icon = Icons.error_outline_rounded;
        gradientColors = [const Color(0xFFff5f6d), const Color(0xFFffc371)];
        break;
      case ToastType.warning:
        backgroundColor = Colors.amber.shade800;
        icon = Icons.warning_amber_rounded;
        gradientColors = [const Color(0xFFf12711), const Color(0xFFf5af19)];
        break;
      case ToastType.info:
      default:
        backgroundColor = const Color(0xFF2C5364);
        icon = Icons.info_outline_rounded;
        gradientColors = [const Color(0xFF243B55), const Color(0xFF141E30)];
        break;
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getTypeLabel(type),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        letterSpacing: 1.2,
                      ),
                    ),
                      Text(
                        message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        padding: EdgeInsets.zero,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // Use a persistent background decoration via container wrap
        // SnackBar doesn't support decoration directly, so we use the content container
      ),
    );
  }

  static String _getTypeLabel(ToastType type) {
    switch (type) {
      case ToastType.success: return 'THÀNH CÔNG';
      case ToastType.error: return 'THÔNG BÁO LỖI';
      case ToastType.warning: return 'CẢNH BÁO';
      case ToastType.info: return 'THÔNG TIN';
    }
  }

  // To achieve the perfect rounded look with background, we need to wrap the SnackBar content
  static void showModernToast(BuildContext context, String message, {ToastType type = ToastType.info}) {
     Color primaryColor;
    IconData icon;
    
    switch (type) {
      case ToastType.success:
        primaryColor = const Color(0xFF10B981);
        icon = Icons.check_circle_rounded;
        break;
      case ToastType.error:
        primaryColor = const Color(0xFFEF4444);
        icon = Icons.error_rounded;
        break;
      case ToastType.warning:
        primaryColor = const Color(0xFFF59E0B);
        icon = Icons.warning_rounded;
        break;
      case ToastType.info:
      default:
        primaryColor = const Color(0xFF3B82F6);
        icon = Icons.info_rounded;
        break;
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        padding: EdgeInsets.zero,
        duration: const Duration(seconds: 4),
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A).withOpacity(0.95),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: primaryColor.withOpacity(0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: primaryColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
