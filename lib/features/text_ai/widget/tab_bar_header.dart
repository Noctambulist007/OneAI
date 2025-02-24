import 'package:flutter/material.dart';
import 'package:one_ai/features/text_ai/widget/sliver_app_bar_delegate.dart';
import 'package:one_ai/features/text_ai/widget/text_ai_tab_bar.dart';

class TabBarHeader extends StatelessWidget {
  final TabController tabController;

  const TabBarHeader({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 70,
        maxHeight: 70,
        child: TextAiTabBar(tabController: tabController),
      ),
    );
  }
} 