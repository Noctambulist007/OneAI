import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:one_ai/features/home/model/feature_card_model.dart';
import 'package:one_ai/features/image_ai/screen/image_ai_screen.dart';
import 'package:one_ai/features/text_ai/text_ai_screen.dart';
import 'package:one_ai/utils/constant/colors.dart';

class HomeProvider extends ChangeNotifier {
  final TickerProvider vsync;
  late final AnimationController particleController;
  late final AnimationController pulseController;
  BuildContext? _context;
  late final FeatureCardModel _textAIFeature;
  late final FeatureCardModel _scanAIFeature;
  late final FeatureCardModel _voiceAIFeature;
  late final FeatureCardModel _videoAIFeature;

  HomeProvider({required this.vsync}) {
    _initializeControllers();
    _initializeFeatures();
  }

  void _initializeControllers() {
    particleController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 2),
    )..repeat();

    pulseController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  void _initializeFeatures() {
    _textAIFeature = FeatureCardModel(
      title: 'Text AI',
      description: 'Analyze and process text with AI',
      icon: Icons.text_fields,
      gradientColors: [AppColors.primary, AppColors.secondary],
    );

    _scanAIFeature = FeatureCardModel(
      title: 'Image AI',
      description: 'Analyze and process images with AI',
      icon: Icons.image,
      gradientColors: [AppColors.secondary, AppColors.primary],
    );

    _voiceAIFeature = FeatureCardModel(
      title: 'Voice AI',
      description: 'Analyze and process voice with AI',
      icon: Icons.record_voice_over_rounded,
      gradientColors: const [AppColors.primary, AppColors.secondary],
      onTap: () => showComingSoonDialog(null, 'Voice AI'),
      isComingSoon: true,
    );

    _videoAIFeature = FeatureCardModel(
      title: 'Video AI',
      description: 'Analyze and process videos with AI',
      icon: Icons.videocam_rounded,
      gradientColors: [AppColors.primary, AppColors.secondary.withBlue(150)],
      onTap: () => showComingSoonDialog(null, 'Video AI'),
      isComingSoon: true,
    );
  }

  @override
  void dispose() {
    particleController.dispose();
    pulseController.dispose();
    super.dispose();
  }

  FeatureCardModel get textAIFeature => _textAIFeature;

  FeatureCardModel get scanAIFeature => _scanAIFeature;

  FeatureCardModel get voiceAIFeature => _voiceAIFeature;

  FeatureCardModel get videoAIFeature => _videoAIFeature;

  void setContext(BuildContext context) {
    _context = context;
  }

  void navigateToTextAI(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => TextAiScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void navigateToScanAI(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ImageAiScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void showComingSoonDialog(BuildContext? context, String title) {
    final ctx = context ?? _context;
    if (ctx != null) {
      showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xff0F826B), Color(0xff014348)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/animations/rocket.json',
                    height: 150,
                    width: 150,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This feature is coming soon!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xff0F826B),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('OK', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
