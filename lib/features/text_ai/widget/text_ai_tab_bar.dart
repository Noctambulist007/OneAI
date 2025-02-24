import 'package:flutter/material.dart';
import 'package:one_ai/features/text_ai/widget/glass_container.dart';
import 'package:one_ai/features/text_ai/config/feature_sections.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/text_ai/provider/language_provider.dart';

class TextAiTabBar extends StatelessWidget {
  final TabController tabController;

  const TextAiTabBar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>().currentLanguage;

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: TabBar(
            controller: tabController,
            isScrollable: true,
            dividerColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.5),
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            tabs: FeatureSections.tabs.map((tab) {
              return Tab(
                height: 40,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(tab.icon, size: 20),
                      const SizedBox(width: 8),
                      Text(tab.title[lang] ?? tab.title['en']!),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
} 