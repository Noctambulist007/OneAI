import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/subscription/model/restricted_feature.dart';
import 'package:one_ai/features/subscription/provider/subscription_provider.dart';
import 'package:one_ai/features/image_ai/widget/glass_action_button.dart';

class FeatureButton extends StatelessWidget {
  final RestrictedFeature feature;
  final Function(String) onProcess;

  const FeatureButton({
    super.key,
    required this.feature,
    required this.onProcess,
  });

  @override
  Widget build(BuildContext context) {
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context);
    final isLocked = !subscriptionProvider.canUseFeature(feature);

    return GlassActionButton(
      title: feature.name,
      icon: isLocked ? Icons.lock : Icons.image,
      onPressed: isLocked
          ? () => subscriptionProvider.showUpgradeDialog(context, feature)
          : () => onProcess(feature.id),
      isLocked: isLocked,
    );
  }
} 