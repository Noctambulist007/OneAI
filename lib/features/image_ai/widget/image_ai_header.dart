import 'package:flutter/material.dart';
import 'package:one_ai/features/text_ai/widget/glass_container.dart';
import 'package:one_ai/features/text_ai/widget/glass_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/image_ai/provider/image_ai_provider.dart';

class ImageAiHeader extends StatelessWidget {
  const ImageAiHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ImageAiProvider>(context);
    
    return GlassContainer(
      borderRadius: BorderRadius.zero,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GlassIconButton(
            icon: Icons.arrow_back_rounded,
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(width: 12),
          const Text(
            'Image AI',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          if (scanProvider.hasResults)
            GlassIconButton(
              icon: Icons.refresh,
              onTap: () => scanProvider.clearResults(),
            ),
        ],
      ),
    );
  }
} 