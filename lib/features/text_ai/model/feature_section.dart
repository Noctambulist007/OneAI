import 'package:flutter/material.dart';

class FeatureSection {
  final String id;
  final Map<String, String> title;
  final IconData icon;
  final List<FeatureItem> features;

  const FeatureSection({
    required this.id,
    required this.title,
    required this.icon,
    required this.features,
  });
}

class FeatureItem {
  final String id;
  final IconData icon;

  const FeatureItem({
    required this.id,
    required this.icon,
  });
}
