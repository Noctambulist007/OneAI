import 'package:flutter/material.dart';
import 'package:one_ai/utils/constant/colors.dart';

class FeatureRow extends StatelessWidget {
  final String feature;
  final String value;

  const FeatureRow({
    Key? key,
    required this.feature,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(width: 12),
        Text(
          feature,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 16,
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
