import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:one_ai/features/main/screen/widget/featured_card.dart';
import 'package:one_ai/features/main/screen/widget/main_header.dart';
import 'package:one_ai/features/main/screen/widget/neural_network_painter.dart';
import 'package:one_ai/features/navigation/screens/navigation_menu.dart';
import 'package:one_ai/features/scan_ai/screens/scan_ai_screen.dart';
import 'package:one_ai/features/text_ai/ai_text_processor.dart';
import 'dart:ui';
import 'package:one_ai/utils/constants/colors.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController _particleController;
  late AnimationController _pulseController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _particleController.dispose();
    _pulseController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary.withOpacity(0.5),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: NeuralNetworkPainter(
              animation: _particleController,
              particleColor: AppColors.primary.withOpacity(0.15),
            ),
            size: Size.infinite,
          ),
          Container(
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
          ),
          SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 250.0,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      textAlign: TextAlign.center,
                      'OneAI\nOne Click, One Solution',
                      style: TextStyle(
                        color: AppColors.textWhite.withOpacity(0.9),
                        fontSize: 12,
                        fontFamily: 'RobotoMono',
                        letterSpacing: 0.5,
                      ),
                    ),
                    background: MainHeader(pulseController: _pulseController),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Row(
                        children: [
                          Expanded(
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 300),
                              delay: const Duration(milliseconds: 100),
                              child: FeaturedCard(
                                  pulseController: _pulseController,
                                  title: 'লিখন AI',
                                  description:
                                      'টেক্সট প্রসেসিং, অনুবাদ এবং আরও অনেক কিছু',
                                  icon: Icons.text_format_rounded,
                                  gradientColors: const [
                                    AppColors.primary,
                                    AppColors.secondary
                                  ],
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => AITextProcessor()),
                                      )),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 300),
                              delay: const Duration(milliseconds: 200),
                              child: FeaturedCard(
                                  pulseController: _pulseController,
                                  title: 'নকশা AI',
                                  description:
                                      'ছবি প্রসেসিং, রূপান্তর এবং আরও অনেক কিছু',
                                  icon: Icons.image_rounded,
                                  gradientColors: [
                                    AppColors.primary,
                                    AppColors.secondary.withBlue(150)
                                  ],
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const ScanAiScreen()),
                                      )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 300),
                              delay: const Duration(milliseconds: 100),
                              child: FeaturedCard(
                                  isComingSoon: true,
                                  pulseController: _pulseController,
                                  title: 'কথা AI',
                                  description:
                                      'কথা প্রসেসিং, রূপান্তর এবং আরও অনেক কিছু',
                                  icon: Icons.record_voice_over_rounded,
                                  gradientColors: const [
                                    AppColors.primary,
                                    AppColors.secondary
                                  ],
                                  onTap: () => _showComingSoonDialog(context,
                                      'কথা AI', 'এই ফিচারটি আসছে খুব শীঘ্রই!')),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 300),
                              delay: const Duration(milliseconds: 200),
                              child: FeaturedCard(
                                  isComingSoon: true,
                                  pulseController: _pulseController,
                                  title: 'বায়োস্কোপ AI',
                                  description:
                                      'ভিডিও প্রসেসিং, রূপান্তর এবং আরও অনেক কিছু',
                                  icon: Icons.videocam_rounded,
                                  gradientColors: [
                                    AppColors.primary,
                                    AppColors.secondary.withBlue(150)
                                  ],
                                  onTap: () => _showComingSoonDialog(
                                      context,
                                      'বায়োস্কোপ AI',
                                      'এই ফিচারটি আসছে খুব শীঘ্রই!')),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        duration: const Duration(milliseconds: 300),
                        delay: const Duration(milliseconds: 300),
                        child: FeaturedCard(
                            pulseController: _pulseController,
                            title: 'QR',
                            description:
                                'QR কোড তৈরি করুন অথবা স্ক্যান করে তথ্য দেখুন',
                            icon: Icons.qr_code_scanner_rounded,
                            gradientColors: [
                              AppColors.primary,
                              AppColors.secondary.withBlue(150)
                            ],
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const NavigationMenu()),
                                )),
                      ),
                      const SizedBox(height: 40),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoonDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
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
                  message,
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
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('ঠিক আছে', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
