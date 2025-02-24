import 'dart:ui';

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
