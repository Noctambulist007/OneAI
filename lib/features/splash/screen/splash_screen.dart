import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_ai/features/home/screen/home_screen.dart';
import 'package:one_ai/features/walkthrough/screen/onboarding/onboarding_screen.dart';
import 'package:one_ai/utils/constant/colors.dart';
import 'package:one_ai/utils/constant/image_strings.dart';
import 'package:one_ai/utils/constant/sizes.dart';
import 'package:one_ai/utils/constant/text_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late SharedPreferences _prefs;
  late AnimationController _logoAnimationController;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _setupAnimations();
    _initializePreferences();
  }

  void _setupAnimations() {
    _logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    _logoAnimationController.forward();
  }

  void _initializePreferences() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      bool showOnboarding = _prefs.getBool('showOnboarding') ?? true;

      Future.delayed(const Duration(milliseconds: 800), () {
        if (showOnboarding) {
          _prefs.setBool('showOnboarding', false);
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const OnBoardingScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 500),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  HomeScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 500),
            ),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary.withOpacity(0.5),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [
              AppColors.backgroundPrimary.withOpacity(0.2),
              AppColors.backgroundPrimary.withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _logoAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _logoAnimation.value,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        const Image(
                          image: AssetImage(AppImages.appLogo),
                          height: 60,
                          width: 60,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              FadeTransition(
                opacity: _logoAnimation,
                child: const Text(
                  AppTexts.appSlogan,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'RobotoMono',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
