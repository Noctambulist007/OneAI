import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:one_ai/utils/constants/colors.dart';

class AITextProcessor extends StatefulWidget {
  @override
  _AITextProcessorState createState() => _AITextProcessorState();
}

class _AITextProcessorState extends State<AITextProcessor> with SingleTickerProviderStateMixin {
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
      duration: Duration(milliseconds: 300),
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A1A),
              Color(0xFF0A2333),
              Color(0xFF1A1A1A),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated background circles
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [AppColors.primary.withOpacity(0.2), Colors.transparent],
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
                    colors: [AppColors.secondary.withOpacity(0.15), Colors.transparent],
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
                      padding: EdgeInsets.all(16),
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildGlassCard(_buildInputSection()),
                          SizedBox(height: 20),
                          _buildGlassCard(_buildOutputSection()),
                          SizedBox(height: 20),
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
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary.withOpacity(0.5), AppColors.secondary.withOpacity(0.5)],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                height: 16,
                width: 3,
                margin: EdgeInsets.only(right: 8),
              ),
              Text(
                'ইনপুট টেক্সট',
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
        SizedBox(height: 12),
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
                      contentPadding: EdgeInsets.all(20),
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
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.secondary.withOpacity(0.5), AppColors.primary.withOpacity(0.5)],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                height: 16,
                width: 3,
                margin: EdgeInsets.only(right: 8),
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
              Spacer(),
              if (_outputController.text.isNotEmpty) ...[
                _buildGlassIconButton(
                  Icons.copy,
                      () {
                    Clipboard.setData(ClipboardData(text: _outputController.text));
                    _showCustomSnackBar(context, 'কপি করা হয়েছে');
                  },
                ),
                SizedBox(width: 8),
                _buildGlassIconButton(
                  Icons.clear,
                      () => _outputController.clear(),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 12),
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
                  contentPadding: EdgeInsets.all(20),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

// Helper method for custom snackbar
  void _showCustomSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text(
                message,
                style: TextStyle(
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
        margin: EdgeInsets.all(16),
        duration: Duration(seconds: 2),
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
          padding: EdgeInsets.all(16),
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
              SizedBox(width: 12),
              Text(
                'লিখন AI',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'HindSiliguri',
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              Spacer(),
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
        padding: EdgeInsets.all(8),
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
      physics: NeverScrollableScrollPhysics(),
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
                onTap: _isLoading ? null : () {
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
                      SizedBox(width: 8),
                      Text(
                        label,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.white.withOpacity(0.9),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
        title: Text(
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
            child: Text(
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
        SnackBar(
          content: Text('টেক্সট লিখুন', style: TextStyle(fontSize: 16, color: Colors.white)),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String prompt = getPromptForAction(action, _inputController.text);

    try {
      final response = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [{"parts": [{"text": prompt}]}]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _outputController.text = data['candidates'][0]['content']['parts'][0]['text'] ?? "কোন উত্তর পাওয়া যায়নি";
          _selectedFeature = action; // Update selected feature
        });
      } else {
        setState(() {
          _outputController.text = "ত্রুটি: ${response.statusCode}\n${response.body}";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('প্রক্রিয়াকরণে সমস্যা হয়েছে', style: TextStyle(fontSize: 16)),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _outputController.text = "ত্রুটি: $e";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('প্রক্রিয়াকরণে সমস্যা হয়েছে', style: TextStyle(fontSize: 16)),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String getPromptForAction(String action, String text) {
    switch (action) {
      case 'paraphrase':
        return "পুনর্লিখন করুন এবং বাংলায় উত্তর দিন:\n$text";
      case 'grammar':
        return "বাক্যগঠন ও ব্যাকরণ পরীক্ষা করে বাংলায় উত্তর দিন:\n$text";
      case 'ai_detect':
        return "এই টেক্সটটি AI দ্বারা লেখা কিনা বিশ্লেষণ করে বাংলায় জানান:\n$text";
      case 'plagiarism':
        return "এই টেক্সটে অনুলিপি বা চুরির সম্ভাবনা আছে কিনা বিশ্লেষণ করে বাংলায় জানান:\n$text";
      case 'summarize':
        return "সংক্ষিপ্ত সারাংশ বাংলায় লিখুন:\n$text";
      case 'translate_en':
        return "ইংরেজিতে অনুবাদ করুন:\n$text";
      case 'translate_bn':
        return "বাংলায় অনুবাদ করুন:\n$text";
      case 'edit':
        return "সম্পাদনা করে উন্নত করুন এবং বাংলায় উত্তর দিন:\n$text";
      case 'story':
        return "এই বিষয়ে একটি গল্প বাংলায় লিখুন:\n$text";
      case 'poem':
        return "এই বিষয়ে একটি কবিতা বাংলায় লিখুন:\n$text";
      case 'headline':
        return "এই টেক্সট থেকে আকর্ষণীয় শিরোনাম বাংলায় তৈরি করুন:\n$text";
      case 'academic':
        return "একাডেমিক স্টাইলে পুনর্লিখন করে বাংলায় উত্তর দিন:\n$text";
      default:
        return text;
    }
  }
}