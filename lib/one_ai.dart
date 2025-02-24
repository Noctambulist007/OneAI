import 'package:flutter/material.dart';
import 'package:one_ai/utils/constant/colors.dart';
import 'package:one_ai/utils/navigation/navigation_service.dart';
import 'features/splash/screen/splash_screen.dart';

class OneAI extends StatelessWidget {
  const OneAI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
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
