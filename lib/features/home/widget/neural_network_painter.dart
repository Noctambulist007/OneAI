import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:one_ai/features/home/widget/particle.dart';

class NeuralNetworkPainter extends CustomPainter {
  final Animation<double> animation;
  final Color particleColor;
  final List<Particle> particles;
  final Paint _paint;
  static const int PARTICLE_COUNT = 20;
  static const double CONNECTION_DISTANCE = 80.0;

  NeuralNetworkPainter({
    required this.animation,
    required this.particleColor,
  })  : _paint = Paint()
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke,
        particles = List.generate(
          PARTICLE_COUNT,
          (i) => Particle(
            position: Offset(
              math.Random().nextDouble() * 400,
              math.Random().nextDouble() * 800,
            ),
            velocity: Offset(
              math.Random().nextDouble() * 2 - 1,
              math.Random().nextDouble() * 2 - 1,
            ),
          ),
        ),
        super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final double delta = animation.value;

    for (var particle in particles) {
      particle.update(size, delta);
      _paint.color = particleColor;
      canvas.drawCircle(particle.position, 2, _paint);

      for (var j = particles.indexOf(particle) + 1; j < particles.length; j++) {
        var other = particles[j];
        final distance = (particle.position - other.position).distance;
        if (distance < CONNECTION_DISTANCE) {
          final opacity = (1 - distance / CONNECTION_DISTANCE) * 0.3;
          _paint.color = particleColor.withOpacity(opacity);
          canvas.drawLine(particle.position, other.position, _paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(NeuralNetworkPainter oldDelegate) => true;
}
