import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:one_ai/features/generate/models/generate_item_model.dart';
import 'package:one_ai/features/generate/providers/generate_qr.dart';
import 'generate_card.dart';
import 'package:one_ai/utils/constants/colors.dart';

class GenerateGridLayout extends StatelessWidget {
  const GenerateGridLayout({
    super.key,
    required this.items,
  });

  final List<GenerateItemModel> items;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
          childAspectRatio: 1.2,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              showModalBottomSheet(
                scrollControlDisabledMaxHeightRatio: 1.0,
                context: context,
                builder: (BuildContext context) {
                  return GenerateQR(itemText: items[index].text);
                },
              );
            },
            borderRadius: BorderRadius.circular(10.0),
            splashColor: AppColors.primary,
            child: AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: 3,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: GenerateCard(
                    icon: items[index].icon,
                    text: items[index].text,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
