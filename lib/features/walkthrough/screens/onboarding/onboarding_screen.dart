import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:one_ai/utils/constants/colors.dart';
import 'package:one_ai/utils/constants/text_strings.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/walkthrough/providers/onboarding/onboarding_provider.dart';
import 'package:one_ai/features/walkthrough/screens/onboarding/widgets/onboarding_page.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnBoardingProvider(),
      child: Builder(
        builder: (context) {
          final provider = context.watch<OnBoardingProvider>();

          final pages = [
            const OnBoardingPage(
              animationAsset: 'text-to-text',
              title: AppTexts.onBoardingTitle1,
              subtitle: 'Transform your text content easily',
              backgroundColor: AppColors.primary,
            ),
            const OnBoardingPage(
              animationAsset: 'image-to-text',
              title: AppTexts.onBoardingTitle2,
              subtitle: 'Extract text from images instantly',
              backgroundColor: const Color(0xff014348),
            ),
            const OnBoardingPage(
              animationAsset: 'qr-scan',
              title: AppTexts.onBoardingTitle3,
              subtitle: 'Quick and accurate QR scanning',
              backgroundColor: AppColors.secondary,
            ),
          ];

          return Scaffold(
            body: Stack(
              children: [
                LiquidSwipe(
                  pages: pages,
                  liquidController: provider.liquidController,
                  onPageChangeCallback: provider.updatePageIndicator,
                  enableLoop: false,
                  fullTransitionValue: 500,
                  enableSideReveal: true,
                  slideIconWidget: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                // Skip Button
                Positioned(
                  top: 50,
                  right: 20,
                  child: TextButton(
                    onPressed: () => provider.skipPage(context),
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                // Next Button
                Positioned(
                  bottom: 30,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () => provider.nextPage(context),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Colors.white,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: provider.currentPageIndex == 2
                          ? const Color(0xff0F826B)
                          : const Color(0xff014348),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
