import 'package:flutter/material.dart';

class FeatureCardModel {
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradientColors;
  final VoidCallback? onTap;
  final bool isComingSoon;

  const FeatureCardModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradientColors,
    this.onTap,
    this.isComingSoon = false,
  });
}
