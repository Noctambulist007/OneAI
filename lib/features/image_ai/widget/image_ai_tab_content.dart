import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_ai/features/subscription/model/restricted_feature.dart';
import 'package:one_ai/features/image_ai/provider/image_ai_provider.dart';
import 'package:one_ai/features/image_ai/widget/image_preview_section.dart';
import 'package:one_ai/features/image_ai/widget/image_ai_results.dart';
import 'package:provider/provider.dart';

class ImageAiTabContent extends StatelessWidget {
  final int tabIndex;
  final List<RestrictedFeature> features;
  final Widget Function(BuildContext, RestrictedFeature) featureButtonBuilder;

  const ImageAiTabContent({
    super.key,
    required this.tabIndex,
    required this.features,
    required this.featureButtonBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= features.length) return null;
                return featureButtonBuilder(context, features[index]);
              },
              childCount: features.length,
            ),
          ),
        ),

        // Image Preview and Results
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Consumer<ImageAiProvider>(
              builder: (context, scanProvider, _) {
                return ImagePreviewSection(
                  scanProvider: scanProvider,
                  onChooseImage: scanProvider.getImage,
                );
              },
            ),
          ),
        ),

        // Results Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer<ImageAiProvider>(
              builder: (context, scanProvider, _) {
                return ImageAiResults(
                  isLoading: scanProvider.isLoading,
                  hasResults: scanProvider.hasResults,
                  results: _getResults(scanProvider),
                  onCopy: (text) => _copyToClipboard(context, text),
                );
              },
            ),
          ),
        ),

        const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
      ],
    );
  }

  Map<String, String> _getResults(ImageAiProvider scanProvider) {
    final results = <String, String>{};
    if (scanProvider.description.isNotEmpty) {
      results['Image Description'] = scanProvider.description;
    }
    if (scanProvider.extractedText.isNotEmpty) {
      results['Extracted Text'] = scanProvider.extractedText;
    }
    // Add other results...
    return results;
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Copied to clipboard'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xff0F826B).withOpacity(0.9),
      ),
    );
  }
} 