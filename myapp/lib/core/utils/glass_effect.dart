import 'dart:ui';
import 'package:flutter/material.dart';
import '../../theme.dart';

class GlassEffect {
  static BoxDecoration lightGlass = BoxDecoration(
    gradient: AppColors.glassGradient,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.white.withOpacity(0.2)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ],
  );

  static BoxDecoration darkGlass = BoxDecoration(
    gradient: AppColors.darkGlassGradient,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.white.withOpacity(0.1)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ],
  );
}