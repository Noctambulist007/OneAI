import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scannify/features/walkthrough/providers/onboarding/onboarding_provider.dart';
import 'package:scannify/features/walkthrough/screens/onboarding/widgets/onboarding_dots_navigation.dart';
import 'package:scannify/features/walkthrough/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:scannify/features/walkthrough/screens/onboarding/widgets/onboarding_page.dart';
import 'package:scannify/features/walkthrough/screens/onboarding/widgets/onboarding_skip_button.dart';
import 'package:scannify/utils/constants/text_strings.dart';
import 'package:scannify/utils/device/device_utility.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
        ChangeNotifierProvider(create: (_) => AppDeviceUtils()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Stack(
              children: [
                PageView(
                  controller: context.read<OnBoardingProvider>().pageController,
                  onPageChanged: (index) => context
                      .read<OnBoardingProvider>()
                      .updatePageIndicator(index),
                  children: const [
                    OnBoardingPage(
                      animationAsset: 'onboarding1',
                      title: AppTexts.onBoardingTitle1,
                      subtitle: AppTexts.onBoardingSubTitle1,
                    ),
                    OnBoardingPage(
                      animationAsset: 'onboarding2',
                      title: AppTexts.onBoardingTitle2,
                      subtitle: AppTexts.onBoardingSubTitle2,
                    ),
                    OnBoardingPage(
                      animationAsset: 'onboarding3',
                      title: AppTexts.onBoardingTitle3,
                      subtitle: AppTexts.onBoardingSubTitle3,
                    ),
                  ],
                ),

                // Skip Button
                const OnBoardingSkip(),

                // PageIndicator
                const OnBoardingNavigationDots(),

                // Next Button
                const OnBoardingNextButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}
