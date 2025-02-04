import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class AnimatedRobot extends StatefulWidget {
  @override
  _AnimatedRobotState createState() => _AnimatedRobotState();
}

class _AnimatedRobotState extends State<AnimatedRobot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    // Create a curved animation that moves the robot diagonally
    _positionAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset(-0.5, -0.5),
          end: Offset(1.5, 1.5),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset(1.5, 1.5),
          end: Offset(-0.5, -0.5),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _positionAnimation,
      child: Lottie.asset(
        'assets/animations/robot.json',
        height: 100,
        width: 100,
        fit: BoxFit.contain,
      ),
    );
  }
}