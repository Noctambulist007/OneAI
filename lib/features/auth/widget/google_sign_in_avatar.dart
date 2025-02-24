import 'package:flutter/material.dart';
import 'package:one_ai/features/auth/provider/auth_provider.dart';
import 'package:one_ai/features/auth/screen/login_screen.dart';
import 'package:one_ai/features/subscription/model/subscription_plan.dart';
import 'package:one_ai/utils/constant/colors.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/subscription/provider/subscription_provider.dart';
import 'package:one_ai/features/subscription/screen/subscription_screen.dart';

class GoogleSignInAvatar extends StatelessWidget {
  const GoogleSignInAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, SubscriptionProvider>(
      builder: (context, authProvider, subscriptionProvider, _) {
        if (authProvider.user == null) {
          return _buildLoginButton(context);
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _showProfileMenu(context, authProvider, subscriptionProvider),
            child: CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.2),
              child: ClipOval(
                child: authProvider.profilePicUrl != null
                    ? Image.network(
                        authProvider.profilePicUrl!,
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildFallbackAvatar(authProvider);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return _buildLoadingAvatar();
                        },
                      )
                    : _buildFallbackAvatar(authProvider),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFallbackAvatar(AuthProvider authProvider) {
    final name = authProvider.user?.displayName ?? '';
    final initials = name.isNotEmpty 
        ? name.split(' ').map((e) => e[0]).take(2).join().toUpperCase()
        : '?';
    
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingAvatar() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.2),
      ),
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.account_circle_outlined,
        color: Colors.white.withOpacity(0.9),
      ),
      onPressed: () => Navigator.push (
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      ),
    );
  }

  void _showProfileMenu(
    BuildContext context, 
    AuthProvider authProvider,
    SubscriptionProvider subscriptionProvider,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundPrimary,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline, color: Colors.white),
              title: Text(
                authProvider.user?.displayName ?? 'User',
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                authProvider.user?.email ?? '',
                style: TextStyle(color: Colors.white.withOpacity(0.7)),
              ),
            ),
            const Divider(color: Colors.white24),
            // Subscription Plan Section
            ListTile(
              leading: Icon(
                _getPlanIcon(subscriptionProvider.currentPlan.type),
                color: AppColors.primary,
              ),
              title: Text(
                subscriptionProvider.currentPlan.name,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Current Plan',
                style: TextStyle(color: Colors.white.withOpacity(0.7)),
              ),
              trailing: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubscriptionScreen(),
                    ),
                  );
                },
                child: Text(
                  'Change',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Usage Section
            if (authProvider.userUsage != null) ...[
              const Divider(color: Colors.white24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    _buildUsageRow(
                      'Text Generations',
                      authProvider.userUsage!.textGenerationCount,
                      subscriptionProvider.currentPlan.textLimit,
                    ),
                    const SizedBox(height: 8),
                    _buildUsageRow(
                      'Image Processing',
                      authProvider.userUsage!.imageGenerationCount,
                      subscriptionProvider.currentPlan.imageLimit,
                    ),
                  ],
                ),
              ),
            ],
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                authProvider.signOut();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageRow(String feature, int used, int total) {
    final progress = total == -1 ? 1.0 : used / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              feature,
              style: TextStyle(color: Colors.white.withOpacity(0.9)),
            ),
            Text(
              total == -1 ? 'Unlimited' : '$used/$total',
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(
              progress >= 1 ? Colors.red : AppColors.primary,
            ),
            minHeight: 4,
          ),
        ),
      ],
    );
  }

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
}
