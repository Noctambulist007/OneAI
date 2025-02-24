import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/image_ai/provider/image_ai_provider.dart';
import 'package:one_ai/features/auth/provider/auth_provider.dart';
import 'package:one_ai/features/shared/widget/custom_snackbar.dart';

class FeatureProcessor {
  static Future<void> process(BuildContext context, String featureId) async {
    final imageProvider = Provider.of<ImageAiProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (imageProvider.image == null) {
      await imageProvider.getImage();
      if (imageProvider.image == null) {
        CustomSnackbar.show(
          context,
          message: 'Please select an image first',
          isError: true,
        );
        return;
      }
    }

    try {
      final usageError = await authProvider.checkUsageLimits(context, 'image');
      if (usageError != null) {
        CustomSnackbar.show(
          context,
          message: usageError,
          isError: true,
        );
        return;
      }

      await imageProvider.processFeature(featureId);
      await authProvider.incrementImageGeneration();

      CustomSnackbar.show(
        context,
        message: 'Image processed successfully',
      );
    } catch (e) {
      print('Error processing image: $e');
      CustomSnackbar.show(
        context,
        message: 'Failed to process image',
        isError: true,
      );
    }
  }
} 