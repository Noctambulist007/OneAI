import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_ai/features/text_ai/widget/glass_container.dart';
import 'package:one_ai/features/text_ai/widget/glass_text_field.dart';
import 'package:one_ai/features/text_ai/widget/glass_icon_button.dart';
import 'package:one_ai/features/text_ai/provider/translations.dart';
import 'package:one_ai/utils/constant/colors.dart';

class InputSection extends StatelessWidget {
  final TextEditingController controller;
  final String lang;
  final VoidCallback onTextChanged;

  const InputSection({
    super.key,
    required this.controller,
    required this.lang,
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 12),
        _buildTextField(),
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
                colors: [AppColors.primary, AppColors.secondary],
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
            Translations.get('write', lang),
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          GlassIconButton(
            icon: Icons.content_paste_rounded,
            onTap: () async {
              final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
              if (clipboardData?.text != null) {
                controller.text = clipboardData!.text!;
                onTextChanged();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Stack(
      children: [
        GlassTextField(
          controller: controller,
          hintText: Translations.get('enter_text', lang),
          maxLines: 6,
          onChanged: (_) => onTextChanged(),
        ),
        Positioned(
          right: 8,
          bottom: 8,
          child: Text(
            '${controller.text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length} words',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
} 