import 'package:flutter/material.dart';
import 'package:one_ai/features/subscription/model/subscription_plan.dart';
import 'package:one_ai/features/subscription/provider/subscription_provider.dart';
import 'package:one_ai/features/subscription/widget/plan_card.dart';
import 'package:one_ai/features/subscription/widget/subscription_background.dart';
import 'package:one_ai/features/subscription/widget/subscription_header.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:one_ai/utils/constant/colors.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SubscriptionBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SubscriptionHeader(),
              Expanded(
                child: Consumer<SubscriptionProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return Center(
                        child: Lottie.asset(
                          'assets/animations/loading.json',
                          width: 100,
                          height: 100,
                        ),
                      );
                    }

                    return ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        PlanCard(
                          plan: SubscriptionPlan.free,
                          isCurrentPlan: provider.currentPlan.type ==
                              SubscriptionType.free,
                          isLoading: provider.isLoading,
                          onSubscribe: () =>
                              _handleSubscribe(context, SubscriptionPlan.free),
                        ),
                        const SizedBox(height: 16),
                        PlanCard(
                          plan: SubscriptionPlan.basic,
                          isCurrentPlan: provider.currentPlan.type ==
                              SubscriptionType.basic,
                          isLoading: provider.isLoading,
                          onSubscribe: () =>
                              _handleSubscribe(context, SubscriptionPlan.basic),
                        ),
                        const SizedBox(height: 16),
                        PlanCard(
                          plan: SubscriptionPlan.premium,
                          isCurrentPlan: provider.currentPlan.type ==
                              SubscriptionType.premium,
                          isLoading: provider.isLoading,
                          onSubscribe: () => _handleSubscribe(
                              context, SubscriptionPlan.premium),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubscribe(BuildContext context, SubscriptionPlan plan) async {
    final provider = context.read<SubscriptionProvider>();

    try {
      if (provider.products == null || provider.products!.isEmpty) {
        throw Exception('Products not available');
      }

      final product = provider.products!.firstWhere(
        (p) => p.id == plan.id,
        orElse: () => throw Exception('Product not found: ${plan.id}'),
      );

      await provider.buySubscription(product);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceAll('Exception: ', ''),
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }
}
