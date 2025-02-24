import 'package:flutter/material.dart';
import 'package:one_ai/features/text_ai/config/feature_sections.dart';
import 'package:one_ai/features/text_ai/widget/feature_chip.dart';
import 'package:one_ai/features/subscription/model/subscription_plan.dart';
import 'package:one_ai/features/subscription/model/restricted_feature.dart';
import 'package:one_ai/features/subscription/provider/subscription_provider.dart';
import 'package:provider/provider.dart';

class FeaturesGrid extends StatelessWidget {
  final FeatureTab tab;
  final String selectedFeature;
  final bool isLoading;
  final Function(String) onFeatureSelected;
  final String lang;

  const FeaturesGrid({
    super.key,
    required this.tab,
    required this.selectedFeature,
    required this.isLoading,
    required this.onFeatureSelected,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: size.width > 600 ? 3 : 2,
          childAspectRatio: 2.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final feature = tab.features[index];
            return _buildFeatureChip(
              context,
              feature.id,
              feature.title[lang] ?? feature.title['en']!,
              feature.icon,
            );
          },
          childCount: tab.features.length,
        ),
      ),
    );
  }

  Widget _buildFeatureChip(
      BuildContext context, String id, String label, IconData icon) {
    final feature = RestrictedFeature.textFeatures.firstWhere(
      (f) => f.id == id,
      orElse: () => RestrictedFeature(
        id: id,
        name: label,
        description: '',
        minimumPlan: SubscriptionType.free,
        lockedMessage: '',
      ),
    );

    final subscriptionProvider = context.read<SubscriptionProvider>();
    if (!subscriptionProvider.canUseFeature(feature)) {
      return FeatureChip(
        label: label,
        icon: Icons.lock,
        isLocked: true,
        onTap: () => subscriptionProvider.showUpgradeDialog(context, feature),
      );
    }

    return FeatureChip(
      label: label,
      icon: icon,
      isSelected: selectedFeature == id,
      onTap: isLoading ? null : () => onFeatureSelected(id),
    );
  }
}
