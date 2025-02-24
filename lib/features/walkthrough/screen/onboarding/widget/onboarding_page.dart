import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatelessWidget {
  final String animationAsset;
  final String title;
  final String subtitle;
  final Color backgroundColor;

  const OnBoardingPage({
    required this.animationAsset,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Lottie.asset(
            'assets/animations/$animationAsset.json',
            reverse: true,
            repeat: true,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 32),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
              fontFamily: 'RobotoMono',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
