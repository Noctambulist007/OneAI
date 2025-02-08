import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:one_ai/features/text_ai/provider/prompt_helper.dart';
import 'package:one_ai/utils/constants/colors.dart';

class AITextProcessor extends StatefulWidget {
  @override
  _AITextProcessorState createState() => _AITextProcessorState();
}

class _AITextProcessorState extends State<AITextProcessor>
    with SingleTickerProviderStateMixin {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  bool _isLoading = false;
  String _selectedFeature = '';
  final String apiKey = 'AIzaSyDt1PQOH_zUQrwsZokzhquQ4JNk-2pnJ00';
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.5),
              AppColors.secondary.withOpacity(0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(
                  0.2,
              ),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.2),
                      Colors.transparent
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              left: -100,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.secondary.withOpacity(0.15),
                      Colors.transparent
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  _buildGlassHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildGlassCard(_buildInputSection()),
                          const SizedBox(height: 20),
                          _buildGlassCard(_buildOutputSection()),
                          const SizedBox(height: 20),
                          _buildFeatureButtons(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.5),
                      AppColors.secondary.withOpacity(0.5)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                height: 16,
                width: 3,
                margin: EdgeInsets.only(right: 8),
              ),
              Text(
                'মন্তব্য',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  TextField(
                    controller: _inputController,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                      height: 1.5,
                    ),
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'এখানে আপনার টেক্সট লিখুন...',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        fontSize: 16,
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      border: InputBorder.none,
                    ),
                  ),
                  if (_inputController.text.isNotEmpty)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _buildGlassIconButton(
                        Icons.clear,
                        () => _inputController.clear(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOutputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.secondary.withOpacity(0.5),
                      AppColors.primary.withOpacity(0.5)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                height: 16,
                width: 3,
                margin: const EdgeInsets.only(right: 8),
              ),
              Text(
                'ফলাফল',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              if (_outputController.text.isNotEmpty) ...[
                _buildGlassIconButton(
                  Icons.copy,
                  () {
                    Clipboard.setData(
                        ClipboardData(text: _outputController.text));
                    _showCustomSnackBar(context, 'কপি করা হয়েছে');
                  },
                ),
                const SizedBox(width: 8),
                _buildGlassIconButton(
                  Icons.clear,
                  () => _outputController.clear(),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: _isLoading
                  ? Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black.withOpacity(0.2),
                        ),
                        child: Lottie.asset(
                          'assets/animations/loading_for_ai.json',
                          reverse: true,
                          repeat: true,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : TextField(
                      controller: _outputController,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        height: 1.5,
                      ),
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'ফলাফল এখানে দেখা যাবে...',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.3),
                          fontSize: 16,
                        ),
                        contentPadding: const EdgeInsets.all(20),
                        border: InputBorder.none,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  void _showCustomSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.success.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildGlassCard(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildGlassHeader() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              _buildGlassIconButton(
                Icons.arrow_back_rounded,
                () => Navigator.pop(context),
              ),
              const SizedBox(width: 12),
              Text(
                'লিখন AI',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'HindSiliguri',
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const Spacer(),
              _buildGlassIconButton(
                Icons.info_outline,
                () => _showInfo(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlassIconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.05),
            ],
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Icon(icon, color: Colors.white.withOpacity(0.9), size: 20),
      ),
    );
  }

  Widget _buildFeatureButtons() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.5,
      children: [
        _buildFeatureButton('paraphrase', 'পুনর্লিখন', Icons.autorenew),
        _buildFeatureButton('grammar', 'ব্যাকরণ', Icons.spellcheck),
        _buildFeatureButton('ai_detect', 'AI শনাক্তকরণ', Icons.psychology),
        _buildFeatureButton('plagiarism', 'অনুলিপি', Icons.copyright),
        _buildFeatureButton('summarize', 'সারাংশ', Icons.summarize),
        _buildFeatureButton('translate_en', 'ইংরেজি', Icons.translate),
        _buildFeatureButton('translate_bn', 'বাংলা', Icons.translate),
        _buildFeatureButton('edit', 'সম্পাদনা', Icons.edit),
        _buildFeatureButton('story', 'গল্প', Icons.book),
        _buildFeatureButton('poem', 'কবিতা', Icons.format_quote),
        _buildFeatureButton('headline', 'শিরোনাম', Icons.title),
        _buildFeatureButton('academic', 'একাডেমিক', Icons.school),
        _buildFeatureButton('poetic_prose', 'কাব্যিক গদ্য', Icons.theater_comedy),
        _buildFeatureButton('dialect_convert', 'উপভাষা রূপান্তর', Icons.language),
        _buildFeatureButton('sentiment_analyze', 'আবেগ বিশ্লেষণ', Icons.mood),
        _buildFeatureButton('proverb_generate', 'প্রবাদ বাক্য', Icons.format_quote),
        _buildFeatureButton('formal_informal', 'ভাষা পরিবর্তন', Icons.swap_horiz),
        _buildFeatureButton('creative_writing', 'সৃজনশীল লেখা', Icons.create),
        _buildFeatureButton('word_simplify', 'শব্দ সরলীকরণ', Icons.text_decrease),
        _buildFeatureButton('metaphor_generate', 'রূপক তৈরি', Icons.bubble_chart),
        _buildFeatureButton('letter_write', 'চিঠি লেখা', Icons.mail),
        _buildFeatureButton('script_dialog', 'সংলাপ লেখা', Icons.theater_comedy),
        _buildFeatureButton('idiom_explain', 'প্রবাদ ব্যাখ্যা', Icons.lightbulb),
        _buildFeatureButton('news_article', 'সংবাদ পত্র', Icons.article),
        _buildFeatureButton('essay_write', 'প্রবন্ধ লেখা', Icons.edit_document),
        _buildFeatureButton('speech_write', 'ভাষণ লেখা', Icons.record_voice_over),
        _buildFeatureButton('debate_point', 'বিতর্ক বিন্দু', Icons.account_balance),
        _buildFeatureButton('social_media_post', 'সোশ্যাল মিডিয়া পোস্ট', Icons.share),
        _buildFeatureButton('literary_analysis', 'সাহিত্য বিশ্লেষণ', Icons.library_books),
        _buildFeatureButton('word_origin', 'শব্দ মূল', Icons.history_edu),
        _buildFeatureButton('tone_adjust', 'টোন পরিবর্তন', Icons.tune),
        _buildFeatureButton('emotional_writing', 'আবেগমय লেখা', Icons.favorite),

        // Content Creation Features
        _buildFeatureButton('news_write', 'সংবাদ লেখা', Icons.article),
        _buildFeatureButton('blog_post', 'ব্লগ পোস্ট', Icons.post_add),
        _buildFeatureButton('research_paper', 'গবেষণাপত্র', Icons.science),
        _buildFeatureButton('business_proposal', 'ব্যবসা প্রস্তাব', Icons.business),
        _buildFeatureButton('resume_cv', 'রেজুমে/সিভি', Icons.description),

        // Educational Tools
        _buildFeatureButton('math_solver', 'গণিত সমাধান', Icons.calculate),
        _buildFeatureButton('chemistry_help', 'রসায়ন সহায়তা', Icons.science),
        _buildFeatureButton('physics_explain', 'পদার্থ ব্যাখ্যা', Icons.speed),
        _buildFeatureButton('biology_concepts', 'জীববিজ্ঞান', Icons.biotech),
        _buildFeatureButton('history_facts', 'ইতিহাস তথ্য', Icons.history),

        // Professional Tools
        _buildFeatureButton('email_write', 'ইমেইল লেখা', Icons.email),
        _buildFeatureButton('meeting_minutes', 'সভার বিবরণী', Icons.meeting_room),
        _buildFeatureButton('presentation', 'প্রেজেন্টেশন', Icons.present_to_all),
        _buildFeatureButton('report_generate', 'প্রতিবেদন', Icons.assessment),
        _buildFeatureButton('legal_doc', 'আইনি দলিল', Icons.gavel),

        // Creative Writing
        _buildFeatureButton('novel_writing', 'উপন্যাস লেখা', Icons.auto_stories),
        _buildFeatureButton('screenplay', 'চিত্রনাট্য', Icons.movie),
        _buildFeatureButton('song_lyrics', 'গানের কথা', Icons.music_note),
        _buildFeatureButton('comic_script', 'কমিক স্ক্রিপ্ট', Icons.bubble_chart),
        _buildFeatureButton('character_dev', 'চরিত্র উন্নয়ন', Icons.person_outline),

        // Technical Writing
        _buildFeatureButton('code_document', 'কোড ডকুমেন্ট', Icons.code),
        _buildFeatureButton('api_docs', 'এপিআই ডক', Icons.api),
        _buildFeatureButton('tech_manual', 'প্রযুক্তি ম্যানুয়াল', Icons.menu_book),
        _buildFeatureButton('bug_report', 'বাগ রিপোর্ট', Icons.bug_report),
        _buildFeatureButton('system_spec', 'সিস্টেম স্পেক', Icons.settings_system_daydream),

        // Marketing Content
        _buildFeatureButton('ad_copy', 'বিজ্ঞাপন কপি', Icons.campaign),
        _buildFeatureButton('product_desc', 'পণ্য বিবরণ', Icons.inventory),
        _buildFeatureButton('seo_content', 'এসইও কন্টেন্ট', Icons.trending_up),
        _buildFeatureButton('social_caption', 'সোশ্যাল ক্যাপশন', Icons.photo_camera),
        _buildFeatureButton('brand_story', 'ব্র্যান্ড স্টোরি', Icons.branding_watermark),

        // Analysis Tools
        _buildFeatureButton('data_analysis', 'ডেটা বিশ্লেষণ', Icons.analytics),
        _buildFeatureButton('market_research', 'বাজার গবেষণা', Icons.show_chart),
        _buildFeatureButton('competitor_analysis', 'প্রতিযোগী বিশ্লেষণ', Icons.compare_arrows),
        _buildFeatureButton('trend_analysis', 'ট্রেন্ড বিশ্লেষণ', Icons.trending_up),
        _buildFeatureButton('user_feedback', 'ব্যবহারকারী প্রতিক্রিয়া', Icons.feedback),

        // Personal Development
        _buildFeatureButton('goal_setting', 'লক্ষ্য নির্ধারণ', Icons.flag),
        _buildFeatureButton('habit_tracker', 'অভ্যাস ট্র্যাকার', Icons.track_changes),
        _buildFeatureButton('daily_journal', 'দৈনিক জার্নাল', Icons.book),
        _buildFeatureButton('meditation_guide', 'ধ্যান গাইড', Icons.self_improvement),
        _buildFeatureButton('workout_plan', 'ব্যায়াম পরিকল্পনা', Icons.fitness_center),

        // Financial Tools
        _buildFeatureButton('budget_plan', 'বাজেট পরিকল্পনা', Icons.account_balance_wallet),
        _buildFeatureButton('expense_track', 'ব্যয় ট্র্যাকিং', Icons.money),
        _buildFeatureButton('investment_advice', 'বিনিয়োগ পরামর্শ', Icons.trending_up),
        _buildFeatureButton('tax_calculate', 'কর গণনা', Icons.receipt_long),
        _buildFeatureButton('financial_report', 'আর্থিক প্রতিবেদন', Icons.assessment),

        _buildFeatureButton('resume_builder', 'রিজিউম তৈরি', Icons.description),
      ],
    );
  }

  Widget _buildFeatureButton(String id, String label, IconData icon) {
    bool isSelected = _selectedFeature == id;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: isSelected ? _scaleAnimation.value : 1.0,
          child: _buildGlassCard(
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _isLoading
                    ? null
                    : () {
                        setState(() => _selectedFeature = id);
                        _animationController.forward().then((_) {
                          _animationController.reverse();
                        });
                        processText(id);
                      },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: isSelected
                            ? AppColors.primary
                            : Colors.white.withOpacity(0.9),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        label,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.white.withOpacity(0.9),
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.primary.withOpacity(0.3)),
        ),
        title: const Text(
          'ব্যবহার নির্দেশিকা',
          style: TextStyle(color: AppColors.textWhite),
        ),
        content: const SingleChildScrollView(
          child: Text(
            '১. টেক্সট লিখুন বা পেস্ট করুন\n'
            '২. প্রয়োজনীয় অপশন বাছাই করুন\n'
            '৩. প্রক্রিয়াকরণের জন্য অপেক্ষা করুন\n'
            '৪. ফলাফল কপি করতে কপি বাটনে ক্লিক করুন\n'
            '৫. ফলাফল সম্পাদনা করতে সরাসরি টেক্সটে ক্লিক করুন',
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              'বুঝেছি',
              style: TextStyle(color: AppColors.primary),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Future<void> processText(String action) async {
    if (_inputController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('টেক্সট লিখুন',
              style: TextStyle(fontSize: 16, color: Colors.white)),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String prompt = PromptHelper.getPrompt(action, _inputController.text);

    try {
      final response = await http.post(
        Uri.parse(
            'https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _outputController.text = data['candidates'][0]['content']['parts'][0]
                  ['text'] ??
              "কোন উত্তর পাওয়া যায়নি";
          _selectedFeature = action; // Update selected feature
        });
      } else {
        setState(() {
          _outputController.text =
              "ত্রুটি: ${response.statusCode}\n${response.body}";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('প্রক্রিয়াকরণে সমস্যা হয়েছে',
                style: TextStyle(fontSize: 16)),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _outputController.text = "ত্রুটি: $e";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('প্রক্রিয়াকরণে সমস্যা হয়েছে',
              style: TextStyle(fontSize: 16)),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
