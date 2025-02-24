import 'package:flutter/material.dart';
import 'package:one_ai/features/auth/widget/google_sign_in_avatar.dart';
import 'package:one_ai/utils/constant/colors.dart';

class CustomGradientAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final double height;

  const CustomGradientAppBar({
    Key? key,
    this.leading,
    this.actions,
    this.height = kToolbarHeight,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.backgroundPrimary.withOpacity(0.2),
            AppColors.backgroundPrimary.withOpacity(0.8),
          ],
        ),
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: leading,
        actions: actions ??
            [
              GoogleSignInAvatar(),
            ],
      ),
    );
  }
}
