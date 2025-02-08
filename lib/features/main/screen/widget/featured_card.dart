import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:motion/motion.dart';
import 'package:one_ai/utils/constants/colors.dart';

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({
    super.key,
    required AnimationController pulseController,
    required this.title,
    required this.description,
    required this.icon,
    required this.gradientColors,
    required this.onTap,
  }) : _pulseController = pulseController;

  final AnimationController _pulseController;
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Motion.elevated(
      elevation: 70,
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return GestureDetector(
            onTap: onTap,
            child: SizedBox(
              height: 200,
              child: Stack(
                children: [
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: gradientColors[0].withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    gradientColors[0].withOpacity(0.2),
                                    gradientColors[1].withOpacity(0.2),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: gradientColors[0].withOpacity(
                                        0.1 + _pulseController.value * 0.1),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Icon(
                                icon,
                                color: gradientColors[0],
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  color: AppColors.textWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            Text(
                              description,
                              style: TextStyle(
                                color: AppColors.textWhite.withOpacity(0.8),
                                fontSize: 12,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: gradientColors[0],
                                  size: 24,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: onTap,
                        hoverColor: gradientColors[0].withOpacity(0.1),
                        splashColor: gradientColors[1].withOpacity(0.2),
                        highlightColor: gradientColors[0].withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
