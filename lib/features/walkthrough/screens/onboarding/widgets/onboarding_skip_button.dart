import 'package:flutter/material.dart';
import 'package:dashscan/features/walkthrough/providers/onboarding/onboarding_provider.dart';
import 'package:dashscan/utils/constants/colors.dart';
import 'package:dashscan/utils/constants/sizes.dart';
import 'package:dashscan/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppDeviceUtils.of(context).getAppBarHeight(),
      right: AppSizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingProvider.instance.skipPage(context),
        child: const Text(
          'Skip',
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}
