import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:one_ai/features/home/model/feature_card_model.dart';

class FeaturedCard extends StatelessWidget {
  final FeatureCardModel model;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const FeaturedCard({
    super.key,
    required this.model,
    this.borderRadius,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(16),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap ?? model.onTap,
              borderRadius: borderRadius ?? BorderRadius.circular(16),
              child: ClipRRect(
                borderRadius: borderRadius ?? BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 200,
                    padding: padding ?? const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          model.gradientColors.first.withOpacity(0.2),
                          model.gradientColors.last.withOpacity(0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: borderRadius ?? BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: model.gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.rectangle
                          ),
                          child: Icon(
                            model.icon,
                            size: 32,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          model.title,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          model.description,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
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
      ],
    );
  }
}
