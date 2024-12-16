import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scannify/features/scanai/providers/scan_ai_provider.dart';

class ImageDisplay extends StatelessWidget {
  const ImageDisplay({
    Key? key,
    required this.scanProvider,
  }) : super(key: key);

  final ScanAIProvider scanProvider;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.white,
        child: scanProvider.image != null
            ? Image.file(
                File(scanProvider.image!.path),
                fit: BoxFit.cover,
              )
            : Lottie.asset(
                'assets/animations/avatar.json',
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
