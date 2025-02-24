import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:one_ai/features/auth/provider/auth_provider.dart';
import 'package:one_ai/features/text_ai/provider/translations.dart';
import 'package:one_ai/features/text_ai/provider/prompt_helper.dart';
import 'package:one_ai/utils/constant/colors.dart';
import 'package:one_ai/features/auth/screen/login_screen.dart';

class TextProcessor {
  static Future<String?> process(
    BuildContext context,
    String action,
    String inputText,
    String lang,
    AuthProvider authProvider,
  ) async {
    if (authProvider.user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to use this feature'),
          backgroundColor: AppColors.error,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      return null;
    }

    if (!await authProvider.canUseTextGeneration(context)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Daily limit reached. Try again tomorrow.'),
          backgroundColor: AppColors.error,
        ),
      );
      return null;
    }

    if (inputText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            Translations.get('enter_text_error', lang),
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return null;
    }

    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    final prompt = PromptHelper.getPrompt(action, inputText, lang);

    try {
      final response = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent?key=$apiKey',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [{"parts": [{"text": prompt}]}],
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
        await authProvider.incrementTextGeneration();
        return data['candidates'][0]['content']['parts'][0]['text'] ??
            Translations.get('no_result', lang);
      } else {
        throw Exception('${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      throw Exception('Processing failed: $e');
    }
  }
} 