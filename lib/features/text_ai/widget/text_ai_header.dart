import 'package:flutter/material.dart';
import 'package:one_ai/features/text_ai/widget/glass_container.dart';
import 'package:one_ai/features/text_ai/widget/glass_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/text_ai/provider/language_provider.dart';
import 'package:one_ai/features/text_ai/provider/translations.dart';

class TextAiHeader extends StatelessWidget {
  const TextAiHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>().currentLanguage;
    
    return GlassContainer(
      borderRadius: BorderRadius.zero,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GlassIconButton(
            icon: Icons.arrow_back_rounded,
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(width: 12),
          Text(
            Translations.get('writing_ai', lang),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const Spacer(),
          GlassIconButton(
            icon: Icons.language,
            onTap: () => context.read<LanguageProvider>().toggleLanguage(),
          ),
        ],
      ),
    );
  }
} 