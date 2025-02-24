import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/auth/provider/auth_provider.dart';
import 'package:one_ai/features/shared/widget/usage_info_card.dart';

class UsageInfoSection extends StatelessWidget {
  const UsageInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          if (authProvider.userUsage == null) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: UsageInfoCard(
              used: authProvider.userUsage!.textGenerationCount,
              total: 10,
              feature: 'Text Generation',
            ),
          );
        },
      ),
    );
  }
} 