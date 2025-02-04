import 'package:flutter/material.dart';
import 'package:one_ai/features/generate/providers/qr_provider.dart';
import 'package:one_ai/utils/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.qrState,
  });

  final QRState qrState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundPrimary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            style: const TextStyle(
              color: AppColors.white,
            ),
            decoration: const InputDecoration(
              hintText: 'QR message...',
              hintStyle: TextStyle(
                color: AppColors.grey,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            maxLines: 5,
            maxLength: 100,
            controller: qrState.textController,
            cursorColor: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
