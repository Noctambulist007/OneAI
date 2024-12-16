import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scannify/features/generate/providers/auth_provider.dart';
import 'package:scannify/utils/constants/colors.dart'; // Your color constants

class GoogleSignInAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return GestureDetector(
      onTap: () async {
        if (authProvider.user == null) {
          await authProvider.signInWithGoogle();
        } else {
          // Show logout dialog
          _showLogoutDialog(context);
        }
      },
      child: CircleAvatar(
        backgroundColor: AppColors.primary, // Replace with your app's primary color
        backgroundImage: authProvider.profilePicUrl != null && authProvider.profilePicUrl!.isNotEmpty
            ? NetworkImage(authProvider.profilePicUrl!)
            : null,
        child: authProvider.profilePicUrl == null || authProvider.profilePicUrl!.isEmpty
            ? Icon(Icons.person, color: Colors.white) // Default icon for no profile pic
            : null,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Logout',
            style: TextStyle(
              color: AppColors.primary, // Custom text color
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16.0,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
                Navigator.pop(context);
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red, // Custom logout button color
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
