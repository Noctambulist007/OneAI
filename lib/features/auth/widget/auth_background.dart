import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:one_ai/utils/constant/colors.dart';

class AuthBackground extends StatelessWidget {
  final AnimationController animationController;
  final Widget child;

  const AuthBackground({
    Key? key,
    required this.animationController,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: const [
                    AppColors.primary,
                    AppColors.secondary,
                    Color(0xFF1D5C5C),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                  transform:
                      GradientRotation(animationController.value * 2 * 3.14159),
                ),
              ),
            );
          },
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.white.withOpacity(0.1)),
        ),
        child,
      ],
    );
  }
}
