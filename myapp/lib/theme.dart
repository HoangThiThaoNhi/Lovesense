import 'package:flutter/material.dart';
// Using bundled font family 'Google Sans Flex' (add ttf files to assets/fonts/)

class AppColors {
  static const LinearGradient mainGradient = LinearGradient(
    colors: [Color(0xFFB6E0FE), Color(0xFFE3F2FD)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF64B5F6), Color(0xFF2196F3)], // Saturated blue for better contrast
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient chatBubbleMeGradient = LinearGradient(
    colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient chatBubbleAIGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFF1F8FE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Colors.white30, Colors.white10],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGlassGradient = LinearGradient(
    colors: [Colors.black54, Colors.black26],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Backgrounds
  static const Color backgroundLight = Color(0xFFF3F5F9);
  static const Color backgroundDark = Color(0xFF1A1A2E);

  // Text
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Colors.white;

  // Accents
  static const Color primary = Color(0xFF89CFF0);
  static const Color secondary = Color(0xFFAEC6CF);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);
}

class AppTextStyles {
  static const String fontFamily = 'Google Sans Flex';

  static TextStyle get displayLarge => const TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
      letterSpacing: 0.0,
      height: 1.05,
      );

  static TextStyle get displayMedium => const TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
      letterSpacing: 0.0,
      height: 1.05,
      );

  static TextStyle get titleLarge => const TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      letterSpacing: 0.0,
      height: 1.1,
      );

  static TextStyle get bodyLarge => const TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
      letterSpacing: 0.2,
      height: 1.35,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
      letterSpacing: 0.15,
      height: 1.35,
      );

  static TextStyle get headlineMedium => displayMedium;
  static TextStyle get headlineSmall => titleLarge;
}

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: AppTextStyles.fontFamily,
  scaffoldBackgroundColor: AppColors.backgroundLight,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
  ),
  textTheme: TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    titleLarge: AppTextStyles.titleLarge,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: AppTextStyles.titleLarge,
    iconTheme: const IconThemeData(color: AppColors.textPrimary),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(fontFamily: AppTextStyles.fontFamily, fontWeight: FontWeight.w600),
      elevation: 4,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: AppTextStyles.fontFamily,
  scaffoldBackgroundColor: AppColors.backgroundDark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
  ),
  textTheme: TextTheme(
    displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.textLight),
    displayMedium: AppTextStyles.displayMedium.copyWith(color: AppColors.textLight),
    titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.textLight),
    bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.textLight),
    bodyMedium: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: AppTextStyles.titleLarge.copyWith(color: AppColors.textLight),
    iconTheme: const IconThemeData(color: AppColors.textLight),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(fontFamily: AppTextStyles.fontFamily, fontWeight: FontWeight.w600),
      elevation: 4,
    ),
  ),
);