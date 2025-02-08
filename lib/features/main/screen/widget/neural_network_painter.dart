import 'package:flutter/material.dart';
import 'package:one_ai/features/main/screen/widget/connection.dart';
import 'package:one_ai/features/main/screen/widget/particle.dart';
import 'dart:math' as math;

class NeuralNetworkPainter extends CustomPainter {
  final Animation<double> animation;
  final Color particleColor;
  final List<Particle> particles = [];
  final List<Connection> connections = [];

  NeuralNetworkPainter({
    required this.animation,
    required this.particleColor,
  }) : super(repaint: animation) {
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

    for (var particle in particles) {
      particle.update(size, animation.value);
      canvas.drawCircle(particle.position, 3, paint);

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
