import 'package:dashscan/features/generate/models/generate_item_model.dart';
import 'package:dashscan/features/generate/models/generate_items.dart';
import 'package:dashscan/features/generate/screens/widgets/custom_popup_menu_button.dart';
import 'package:dashscan/features/generate/screens/widgets/generate_grid_layout.dart';
import 'package:flutter/material.dart';
import 'package:dashscan/utils/constants/colors.dart';
import 'package:dashscan/utils/constants/sizes.dart';

class GenerateScreen extends StatelessWidget {
  const GenerateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<GenerateItemModel> items = GenerateItems().generateItems();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe7ebee),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Generate',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: AppColors.primary,
              ),
            ),
            CustomPopupMenuButton(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: AppSizes.spaceBtwItems,
              ),
              GenerateGridLayout(items: items),
            ],
          ),
        ),
      ),
    );
  }
}