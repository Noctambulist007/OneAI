import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Border? border;
  final List<Color>? gradientColors;
  final Alignment? gradientBegin;
  final Alignment? gradientEnd;
  final EdgeInsetsGeometry? margin;

  const GlassContainer({
    Key? key,
    required this.child,
    this.borderRadius,
    this.padding,
    this.border,
    this.gradientColors,
    this.gradientBegin,
    this.gradientEnd,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: gradientBegin ?? Alignment.topLeft,
                end: gradientEnd ?? Alignment.bottomRight,
                colors: gradientColors ??
                    [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.05),
                    ],
              ),
              borderRadius: borderRadius ?? BorderRadius.circular(20),
              border: border ??
                  Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1.5,
                  ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
