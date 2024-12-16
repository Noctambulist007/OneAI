import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scannify/features/generate/screens/widgets/generate_card.dart';
import 'package:scannify/features/generate/screens/widgets/google_sign_in_avatar.dart';
import 'package:scannify/features/generate/models/generate_item_model.dart';
import 'package:scannify/features/generate/models/generate_items.dart';
import 'package:scannify/features/generate/screens/widgets/generate_grid_layout.dart';
import 'package:scannify/features/generate/providers/auth_provider.dart';
import 'package:scannify/features/generate/screens/widgets/scan_ai_generate_card.dart';
import 'package:scannify/features/scanai/screens/scan_ai_screen.dart';
import 'package:scannify/utils/constants/colors.dart';
import 'package:scannify/utils/constants/sizes.dart';

class GenerateScreen extends StatelessWidget {
  const GenerateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<GenerateItemModel> items = GenerateItems().generateItems();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe7ebee),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Generate QR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: AppColors.primary,
              ),
            ),
            GoogleSignInAvatar(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: AppSizes.spaceBtwItems),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScanAiScreen()),
                  );
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: ScanAiGenerateCard(
                    text: 'Generate QR Code',
                  ),
                ),
              ),
              GenerateGridLayout(items: items),
            ],
          ),
        ),
      ),
    );
  }
}
