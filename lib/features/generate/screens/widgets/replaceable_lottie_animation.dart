import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatelessWidget {
  const LottieAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: Lottie.asset(
        'assets/animations/onboarding2.json',
        reverse: true,
        repeat: true,
        fit: BoxFit.cover,
      ),
    );
  }
}
