import 'package:flutter/material.dart';
import 'package:one_ai/utils/constant/colors.dart';

class FeatureChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isLocked;
  final VoidCallback? onTap;

  const FeatureChip({
    required this.label,
    required this.icon,
    this.isSelected = false,
    this.isLocked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isLocked
                  ? [
                      Colors.grey.withOpacity(0.2),
                      Colors.grey.withOpacity(0.1),
                    ]
                  : isSelected
                      ? [
                          AppColors.primary.withOpacity(0.3),
                          AppColors.secondary.withOpacity(0.3),
                        ]
                      : [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.5)
                  : Colors.white.withOpacity(0.1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isLocked
                    ? Colors.grey
                    : isSelected
                        ? AppColors.primary
                        : Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isLocked
                      ? Colors.grey
                      : isSelected
                          ? AppColors.primary
                          : Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
