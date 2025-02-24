import 'package:flutter/material.dart';
import 'package:one_ai/utils/constant/colors.dart';
import 'package:one_ai/features/subscription/model/restricted_feature.dart';
import 'package:one_ai/features/image_ai/widget/image_ai_header.dart';
import 'package:one_ai/features/image_ai/widget/image_ai_tab_content.dart';
import 'package:one_ai/features/image_ai/widget/gradient_background.dart';
import 'package:one_ai/features/image_ai/widget/usage_info_section.dart';
import 'package:one_ai/features/image_ai/widget/tab_bar_header.dart';
import 'package:one_ai/features/image_ai/widget/feature_button.dart';
import 'package:one_ai/features/image_ai/service/feature_processor.dart';

class ImageAiScreen extends StatefulWidget {
  const ImageAiScreen({super.key});

  @override
  _ImageAiScreenState createState() => _ImageAiScreenState();
}

class _ImageAiScreenState extends State<ImageAiScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: GradientBackground(
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: ImageAiHeader(),
              ),
              const UsageInfoSection(),
              TabBarHeader(tabController: _tabController),
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                _buildTabContent(context, 0),
                _buildTabContent(context, 1),
                _buildTabContent(context, 2),
                _buildTabContent(context, 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, int tabIndex) {
    return ImageAiTabContent(
      tabIndex: tabIndex,
      features: _getTabFeatures(tabIndex),
      featureButtonBuilder: (context, feature) => FeatureButton(
        feature: feature,
        onProcess: (featureId) => FeatureProcessor.process(context, featureId),
      ),
    );
  }

  List<RestrictedFeature> _getTabFeatures(int tabIndex) {
    final allFeatures = RestrictedFeature.imageFeatures;
    switch (tabIndex) {
      case 0:
        return allFeatures
            .where((f) => ['describe', 'extract_text'].contains(f.id))
            .toList();
      case 1:
        return allFeatures
            .where((f) =>
                ['handwriting', 'document', 'prescription'].contains(f.id))
            .toList();
      case 2:
        return allFeatures
            .where((f) => ['nutrition', 'product', 'chart'].contains(f.id))
            .toList();
      case 3:
        return allFeatures
            .where((f) => ['tech', 'math', 'code'].contains(f.id))
            .toList();
      default:
        return [];
    }
  }
}
