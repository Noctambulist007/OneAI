import 'package:flutter/material.dart';
import 'package:one_ai/features/text_ai/widget/glass_container.dart';

class ImageAiTabBar extends StatelessWidget {
  final TabController tabController;

  const ImageAiTabBar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
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
            tabs: const [
              Tab(
                height: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.description, size: 20),
                    SizedBox(width: 8),
                    Text('Basic'),
                  ],
                ),
              ),
              Tab(
                height: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.document_scanner, size: 20),
                    SizedBox(width: 8),
                    Text('Document'),
                  ],
                ),
              ),
              Tab(
                height: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.analytics, size: 20),
                    SizedBox(width: 8),
                    Text('Analysis'),
                  ],
                ),
              ),
              Tab(
                height: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.architecture, size: 20),
                    SizedBox(width: 8),
                    Text('Technical'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 