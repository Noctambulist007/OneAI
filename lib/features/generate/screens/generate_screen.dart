import 'package:flutter/material.dart';
import 'package:one_ai/features/generate/screens/widgets/google_sign_in_avatar.dart';
import 'package:one_ai/features/generate/models/generate_item_model.dart';
import 'package:one_ai/features/generate/models/generate_items.dart';
import 'package:one_ai/features/generate/screens/widgets/generate_grid_layout.dart';
import 'package:one_ai/features/generate/screens/widgets/login_screen.dart';
import 'package:one_ai/features/generate/screens/widgets/scan_ai_generate_card.dart';
import 'package:one_ai/features/scanai/screens/scan_ai_screen.dart';
import 'package:one_ai/utils/constants/colors.dart';
import 'package:one_ai/utils/constants/sizes.dart';

class GenerateScreen extends StatelessWidget {
  const GenerateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<GenerateItemModel> items = GenerateItems().generateItems();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary, // Primary color (027373)
            AppColors.secondary, // Secondary color (2F867D)
            Color(0xFF1D5C5C), // Darker shade of primary for depth
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Generate QR',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                  color: AppColors.white,
                ),
              ),
              GoogleSignInAvatar(),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: AppColors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary, // Primary color (027373)
                    AppColors.secondary, // Secondary color (2F867D)
                    Color(0xFF1D5C5C), // Darker shade of primary for depth
                  ],

                ),
              ),
              child: GenerateGridLayout(items: items)),
        ),
      ),
    );
  }
}
