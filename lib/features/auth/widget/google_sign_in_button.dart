import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_ai/utils/constant/colors.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const GoogleSignInButton({
    Key? key,
    required this.onPressed,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: SvgPicture.asset(
          'assets/logos/icon_google.svg',
          width: 24,
          height: 24,
        ),
        label: const Text(
          'Continue With Google',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(color: AppColors.white),
        ),
      ),
    );
  }
}
