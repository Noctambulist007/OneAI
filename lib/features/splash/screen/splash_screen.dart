import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dashscan/features/navigation/screens/navigation_menu.dart';
import 'package:dashscan/features/walkthrough/screens/onboarding/onboarding.dart';
import 'package:dashscan/utils/constants/image_strings.dart';
import 'package:dashscan/utils/constants/sizes.dart';
import 'package:dashscan/utils/constants/text_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;

      bool showOnboarding = _prefs.getBool('showOnboarding') ?? true;

      if (showOnboarding) {
        _prefs.setBool('showOnboarding', false);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
        );
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const NavigationMenu()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
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
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Image(
              image: AssetImage(AppImages.appLogo),
              height: 150,
              width: 150,
            ),
            SizedBox(height: AppSizes.spaceBtwItems),
            Spacer(
              flex: 3,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                    image: AssetImage(AppImages.companyAppLogo),
                    height: 25,
                    width: 25,
                    color: Colors.green),
                SizedBox(height: AppSizes.spaceBtwItems),
                Text(
                  AppTexts.companySlogan,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins'),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
