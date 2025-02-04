import 'package:flutter/material.dart';
import 'package:one_ai/utils/constants/colors.dart';
import 'features/splash/screen/splash_screen.dart';

class OneAI extends StatelessWidget {
  const OneAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'HindSiliguri',
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundPrimary,
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.darkContainer,
          background: AppColors.backgroundPrimary,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
