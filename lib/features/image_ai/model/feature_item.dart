import 'package:flutter/material.dart';

class FeatureItem {
  final String id;
  final String label;
  final IconData icon;
  final Function()? onPressed;
  final bool isComingSoon;
  final bool isNew;

  const FeatureItem({
    required this.id,
    required this.label,
    required this.icon,
    this.onPressed,
    this.isComingSoon = false,
    this.isNew = false,
  });
}
