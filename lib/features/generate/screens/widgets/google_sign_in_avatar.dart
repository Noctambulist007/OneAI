import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/generate/providers/auth_provider.dart';
import 'package:one_ai/features/generate/screens/widgets/login_screen.dart';
import 'package:one_ai/utils/constants/colors.dart';

class GoogleSignInAvatar extends StatelessWidget {
  const GoogleSignInAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (authProvider.user == null) {
          return _buildLoginButton(context);
        }

        return PopupMenuButton(
          offset: const Offset(0, 50),
          child: _buildAvatar(authProvider.profilePicUrl),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  await authProvider.signOut();
                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAvatar(String? profileUrl) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 2),
      ),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.primary.withOpacity(0.1),
        backgroundImage: profileUrl != null ? NetworkImage(profileUrl) : null,
        child: profileUrl == null
            ? const Icon(Icons.person, color: AppColors.primary)
            : null,
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
        child: const Icon(Icons.person, color: AppColors.white),
      ),
    );
  }
}