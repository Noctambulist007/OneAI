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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.1),
              AppColors.secondary.withOpacity(0.1),
            ],
          ),
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
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    height: 150,
                    child: _buildFeaturesList(),
                  ),
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
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                height: 20,
                width: 4,
                margin: const EdgeInsets.only(right: 12),
              ),
              Icon(
                Icons.edit_note_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'লিখুন',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
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
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
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
                    maxLines: 6,
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
                      child: Column(
                        children: [
                          _buildGlassIconButton(
                            Icons.clear,
                            () => setState(() {
                              _inputController.clear();
                              _outputController.clear();
                            }),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              '${_inputController.text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length}/10000',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
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
                      AppColors.secondary,
                      AppColors.primary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                height: 20,
                width: 4,
                margin: const EdgeInsets.only(right: 12),
              ),
              Icon(
                Icons.auto_awesome,
                color: Colors.white.withOpacity(0.9),
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'ফলাফল',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 18,
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
                  () => setState(() => _outputController.clear()),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              height: 300,
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
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: _isLoading
                  ? Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black.withOpacity(0.2),
                        ),
                        padding: const EdgeInsets.all(20),
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

  Widget _buildFeaturesList() {
    final List<List<Map<String, dynamic>>> featureRows = [
      // Row 1 - Basic Features
      [
        {'id': 'paraphrase', 'label': 'পুনর্লিখন', 'icon': Icons.autorenew},
        {'id': 'grammar', 'label': 'ব্যাকরণ', 'icon': Icons.spellcheck},
        {'id': 'summarize', 'label': 'সারাংশ', 'icon': Icons.summarize},
        {'id': 'translate_en', 'label': 'ইংরেজি', 'icon': Icons.translate},
        {'id': 'translate_bn', 'label': 'বাংলা', 'icon': Icons.translate},
        {'id': 'edit', 'label': 'সম্পাদনা', 'icon': Icons.edit},
      ],
      // Row 2 - Creative Features
      [
        {'id': 'story', 'label': 'গল্প', 'icon': Icons.book},
        {'id': 'poem', 'label': 'কবিতা', 'icon': Icons.format_quote},
        {'id': 'creative_writing', 'label': 'সৃজনশীল', 'icon': Icons.create},
        {'id': 'headline', 'label': 'শিরোনাম', 'icon': Icons.title},
        {'id': 'letter_write', 'label': 'চিঠি', 'icon': Icons.mail},
        {'id': 'script_dialog', 'label': 'সংলাপ', 'icon': Icons.theater_comedy},
      ],
      // Row 3 - Professional Features
      [
        {'id': 'academic', 'label': 'একাডেমিক', 'icon': Icons.school},
        {
          'id': 'business_proposal',
          'label': 'প্রস্তাব',
          'icon': Icons.business
        },
        {'id': 'resume_cv', 'label': 'রেজুমি', 'icon': Icons.description},
        {'id': 'email_write', 'label': 'ইমেইল', 'icon': Icons.email},
        {'id': 'report_generate', 'label': 'রিপোর্ট', 'icon': Icons.assessment},
        {
          'id': 'presentation',
          'label': 'প্রেজেন্টেশন',
          'icon': Icons.present_to_all
        },
      ],
    ];

    return Container(
      height: 220,
      child: Column(
        children: featureRows.map((row) {
          return Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: row.map((feature) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    child: _buildFeatureChip(
                      feature['id'],
                      feature['label'],
                      feature['icon'],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeatureChip(String id, String label, IconData icon) {
    bool isSelected = _selectedFeature == id;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: isSelected ? _scaleAnimation.value : 1.0,
          child: Material(
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
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: isSelected
                        ? [AppColors.primary, AppColors.secondary]
                        : [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.05),
                          ],
                  ),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.white.withOpacity(0.1),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withOpacity(0.9),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.9),
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
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
            'https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ],
          "safetySettings": [
            {
              "category": "HARM_CATEGORY_HARASSMENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_HATE_SPEECH",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            }
          ],
          "generationConfig": {
            "temperature": 0.7,
            "topK": 40,
            "topP": 0.95,
            "maxOutputTokens": 2048,
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _outputController.text = data['candidates'][0]['content']['parts'][0]
                  ['text'] ??
              "কোন উত্তর পাওয়া যায়নি";
          _selectedFeature = action;
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
