import 'package:flutter/material.dart';
import 'package:one_ai/features/image_ai/widget/glass_action_button.dart';
import 'package:one_ai/features/subscription/model/restricted_feature.dart';

class FeatureGrid extends StatelessWidget {
  final List<RestrictedFeature> features;
  final bool Function(RestrictedFeature) isFeatureLocked;
  final Function(RestrictedFeature) onFeaturePressed;

  const FeatureGrid({
    Key? key,
    required this.features,
    required this.isFeatureLocked,
    required this.onFeaturePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index >= features.length) return null;
          final feature = features[index];
          final isLocked = isFeatureLocked(feature);

          return GlassActionButton(
            title: feature.name,
            icon: isLocked ? Icons.lock : Icons.image,
            onPressed: () => onFeaturePressed(feature),
            isLocked: isLocked,
          );
        },
        childCount: features.length,
      ),
    );
  }
} 