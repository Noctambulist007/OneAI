import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_ai/features/main/screen/main_screen.dart';
import 'package:one_ai/features/splash/screen/widget/particle.dart';
import 'package:one_ai/features/splash/screen/widget/particle_painter.dart';
import 'package:one_ai/features/walkthrough/screens/onboarding/onboarding_screen.dart';
import 'package:one_ai/utils/constants/colors.dart';
import 'package:one_ai/utils/constants/image_strings.dart';
import 'package:one_ai/utils/constants/sizes.dart';
import 'package:one_ai/utils/constants/text_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late SharedPreferences _prefs;
  late AnimationController _logoAnimationController;
  late AnimationController _particleAnimationController;
  late AnimationController _pulseAnimationController;
  late Animation<double> _logoAnimation;
  late Animation<double> _pulseAnimation;

  final List<Particle> _particles = [];
  final int numberOfParticles = 50;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _setupAnimations();
    _generateParticles();
    _initializePreferences();
  }

  void _setupAnimations() {
    _logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    _particleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _pulseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _pulseAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _logoAnimationController.forward();
  }

  void _generateParticles() {
    for (int i = 0; i < numberOfParticles; i++) {
      _particles.add(Particle(
        position: Offset(
          math.Random().nextDouble() * 400 - 200,
          math.Random().nextDouble() * 400 - 200,
        ),
        velocity: Offset(
          math.Random().nextDouble() * 2 - 1,
          math.Random().nextDouble() * 2 - 1,
        ),
        size: math.Random().nextDouble() * 4 + 1,
      ));
    }
  }

  void _initializePreferences() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      bool showOnboarding = _prefs.getBool('showOnboarding') ?? true;

      Future.delayed(const Duration(seconds: 3), () {
        if (showOnboarding) {
          _prefs.setBool('showOnboarding', false);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => MainScreen()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _particleAnimationController.dispose();
    _pulseAnimationController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.5),
        ),
        child: Stack(
          children: [
            CustomPaint(
              painter: ParticlePainter(
                particles: _particles,
                animation: _particleAnimationController,
              ),
              size: Size.infinite,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  AnimatedBuilder(
                    animation: _logoAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoAnimation.value,
                        child: AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
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
                                          color: AppColors.primary
                                              .withOpacity(0.3),
                                          blurRadius: 30,
                                          spreadRadius: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Image(
                                    image: AssetImage(AppImages.appLogo),
                                    height: 80,
                                    width: 80,
                                  ),
                                ],
                              ),
                            );
                          },
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
                  const Spacer(flex: 3),
                  FadeTransition(
                    opacity: _logoAnimation,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                            fontFamily: 'RobotoMono',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
