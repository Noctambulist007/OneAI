import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:motion/motion.dart';
import 'package:one_ai/features/main/screen/widget/animated_robot.dart';
import 'package:one_ai/features/navigation/screens/navigation_menu.dart';
import 'package:one_ai/features/scanai/screens/scan_ai_screen.dart';
import 'package:one_ai/features/text_ai/ai_text_processor.dart';
import 'dart:ui';

import 'package:one_ai/utils/constants/colors.dart';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

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
      duration: Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
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
          // Animated Neural Network Background
          CustomPaint(
            painter: NeuralNetworkPainter(
              animation: _particleController,
              particleColor: AppColors.primary.withOpacity(0.15),
            ),
            size: Size.infinite,
          ),

          // Gradient Overlay
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

          // Main Scrollable Content
          SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              slivers: [
                // Animated SliverAppBar
                SliverAppBar(
                  expandedHeight: 250.0,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title:Text(
                      textAlign: TextAlign.center,
                      'OneAI\nOne Click, One Solution',
                      style: TextStyle(
                        color: AppColors.textWhite.withOpacity(0.9),
                        fontSize: 12,
                        fontFamily: 'RobotoMono', // Changed to 'RobotoMono' for a more robotic look
                        letterSpacing: 0.5,
                      ),
                    ),
                      background: _buildEnhancedHeader(),
                  ),
                ),

                // Feature Cards
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // First Row of Feature Cards
                      Row(
                        children: [
                          Expanded(
                            child: FadeInUp(
                              duration: Duration(milliseconds: 300),
                              delay: Duration(milliseconds: 100),
                              child: _buildEnhancedFeatureCard(
                                title: 'লিখন AI',
                                description: 'টেক্সট প্রসেসিং, অনুবাদ এবং আরও অনেক কিছু',
                                icon: Icons.text_format_rounded,
                                gradientColors: [AppColors.primary, AppColors.secondary],
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => AITextProcessor()),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: FadeInUp(
                              duration: Duration(milliseconds: 300),
                              delay: Duration(milliseconds: 200),
                              child: _buildEnhancedFeatureCard(
                                title: 'নকশা AI',
                                description: 'ছবি প্রসেসিং, রূপান্তর এবং আরও অনেক কিছু',
                                icon: Icons.image_rounded,
                                gradientColors: [
                                  AppColors.primary,
                                  AppColors.secondary.withBlue(150)
                                ],
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => ScanAiScreen()),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Second Row of Feature Cards
                      Row(
                        children: [
                          Expanded(
                            child: FadeInUp(
                              duration: Duration(milliseconds: 300),
                              delay: Duration(milliseconds: 100),
                              child: _buildEnhancedFeatureCard(
                                title: 'কথা AI',
                                description: 'কথা প্রসেসিং, রূপান্তর এবং আরও অনেক কিছু',
                                icon: Icons.record_voice_over_rounded,
                                gradientColors: [AppColors.primary, AppColors.secondary],
                                onTap: () => _showComingSoonDialog(context, 'কথা AI', 'এই ফিচারটি আসছে খুব শীঘ্রই!')
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: FadeInUp(
                              duration: Duration(milliseconds: 300),
                              delay: Duration(milliseconds: 200),
                              child: _buildEnhancedFeatureCard(
                                title: 'বায়োস্কোপ AI',
                                description: 'ভিডিও প্রসেসিং, রূপান্তর এবং আরও অনেক কিছু',
                                icon: Icons.videocam_rounded,
                                gradientColors: [
                                  AppColors.primary,
                                  AppColors.secondary.withBlue(150)
                                ],
                                onTap: () => _showComingSoonDialog(context, 'বায়োস্কোপ AI', 'এই ফিচারটি আসছে খুব শীঘ্রই!')
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // QR AI Card
                      FadeInUp(
                        duration: Duration(milliseconds: 300),
                        delay: Duration(milliseconds: 300),
                        child: _buildEnhancedFeatureCard(
                          title: 'QR AI',
                          description: 'QR কোড তৈরি করুন অথবা স্ক্যান করে তথ্য দেখুন',
                          icon: Icons.qr_code_scanner_rounded,
                          gradientColors: [
                            AppColors.primary,
                            AppColors.secondary.withBlue(150)
                          ],
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => NavigationMenu()),
                          ),
                        ),
                      ),

                      // Additional padding at the bottom
                      SizedBox(height: 40),
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

  // Rest of the methods remain the same as in the original implementation
  Widget _buildEnhancedHeader() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Logo
          Bounce(
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary
                            .withOpacity(0.2 + _pulseController.value * 0.2),
                        blurRadius: 20 + _pulseController.value * 10,
                        spreadRadius: 5 + _pulseController.value * 5,
                      ),
                    ],
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.secondary,
                      ],
                    ).createShader(bounds),
                    child: Lottie.asset(
                      'assets/animations/robot.json',
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // _buildEnhancedFeatureCard method remains exactly the same as in the original implementation
  Widget _buildEnhancedFeatureCard({
    required String title,
    required String description,
    required IconData icon,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    // Identical to the previous implementation
    return Motion.elevated(
      elevation: 70,
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              height: 200,
              child: Stack(
                children: [
                  // Glassmorphic Background
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: gradientColors[0].withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    gradientColors[0].withOpacity(0.2),
                                    gradientColors[1].withOpacity(0.2),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: gradientColors[0].withOpacity(
                                        0.1 + _pulseController.value * 0.1),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Icon(
                                icon,
                                color: gradientColors[0],
                                size: 28,
                              ),
                            ),
                            SizedBox(height: 8),
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  color: AppColors.textWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            Text(
                              description,
                              style: TextStyle(
                                color: AppColors.textWhite.withOpacity(0.8),
                                fontSize: 12,
                                letterSpacing: 0.3,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: gradientColors[0],
                                  size: 24,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Interactive Ripple Effect
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: onTap,
                        hoverColor: gradientColors[0].withOpacity(0.1),
                        splashColor: gradientColors[1].withOpacity(0.2),
                        highlightColor: gradientColors[0].withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(24),
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
                SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xff0F826B),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Got it!', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NeuralNetworkPainter extends CustomPainter {
  final Animation<double> animation;
  final Color particleColor;
  final List<Particle> particles = [];
  final List<Connection> connections = [];

  NeuralNetworkPainter({
    required this.animation,
    required this.particleColor,
  }) : super(repaint: animation) {
    // Initialize particles and connections
    for (int i = 0; i < 30; i++) {
      particles.add(Particle(
        position: Offset(
          math.Random().nextDouble() * 400,
          math.Random().nextDouble() * 800,
        ),
        velocity: Offset(
          math.Random().nextDouble() * 2 - 1,
          math.Random().nextDouble() * 2 - 1,
        ),
      ));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = particleColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Update and draw particles
    for (var particle in particles) {
      particle.update(size, animation.value);
      canvas.drawCircle(particle.position, 3, paint);

      // Draw connections between nearby particles
      for (var other in particles) {
        if (particle != other) {
          final distance = (particle.position - other.position).distance;
          if (distance < 100) {
            final opacity = (1 - distance / 100) * 0.5;
            canvas.drawLine(
              particle.position,
              other.position,
              paint..color = particleColor.withOpacity(opacity),
            );
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Particle {
  Offset position;
  Offset velocity;

  Particle({required this.position, required this.velocity});

  void update(Size size, double delta) {
    position += velocity * 2;

    if (position.dx < 0 || position.dx > size.width) {
      velocity = Offset(-velocity.dx, velocity.dy);
    }
    if (position.dy < 0 || position.dy > size.height) {
      velocity = Offset(velocity.dx, -velocity.dy);
    }
  }
}

class Connection {
  final Particle particle1;
  final Particle particle2;

  Connection(this.particle1, this.particle2);
}
