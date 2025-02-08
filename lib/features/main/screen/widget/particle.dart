import 'dart:ui';

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
