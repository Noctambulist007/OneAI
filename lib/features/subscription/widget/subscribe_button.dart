import 'package:flutter/material.dart';
import 'package:one_ai/utils/constant/colors.dart';
import 'package:shimmer/shimmer.dart';

class SubscribeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SubscribeButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text(
            'Upgrade Now',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Shimmer.fromColors(
              period: const Duration(seconds: 3),
              baseColor: Colors.transparent,
              highlightColor: Colors.white.withOpacity(0.2),
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
