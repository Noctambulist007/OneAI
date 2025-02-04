import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_ai/features/main/screen/main_screen.dart';
import 'package:one_ai/features/navigation/screens/navigation_menu.dart';
import 'package:one_ai/features/walkthrough/screens/onboarding/onboarding.dart';
import 'package:one_ai/utils/constants/colors.dart';
import 'package:one_ai/utils/constants/image_strings.dart';
import 'package:one_ai/utils/constants/sizes.dart';
import 'package:one_ai/utils/constants/text_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
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
    // Logo animation
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

    // Particle animation
    _particleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Pulse animation
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
            // Animated particles
            CustomPaint(
              painter: ParticlePainter(
                particles: _particles,
                animation: _particleAnimationController,
              ),
              size: Size.infinite,
            ),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  // Animated logo
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
                                  // Glowing effect
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
                                  // Logo
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
                  // Animated text
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
                  // Company logo
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

class Particle {
  Offset position;
  Offset velocity;
  final double size;

  Particle({
    required this.position,
    required this.velocity,
    required this.size,
  });

  void update() {
    position += velocity;
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Animation<double> animation;

  ParticlePainter({
    required this.particles,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    for (var particle in particles) {
      particle.update();

      // Wrap particles around screen
      if (particle.position.dx > size.width) particle.position = Offset(0, particle.position.dy);
      if (particle.position.dx < 0) particle.position = Offset(size.width, particle.position.dy);
      if (particle.position.dy > size.height) particle.position = Offset(particle.position.dx, 0);
      if (particle.position.dy < 0) particle.position = Offset(particle.position.dx, size.height);

      canvas.drawCircle(
        Offset(
          particle.position.dx + size.width / 2,
          particle.position.dy + size.height / 2,
        ),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}