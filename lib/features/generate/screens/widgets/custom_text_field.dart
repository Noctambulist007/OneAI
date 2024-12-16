import 'package:flutter/material.dart';
import 'package:scannify/features/generate/providers/qr_provider.dart';
import 'package:scannify/utils/constants/colors.dart';

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'QR message...',
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
