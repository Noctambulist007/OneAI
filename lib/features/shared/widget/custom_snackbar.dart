import 'package:flutter/material.dart';
import 'package:one_ai/utils/constant/colors.dart';

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
    IconData? icon,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              icon ?? (isError ? Icons.error_outline : Icons.check_circle),
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: (isError ? AppColors.error : AppColors.success).withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
} 