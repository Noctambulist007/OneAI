import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:one_ai/features/image_ai/widget/glass_action_button.dart';
import 'package:one_ai/features/image_ai/provider/image_ai_provider.dart';

class ImagePreviewSection extends StatelessWidget {
  final ImageAiProvider scanProvider;
  final VoidCallback onChooseImage;

  const ImagePreviewSection({
    super.key,
    required this.scanProvider,
    required this.onChooseImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: scanProvider.image != null
                    ? Image.file(
                        File(scanProvider.image!.path),
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Lottie.asset(
                          'assets/animations/avatar.json',
                          height: 300,
                          width: 300,
                        ),
                      ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        GlassActionButton(
          title: 'Choose Image',
          icon: Icons.add_photo_alternate,
          onPressed: onChooseImage,
        ),
      ],
    );
  }
} 