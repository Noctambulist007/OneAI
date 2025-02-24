import 'dart:ui';

class Particle {
  Offset position;
  Offset velocity;
  double opacity = 1.0;

  Particle({required this.position, required this.velocity});

  void update(Size size, double delta) {
    position += velocity * delta * 60;

    if (position.dx < 0) {
      position = Offset(0, position.dy);
      velocity = Offset(-velocity.dx * 0.8, velocity.dy);
    } else if (position.dx > size.width) {
      position = Offset(size.width, position.dy);
      velocity = Offset(-velocity.dx * 0.8, velocity.dy);
    }

    if (position.dy < 0) {
      position = Offset(position.dx, 0);
      velocity = Offset(velocity.dx, -velocity.dy * 0.8);
    } else if (position.dy > size.height) {
      position = Offset(position.dx, size.height);
      velocity = Offset(velocity.dx, -velocity.dy * 0.8);
    }

    // Add slight damping
    velocity *= 0.99;
  }
}
