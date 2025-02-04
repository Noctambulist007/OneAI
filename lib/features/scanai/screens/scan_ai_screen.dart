import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/utils/constants/colors.dart';
import 'package:one_ai/features/scanai/providers/scan_ai_provider.dart';

class ScanAiScreen extends StatelessWidget {
  const ScanAiScreen({Key? key}) : super(key: key);

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    _showCustomSnackBar(context, 'Copied to clipboard');
  }

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
        backgroundColor: Color(0xff0F826B).withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(16),
        duration: Duration(seconds: 2),
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
                  padding: EdgeInsets.all(24),
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
                      SizedBox(height: 16),
                      Text(
                        'Coming Soon!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'We are working hard to bring you amazing AI-powered image generation capabilities. Stay tuned!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(height: 24),
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
                    colors: [
                      Color(0xff0F826B).withOpacity(0.2),
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
                          _buildImageSection(scanProvider),
                          SizedBox(height: 24),
                          _buildActionButtons(context, scanProvider),
                          SizedBox(height: 24),
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
      leading:   _buildGlassIconButton(
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

  Widget _buildImageSection(ScanAIProvider scanProvider) {
    return ClipRRect(
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
    );
  }

  Widget _buildActionButtons(
      BuildContext context, ScanAIProvider scanProvider) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildGlassActionButton(
                'Describe Image',
                Icons.image_search,
                scanProvider.image != null
                    ? scanProvider.generateDescription
                    : null,
                isPrimary: true,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildGlassActionButton(
                'Extract Text',
                Icons.text_fields,
                scanProvider.image != null ? scanProvider.extractText : null,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildGlassActionButton(
                'Scan Handwriting',
                Icons.draw,
                scanProvider.image != null
                    ? scanProvider.extractHandwriting
                    : null,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildGlassActionButton(
                'Generate Image',
                Icons.auto_awesome,
                () => _showComingSoonDialog(context),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildGlassActionButton(
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
      return SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: double.infinity,
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
        SizedBox(height: 8),
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
      margin: EdgeInsets.all(8),
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
      String title, IconData icon, VoidCallback? onPressed,
      {bool isPrimary = false, bool fullWidth = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                isPrimary ? Color(0xff0F826B) : Colors.white.withOpacity(0.1),
                isPrimary ? Color(0xff0F826B) : Colors.white.withOpacity(0.05),
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
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                width: fullWidth ? double.infinity : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon,
                        color: isPrimary
                            ? Colors.white
                            : Colors.white.withOpacity(0.9)),
                    SizedBox(width: 8),
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
    );
  }

  _buildGlassButton(String title, VoidCallback onPressed) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
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
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
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
