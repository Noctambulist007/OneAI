import 'package:flutter/material.dart';
import 'package:one_ai/features/subscription/model/subscription_plan.dart';
import 'package:one_ai/features/subscription/widget/current_plan_button.dart';
import 'package:one_ai/features/subscription/widget/feature_row.dart';
import 'package:one_ai/features/subscription/widget/subscribe_button.dart';
import 'package:one_ai/utils/constant/colors.dart';

class PlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final bool isCurrentPlan;
  final bool isLoading;
  final VoidCallback onSubscribe;

  const PlanCard({
    Key? key,
    required this.plan,
    required this.isCurrentPlan,
    required this.isLoading,
    required this.onSubscribe,
  }) : super(key: key);

  IconData _getPlanIcon(SubscriptionType type) {
    switch (type) {
      case SubscriptionType.free:
        return Icons.rocket_launch;
      case SubscriptionType.basic:
        return Icons.workspace_premium;
      case SubscriptionType.premium:
        return Icons.diamond;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            plan.type == SubscriptionType.premium
                ? AppColors.primary.withOpacity(0.3)
                : Colors.white.withOpacity(0.1),
            plan.type == SubscriptionType.premium
                ? AppColors.secondary.withOpacity(0.3)
                : Colors.white.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: plan.type == SubscriptionType.premium
              ? AppColors.primary.withOpacity(0.5)
              : Colors.white.withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: Stack(
        children: [
          if (plan.type == SubscriptionType.premium)
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.star, color: Colors.white),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getPlanIcon(plan.type),
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      plan.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  plan.description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                FeatureRow(
                  feature: 'Text Generations',
                  value:
                      plan.isUnlimited ? 'Unlimited' : '${plan.textLimit}/day',
                ),
                const SizedBox(height: 8),
                FeatureRow(
                  feature: 'Image Processing',
                  value: '${plan.imageLimit}/day',
                ),
                const SizedBox(height: 24),
                if (plan.price > 0)
                  Text(
                    '\$${plan.price}/month',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 24),
                if (isLoading)
                  CircularProgressIndicator(color: AppColors.primary)
                else if (isCurrentPlan)
                  CurrentPlanButton()
                else
                  SubscribeButton(onPressed: onSubscribe),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
