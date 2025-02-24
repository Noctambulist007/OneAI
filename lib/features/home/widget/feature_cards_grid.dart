import 'package:flutter/material.dart';
import 'package:one_ai/features/auth/provider/auth_provider.dart';
import 'package:one_ai/features/auth/screen/login_screen.dart';
import 'package:one_ai/features/home/provider/home_provider.dart';
import 'package:one_ai/features/home/widget/featured_card.dart';
import 'package:one_ai/features/image_ai/screen/image_ai_screen.dart';
import 'package:one_ai/features/text_ai/text_ai_screen.dart';
import 'package:one_ai/utils/constant/colors.dart';
import 'package:provider/provider.dart';

class FeatureCardsGrid extends StatelessWidget {
  const FeatureCardsGrid({super.key});

  void _checkAuthAndNavigate(BuildContext context, Widget screen) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to access this feature',
              style: TextStyle(color: AppColors.textWhite)),
          backgroundColor: AppColors.error,
        ),
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeProvider>();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FeaturedCard(
                model: provider.textAIFeature,
                onTap: () => _checkAuthAndNavigate(context, TextAiScreen()),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FeaturedCard(
                model: provider.scanAIFeature,
                onTap: () =>
                    _checkAuthAndNavigate(context, const ImageAiScreen()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: FeaturedCard(
                model: provider.voiceAIFeature,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FeaturedCard(
                model: provider.videoAIFeature,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
