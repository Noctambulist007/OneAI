import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scannify/features/navigation/screens/navigation_menu.dart';
import 'package:scannify/features/walkthrough/screens/onboarding/onboarding.dart';
import 'package:scannify/utils/constants/image_strings.dart';
import 'package:scannify/utils/constants/sizes.dart';
import 'package:scannify/utils/constants/text_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late SharedPreferences _prefs;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();

    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;

      bool showOnboarding = _prefs.getBool('showOnboarding') ?? true;

      if (showOnboarding) {
        _prefs.setBool('showOnboarding', false);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
        );
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const NavigationMenu()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0F826B), Color(0xff014348)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: const Image(
                    image: AssetImage(AppImages.appLogo),
                    height: 150,
                    width: 150,
                  ),
                );
              },
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            const Text(
              AppTexts.appSlogan,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'Poppins',
              ),
            ),
            const Spacer(flex: 3),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage(AppImages.companyAppLogo),
                  height: 50,
                  width: 50,
                ),
                SizedBox(height: AppSizes.spaceBtwItems),
                Text(
                  AppTexts.companySlogan,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
