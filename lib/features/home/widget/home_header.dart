import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:one_ai/utils/constant/colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.pulseController,
  });

  final AnimationController pulseController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Bounce(
            child: AnimatedBuilder(
              animation: pulseController,
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary
                            .withOpacity(0.2 + pulseController.value * 0.2),
                        blurRadius: 20 + pulseController.value * 10,
                        spreadRadius: 5 + pulseController.value * 5,
                      ),
                    ],
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.secondary,
                      ],
                    ).createShader(bounds),
                    child: Lottie.asset(
                      'assets/animations/robot.json',
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
