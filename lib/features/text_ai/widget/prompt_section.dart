import 'package:flutter/material.dart';
import 'package:one_ai/utils/constant/colors.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/text_ai/provider/prompt_features_provider.dart';

class PromptSection extends StatelessWidget {
  final String category;

  const PromptSection({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final features =
        context.watch<PromptFeaturesProvider>().getFeaturesByCategory(category);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            category,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: features.length,
          itemBuilder: (context, index) {
            final feature = features[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.black12,
              child: ListTile(
                title: Text(
                  feature.title,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  feature.description,
                  style: TextStyle(
                    color: AppColors.textWhite.withOpacity(0.7),
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textWhite,
                  size: 16,
                ),
                onTap: () {
                  // Handle feature selection
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
