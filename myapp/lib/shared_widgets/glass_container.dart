import 'package:flutter/material.dart';
import '../../core/utils/glass_effect.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: Theme.of(context).brightness == Brightness.dark
          ? GlassEffect.darkGlass
          : GlassEffect.lightGlass,
      child: child,
    );
  }
}
