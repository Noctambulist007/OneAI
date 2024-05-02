import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:dashscan/utils/constants/sizes.dart';
import 'package:dashscan/utils/device/device_utility.dart';

class OnBoardingPage extends StatelessWidget {
  final String animationAsset;
  final String title;
  final String subtitle;

  const OnBoardingPage({
    required this.animationAsset,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppDeviceUtils>(
      create: (context) => AppDeviceUtils(),
      child: Builder(
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff0F826B), Color(0xff014348)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/$animationAsset.json',
                  reverse: true,
                  repeat: true,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}