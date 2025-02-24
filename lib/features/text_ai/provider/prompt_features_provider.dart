import 'package:flutter/foundation.dart';

class PromptFeature {
  final String title;
  final String description;
  final List<String> examples;
  final String category;

  PromptFeature({
    required this.title,
    required this.description,
    required this.examples,
    required this.category,
  });
}

class PromptFeaturesProvider extends ChangeNotifier {
  final List<PromptFeature> _features = [
    // Creative Writing
    PromptFeature(
      title: 'Story Generation',
      description: 'Generate creative stories with detailed plots',
      examples: ['Write a sci-fi story', 'Create a mystery plot'],
      category: 'Creative Writing',
    ),
    PromptFeature(
      title: 'Poetry Creation',
      description: 'Create various styles of poetry',
      examples: ['Write a haiku', 'Create a sonnet'],
      category: 'Creative Writing',
    ),

    // Technical Writing
    PromptFeature(
      title: 'Code Documentation',
      description: 'Generate clear code documentation',
      examples: ['Document API endpoints', 'Write class documentation'],
      category: 'Technical Writing',
    ),

    // Business Writing
    PromptFeature(
      title: 'Email Templates',
      description: 'Professional email templates',
      examples: ['Write follow-up email', 'Create meeting invitation'],
      category: 'Business Writing',
    ),
  ];

  List<PromptFeature> get features => _features;

  List<String> get categories =>
      _features.map((e) => e.category).toSet().toList();

  List<PromptFeature> getFeaturesByCategory(String category) {
    return _features.where((f) => f.category == category).toList();
  }
}
