import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dashscan/features/walkthrough/providers/onboarding/onboarding_provider.dart';
import 'package:dashscan/utils/constants/colors.dart';
import 'package:dashscan/utils/constants/sizes.dart';
import 'package:dashscan/utils/device/device_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingNavigationDots extends StatelessWidget {
  const OnBoardingNavigationDots({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnBoardingProvider>(
      builder: (context, controller, child) {
        return Positioned(
          bottom:
              AppDeviceUtils.of(context).getBottomNavigationBarHeight() + 25,
          left: AppSizes.defaultSpace,
          child: SmoothPageIndicator(
            controller: controller.pageController,
            onDotClicked: controller.dotNavigationClick,
            count: 3,
            effect: const ExpandingDotsEffect(
              dotColor: AppColors.light,
              activeDotColor: AppColors.primary,
            ),
          ),
        );
      },
    );
  }
}
