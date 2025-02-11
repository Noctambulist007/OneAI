import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:one_ai/utils/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/scan_ai/providers/scan_ai_provider.dart';

class ScanAiScreen extends StatelessWidget {
  const ScanAiScreen({super.key});

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    _showCustomSnackBar(context, 'Copied to clipboard');
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
        backgroundColor: const Color(0xff0F826B).withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/animations/rocket.json',
                        height: 150,
                        width: 150,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Coming Soon!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'We are working hard to bring you amazing AI-powered image generation capabilities. Stay tuned!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildGlassButton(
                        'Got it!',
                        () => Navigator.pop(context),
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

  @override
  Widget build(BuildContext context) {
    var scanProvider = Provider.of<ScanAIProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
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
                    colors: [
                      const Color(0xff0F826B).withOpacity(0.2),
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
                      Color(0xff014348).withOpacity(0.15),
                      Colors.transparent
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: CustomScrollView(
                slivers: [
                  _buildGlassAppBar(context, scanProvider),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildFeatureGrid(context, scanProvider),
                          const SizedBox(height: 24),
                          _buildImageSection(context, scanProvider),
                          const SizedBox(height: 24),
                          _buildResultsSection(context, scanProvider),
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

  Widget _buildGlassAppBar(BuildContext context, ScanAIProvider scanProvider) {
    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: ClipRect(
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
            ),
          ),
        ),
      ),
      title: const Text(
        'নকশা AI',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'HindSiliguri',
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      leading: _buildGlassIconButton(
        Icons.arrow_back_rounded,
        () => Navigator.pop(context),
      ),
      actions: [
        if (scanProvider.hasResults)
          _buildGlassIconButton(
            Icons.refresh,
            () => scanProvider.clearResults(),
          ),
      ],
    );
  }

  Widget _buildFeatureGrid(BuildContext context, ScanAIProvider scanProvider) {
    final List<List<Map<String, dynamic>>> featureRows = [
      // Row 1 - Basic Features
      [
        {
          'id': 'describe',
          'label': 'Describe Image',
          'icon': Icons.image_search,
          'onPressed': scanProvider.image != null
              ? scanProvider.generateDescription
              : null,
        },
        {
          'id': 'generate',
          'label': 'Generate Image',
          'icon': Icons.auto_awesome,
          'onPressed': () => _showComingSoonDialog(context),
          'isComingSoon': true,
        },
        {
          'id': 'extract_text',
          'label': 'Extract Text',
          'icon': Icons.text_fields,
          'onPressed':
              scanProvider.image != null ? scanProvider.extractText : null,
        },
        {
          'id': 'handwriting',
          'label': 'Scan Handwriting',
          'icon': Icons.draw,
          'onPressed': scanProvider.image != null
              ? scanProvider.extractHandwriting
              : null,
        },
      ],
      // Row 2 - Analysis Features
      [
        {
          'id': 'document',
          'label': 'Analyze Document',
          'icon': Icons.description,
          'onPressed':
              scanProvider.image != null ? scanProvider.analyzeDocument : null,
        },
        {
          'id': 'nutrition',
          'label': 'Nutrition Info',
          'icon': Icons.lunch_dining,
          'onPressed': scanProvider.image != null
              ? scanProvider.extractNutritionInfo
              : null,
        },
        {
          'id': 'math',
          'label': 'Solve Math',
          'icon': Icons.functions,
          'onPressed':
              scanProvider.image != null ? scanProvider.solveMathProblem : null,
        },
      ],
      // Row 3 - Advanced Features
      [
        {
          'id': 'code',
          'label': 'Analyze Code',
          'icon': Icons.code,
          'onPressed':
              scanProvider.image != null ? scanProvider.analyzeCode : null,
        },
        {
          'id': 'product',
          'label': 'Product Review',
          'icon': Icons.star,
          'onPressed':
              scanProvider.image != null ? scanProvider.reviewProduct : null,
        },
        {
          'id': 'property',
          'label': 'Property Analysis',
          'icon': Icons.home,
          'onPressed':
              scanProvider.image != null ? scanProvider.analyzeProperty : null,
        },
      ],
      // Row 4 - Additional Features
      [
        {
          'id': 'tech',
          'label': 'Tech Specs',
          'icon': Icons.computer,
          'onPressed':
              scanProvider.image != null ? scanProvider.extractTechSpecs : null,
        },
        {
          'id': 'chart',
          'label': 'Chart Analysis',
          'icon': Icons.bar_chart,
          'onPressed':
              scanProvider.image != null ? scanProvider.analyzeChart : null,
        },
      ],
      // Row 5 - Translation Features
      [
        {
          'id': 'currency',
          'label': 'Convert Currency',
          'icon': Icons.monetization_on,
          'onPressed':
              scanProvider.image != null ? scanProvider.convertCurrency : null,
        },
        {
          'id': 'translate',
          'label': 'Translate Text',
          'icon': Icons.translate,
          'onPressed':
              scanProvider.image != null ? scanProvider.translateText : null,
        },
      ],
    ];

    return Container(
      height: 250,
      child: Column(
        children: featureRows.map((row) {
          return Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: row.map((feature) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _buildFeatureChip(
                      context,
                      feature['id'] as String,
                      feature['label'] as String,
                      feature['icon'] as IconData,
                      feature['onPressed'] as Function?,
                      isComingSoon: feature['isComingSoon'] as bool? ?? false,
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

  Widget _buildFeatureChip(BuildContext context, String id, String label,
      IconData icon, Function? onPressed,
      {bool isComingSoon = false}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed == null
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Please select an image first',
                        style: TextStyle(color: Colors.white)),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            : () => onPressed(),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: Colors.white.withOpacity(0.9),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              if (isComingSoon)
                Positioned(
                  top: -12,
                  right: -8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Coming Soon',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, ScanAIProvider scanProvider) {
    return Column(
      children: [
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: scanProvider.image != null
                    ? Image.file(
                        File(scanProvider.image!.path),
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Lottie.asset(
                          'assets/animations/avatar.json',
                          height: 300,
                          width: 300,
                        ),
                      ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16), // Add spacing between image and button
        _buildGlassActionButton(
          context,
          'Choose Image',
          Icons.add_photo_alternate,
          scanProvider.getImage,
          fullWidth: true,
        ),
      ],
    );
  }

  Widget _buildResultsSection(
      BuildContext context, ScanAIProvider scanProvider) {
    if (scanProvider.isLoading) {
      return Center(
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black.withOpacity(0.2),
          ),
          child: Lottie.asset(
            'assets/animations/loading.json',
            height: 100,
            width: 100,
          ),
        ),
      );
    }

    if (!scanProvider.hasResults) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: double.infinity,
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
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (scanProvider.description.isNotEmpty) ...[
                _buildResultSection(
                  context,
                  'Image Description',
                  scanProvider.description,
                  () => _copyToClipboard(context, scanProvider.description),
                ),
              ],
              if (scanProvider.extractedText.isNotEmpty) ...[
                if (scanProvider.description.isNotEmpty)
                  Divider(
                    height: 32,
                    color: Colors.white.withOpacity(0.2),
                  ),
                _buildResultSection(
                  context,
                  'Extracted Text',
                  scanProvider.extractedText,
                  () => _copyToClipboard(context, scanProvider.extractedText),
                ),
              ],
              if (scanProvider.handwritingText.isNotEmpty) ...[
                if (scanProvider.description.isNotEmpty ||
                    scanProvider.extractedText.isNotEmpty)
                  Divider(
                    height: 32,
                    color: Colors.white.withOpacity(0.2),
                  ),
                _buildResultSection(
                  context,
                  'Handwriting Recognition',
                  scanProvider.handwritingText,
                  () => _copyToClipboard(context, scanProvider.handwritingText),
                ),
              ],
              if (scanProvider.documentAnalysis.isNotEmpty) ...[
                _buildResultSection(
                  context,
                  'Document Analysis',
                  scanProvider.documentAnalysis,
                  () =>
                      _copyToClipboard(context, scanProvider.documentAnalysis),
                ),
              ],
              if (scanProvider.nutritionInfo.isNotEmpty) ...[
                _buildResultSection(
                  context,
                  'Nutrition Information',
                  scanProvider.nutritionInfo,
                  () => _copyToClipboard(context, scanProvider.nutritionInfo),
                ),
              ],
              if (scanProvider.mathSolution.isNotEmpty) ...[
                _buildResultSection(
                  context,
                  'Math Solution',
                  scanProvider.mathSolution,
                  () => _copyToClipboard(context, scanProvider.mathSolution),
                ),
              ],
              if (scanProvider.productReview.isNotEmpty) ...[
                _buildResultSection(
                  context,
                  'Product Review',
                  scanProvider.productReview,
                  () => _copyToClipboard(context, scanProvider.productReview),
                ),
              ],
              if (scanProvider.propertyAnalysis.isNotEmpty) ...[
                _buildResultSection(
                  context,
                  'Property Analysis',
                  scanProvider.propertyAnalysis,
                  () =>
                      _copyToClipboard(context, scanProvider.propertyAnalysis),
                ),
              ],
              if (scanProvider.techSpecs.isNotEmpty) ...[
                _buildResultSection(
                  context,
                  'Tech Specs',
                  scanProvider.techSpecs,
                  () => _copyToClipboard(context, scanProvider.techSpecs),
                ),
              ],
              if (scanProvider.chartAnalysis.isNotEmpty) ...[
                _buildResultSection(
                  context,
                  'Chart Analysis',
                  scanProvider.chartAnalysis,
                  () => _copyToClipboard(context, scanProvider.chartAnalysis),
                ),
              ],
              if (scanProvider.currencyInfo.isNotEmpty) ...[
                _buildResultSection(
                  context,
                  'Currency Info',
                  scanProvider.currencyInfo,
                  () => _copyToClipboard(context, scanProvider.currencyInfo),
                ),
              ],
              if (scanProvider.translation.isNotEmpty) ...[
                _buildResultSection(
                  context,
                  'Translation',
                  scanProvider.translation,
                  () => _copyToClipboard(context, scanProvider.translation),
                ),
              ],
              if (scanProvider.codeAnalysis.isNotEmpty) ...[
                _buildResultSection(
                  context,
                  'Code Analysis',
                  scanProvider.codeAnalysis,
                  () => _copyToClipboard(context, scanProvider.codeAnalysis),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultSection(
    BuildContext context,
    String title,
    String content,
    VoidCallback onCopy,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            _buildGlassIconButton(Icons.copy, onCopy),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildGlassIconButton(IconData icon, VoidCallback? onPressed) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.15),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: IconButton(
              icon: Icon(icon, color: Colors.white.withOpacity(0.9), size: 20),
              onPressed: onPressed,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassActionButton(
      BuildContext context,
      // Added BuildContext parameter
      String title,
      IconData icon,
      VoidCallback? onPressed,
      {bool isPrimary = false,
      bool fullWidth = false,
      bool isComingSoon = false}) {
    return Stack(
      children: [
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
                    isPrimary
                        ? const Color(0xff0F826B)
                        : Colors.white.withOpacity(0.1),
                    isPrimary
                        ? const Color(0xff0F826B)
                        : Colors.white.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressed ??
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color(0xff0F826B),
                            content: Text('Please select an image first',
                                style: TextStyle(color: Colors.white)),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    width: fullWidth ? double.infinity : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon,
                            color: isPrimary
                                ? Colors.white
                                : Colors.white.withOpacity(0.9)),
                        const SizedBox(width: 8),
                        Text(
                          title,
                          style: TextStyle(
                            color: isPrimary
                                ? Colors.white
                                : Colors.white.withOpacity(0.9),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isComingSoon)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange[300],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: const Text(
                'Coming Soon',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  _buildGlassButton(String title, VoidCallback onPressed) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff0F826B),
                Color(0xff0F826B),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
