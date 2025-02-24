import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:one_ai/utils/constant/colors.dart';

class GlassActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isLocked;

  const GlassActionButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.isLocked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isLocked
                  ? [
                      Colors.grey.withOpacity(0.2),
                      Colors.grey.withOpacity(0.1),
                    ]
                  : [
                      AppColors.primary.withOpacity(0.2),
                      AppColors.secondary.withOpacity(0.2),
                    ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isLocked
                  ? Colors.grey.withOpacity(0.2)
                  : Colors.white.withOpacity(0.2),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: isLocked ? Colors.grey : Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: isLocked ? Colors.grey : Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (isLocked)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'PRO',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
