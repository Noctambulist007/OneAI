import 'package:flutter/material.dart';
import 'package:one_ai/features/image_ai/model/feature_item.dart';

class FeatureSections {
  static const String basicSection = 'Basic Features';
  static const String analysisSection = 'Analysis Features';
  static const String advancedSection = 'Advanced Features';
  static const String translationSection = 'Translation Features';

  static List<Map<String, dynamic>> getSections(Function getFeatureCallback) {
    return [
      {
        'title': basicSection,
        'features': [
          FeatureItem(
            id: 'describe',
            label: 'Describe Image',
            icon: Icons.image_search,
            onPressed: () => getFeatureCallback('describe'),
          ),
          FeatureItem(
            id: 'generate',
            label: 'Generate Image',
            icon: Icons.auto_awesome,
            isComingSoon: true,
          ),
          FeatureItem(
            id: 'extract_text',
            label: 'Extract Text',
            icon: Icons.text_fields,
            onPressed: () => getFeatureCallback('extract_text'),
          ),
          FeatureItem(
            id: 'handwriting',
            label: 'Scan Handwriting',
            icon: Icons.draw,
            onPressed: () => getFeatureCallback('handwriting'),
          ),
        ],
      },
      {
        'title': analysisSection,
        'features': [
          FeatureItem(
            id: 'prescription',
            label: 'Analyze Prescription',
            icon: Icons.medical_services,
            onPressed: () => getFeatureCallback('prescription'),
            isNew: true,
          ),
          FeatureItem(
            id: 'document',
            label: 'Analyze Document',
            icon: Icons.description,
            onPressed: () => getFeatureCallback('document'),
          ),
          FeatureItem(
            id: 'nutrition',
            label: 'Nutrition Info',
            icon: Icons.lunch_dining,
            onPressed: () => getFeatureCallback('nutrition'),
          ),
          FeatureItem(
            id: 'math',
            label: 'Solve Math',
            icon: Icons.functions,
            onPressed: () => getFeatureCallback('math'),
          ),
        ],
      },
      {
        'title': advancedSection,
        'features': [
          FeatureItem(
            id: 'code',
            label: 'Analyze Code',
            icon: Icons.code,
            onPressed: () => getFeatureCallback('code'),
          ),
          FeatureItem(
            id: 'product',
            label: 'Product Review',
            icon: Icons.star,
            onPressed: () => getFeatureCallback('product'),
          ),
          FeatureItem(
            id: 'property',
            label: 'Property Analysis',
            icon: Icons.home,
            onPressed: () => getFeatureCallback('property'),
          ),
          FeatureItem(
            id: 'tech',
            label: 'Tech Specs',
            icon: Icons.computer,
            onPressed: () => getFeatureCallback('tech'),
          ),
          FeatureItem(
            id: 'chart',
            label: 'Chart Analysis',
            icon: Icons.bar_chart,
            onPressed: () => getFeatureCallback('chart'),
          ),
        ],
      },
      {
        'title': translationSection,
        'features': [
          FeatureItem(
            id: 'currency',
            label: 'Convert Currency',
            icon: Icons.monetization_on,
            onPressed: () => getFeatureCallback('currency'),
          ),
          FeatureItem(
            id: 'translate',
            label: 'Translate Text',
            icon: Icons.translate,
            onPressed: () => getFeatureCallback('translate'),
          ),
        ],
      },
    ];
  }
}
