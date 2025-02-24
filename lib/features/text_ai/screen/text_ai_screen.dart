import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/utils/constant/colors.dart';
import 'package:one_ai/features/text_ai/widget/text_ai_header.dart';
import 'package:one_ai/features/text_ai/widget/usage_info_section.dart';
import 'package:one_ai/features/text_ai/widget/tab_bar_header.dart';
import 'package:one_ai/features/text_ai/config/feature_sections.dart';
import 'package:one_ai/features/text_ai/widget/gradient_background.dart';
import 'package:one_ai/features/text_ai/widget/tab_content.dart';
import 'package:one_ai/features/text_ai/service/text_processor.dart';
import 'package:one_ai/features/text_ai/provider/language_provider.dart';
import 'package:one_ai/features/auth/provider/auth_provider.dart';
import 'package:one_ai/features/text_ai/widget/custom_snackbar.dart';

class TextAiScreen extends StatefulWidget {
  @override
  _TextAiScreenState createState() => _TextAiScreenState();
}

class _TextAiScreenState extends State<TextAiScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  bool _isLoading = false;
  String _selectedFeature = '';

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FeatureSections.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  void _onFeatureSelected(String featureId) async {
    setState(() {
      _selectedFeature = featureId;
    });
    await _processText(featureId);
  }

  Future<void> _processText(String action) async {
    if (_inputController.text.isEmpty) {
      CustomSnackbar.show(
        context,
        message: 'Please enter some text',
        isError: true,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final lang = context.read<LanguageProvider>().currentLanguage;

      final result = await TextProcessor.process(
        context,
        action,
        _inputController.text,
        lang,
        authProvider,
      );

      if (result != null) {
        setState(() {
          _outputController.text = result;
        });
      }
    } catch (e) {
      CustomSnackbar.show(
        context,
        message: 'Error processing text: $e',
        isError: true,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>().currentLanguage;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: GradientBackground(
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: TextAiHeader(),
              ),
              const UsageInfoSection(),
              TabBarHeader(tabController: _tabController),
            ],
            body: TabBarView(
              controller: _tabController,
              children: FeatureSections.tabs.map((tab) {
                return TabContent(
                  tab: tab,
                  selectedFeature: _selectedFeature,
                  isLoading: _isLoading,
                  onFeatureSelected: _onFeatureSelected,
                  inputController: _inputController,
                  outputController: _outputController,
                  lang: lang,
                  onTextChanged: () => setState(() {}),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
