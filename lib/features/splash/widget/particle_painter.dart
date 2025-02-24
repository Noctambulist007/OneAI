import 'package:flutter/material.dart';
import 'package:one_ai/features/splash/widget/particle.dart';
import 'package:one_ai/utils/constant/colors.dart';

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

      if (particle.position.dx > size.width) {
        particle.position = Offset(0, particle.position.dy);
      }
      if (particle.position.dx < 0) {
        particle.position = Offset(size.width, particle.position.dy);
      }
      if (particle.position.dy > size.height) {
        particle.position = Offset(particle.position.dx, 0);
      }
      if (particle.position.dy < 0) {
        particle.position = Offset(particle.position.dx, size.height);
      }

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
