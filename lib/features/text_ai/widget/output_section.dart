import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:one_ai/features/text_ai/widget/glass_container.dart';
import 'package:one_ai/features/text_ai/widget/glass_text_field.dart';
import 'package:one_ai/features/text_ai/widget/glass_icon_button.dart';
import 'package:one_ai/features/text_ai/provider/translations.dart';
import 'package:one_ai/utils/constant/colors.dart';

class OutputSection extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final String lang;
  final Function(String) onCopy;
  final VoidCallback onClear;

  const OutputSection({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.lang,
    required this.onCopy,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 12),
        _buildContent(),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.secondary, AppColors.primary],
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
            Translations.get('result', lang),
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          if (controller.text.isNotEmpty) ...[
            GlassIconButton(
              icon: Icons.copy,
              onTap: () => onCopy(controller.text),
            ),
            const SizedBox(width: 8),
            GlassIconButton(
              icon: Icons.clear,
              onTap: onClear,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContent() {
    return GlassContainer(
      child: Container(
        height: 300,
        child: isLoading
            ? _buildLoadingIndicator()
            : GlassTextField(
                controller: controller,
                hintText: Translations.get('result_here', lang),
                height: 300,
                readOnly: true,
              ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
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
    );
  }
} 