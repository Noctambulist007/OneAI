import 'package:flutter/material.dart';

class FeatureTab {
  final String id;
  final Map<String, String> title;
  final IconData icon;
  final List<FeatureItem> features;

  const FeatureTab({
    required this.id,
    required this.title,
    required this.icon,
    required this.features,
  });
}

class FeatureItem {
  final String id;
  final Map<String, String> title;
  final IconData icon;

  const FeatureItem({
    required this.id,
    required this.title,
    required this.icon,
  });
}

class FeatureSections {
  static const List<FeatureTab> tabs = [
    FeatureTab(
      id: 'writing',
      title: {
        'en': 'Writing',
        'bn': 'লেখা',
      },
      icon: Icons.edit_note_rounded,
      features: [
        FeatureItem(
          id: 'text_summarize',
          title: {
            'en': 'Summarize Text',
            'bn': 'সারাংশ',
          },
          icon: Icons.summarize,
        ),
        FeatureItem(
          id: 'paragraph_generator',
          title: {
            'en': 'Paragraph Generator',
            'bn': 'অনুচ্ছেদ জেনারেটর',
          },
          icon: Icons.text_fields,
        ),
        FeatureItem(
          id: 'text_expand',
          title: {
            'en': 'Expand Text',
            'bn': 'বিস্তৃত',
          },
          icon: Icons.expand,
        ),
      ],
    ),
    FeatureTab(
      id: 'blog',
      title: {
        'en': 'Blog Tools',
        'bn': 'ব্লগ টুলস',
      },
      icon: Icons.post_add,
      features: [
        FeatureItem(
          id: 'post_title',
          title: {
            'en': 'Post Title Generator',
            'bn': 'পোস্ট টাইটেল জেনারেটর',
          },
          icon: Icons.title,
        ),
        FeatureItem(
          id: 'blog_ideas',
          title: {
            'en': 'Blog Post Ideas',
            'bn': 'ব্লগ আইডিয়া',
          },
          icon: Icons.lightbulb_outline,
        ),
        FeatureItem(
          id: 'blog_intro',
          title: {
            'en': 'Blog Intros',
            'bn': 'ব্লগ ভূমিকা',
          },
          icon: Icons.play_arrow_rounded,
        ),
        FeatureItem(
          id: 'blog_section',
          title: {
            'en': 'Blog Section',
            'bn': 'ব্লগ সেকশন',
          },
          icon: Icons.view_stream,
        ),
        FeatureItem(
          id: 'blog_conclusion',
          title: {
            'en': 'Blog Conclusion',
            'bn': 'ব্লগ উপসংহার',
          },
          icon: Icons.stop_circle_outlined,
        ),
        FeatureItem(
          id: 'article_generator',
          title: {
            'en': 'Article Generator',
            'bn': 'আর্টিকেল জেনারেটর',
          },
          icon: Icons.article,
        ),
      ],
    ),
    FeatureTab(
      id: 'improvement',
      title: {
        'en': 'Improvement',
        'bn': 'উন্নতি',
      },
      icon: Icons.auto_fix_high,
      features: [
        FeatureItem(
          id: 'text_grammar',
          title: {
            'en': 'Grammar Correction',
            'bn': 'ব্যাকরণ সংশোধন',
          },
          icon: Icons.spellcheck,
        ),
        FeatureItem(
          id: 'text_paraphrase',
          title: {
            'en': 'Paraphrase',
            'bn': 'পুনর্লিখন',
          },
          icon: Icons.repeat,
        ),
      ],
    ),
    FeatureTab(
      id: 'analysis',
      title: {
        'en': 'Analysis',
        'bn': 'বিশ্লেষণ',
      },
      icon: Icons.analytics,
      features: [
        FeatureItem(
          id: 'text_sentiment',
          title: {
            'en': 'Sentiment Analysis',
            'bn': 'অনুভূতি বিশ্লেষণ',
          },
          icon: Icons.mood,
        ),
        FeatureItem(
          id: 'text_keywords',
          title: {
            'en': 'Keywords Extraction',
            'bn': 'মূল শব্দ নির্বাচন',
          },
          icon: Icons.key,
        ),
      ],
    ),
  ];
}
