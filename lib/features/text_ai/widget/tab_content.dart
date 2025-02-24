import 'package:flutter/material.dart';
import 'package:one_ai/features/text_ai/widget/features_grid.dart';
import 'package:one_ai/features/text_ai/widget/input_section.dart';
import 'package:one_ai/features/text_ai/widget/output_section.dart';
import 'package:one_ai/features/text_ai/config/feature_sections.dart';
import 'package:one_ai/features/text_ai/widget/custom_snackbar.dart';

class TabContent extends StatelessWidget {
  final FeatureTab tab;
  final String selectedFeature;
  final bool isLoading;
  final Function(String) onFeatureSelected;
  final TextEditingController inputController;
  final TextEditingController outputController;
  final String lang;
  final VoidCallback onTextChanged;

  const TabContent({
    super.key,
    required this.tab,
    required this.selectedFeature,
    required this.isLoading,
    required this.onFeatureSelected,
    required this.inputController,
    required this.outputController,
    required this.lang,
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        FeaturesGrid(
          tab: tab,
          selectedFeature: selectedFeature,
          isLoading: isLoading,
          onFeatureSelected: onFeatureSelected,
          lang: lang,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InputSection(
              controller: inputController,
              lang: lang,
              onTextChanged: onTextChanged,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: OutputSection(
              controller: outputController,
              isLoading: isLoading,
              lang: lang,
              onCopy: (text) {
                CustomSnackbar.show(context, message: 'Copied to clipboard');
              },
              onClear: () => outputController.clear(),
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
      ],
    );
  }
} 