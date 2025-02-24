import 'package:flutter/material.dart';
import 'package:one_ai/features/image_ai/model/feature_item.dart';
import 'package:one_ai/features/image_ai/widget/feature_chip.dart';

class FeatureSection extends StatelessWidget {
  final String title;
  final List<FeatureItem> features;
  final bool hasImage;

  const FeatureSection({
    super.key,
    required this.title,
    required this.features,
    required this.hasImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: features.map((feature) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FeatureChip(
                  feature: feature,
                  hasImage: hasImage,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
