import 'package:flutter/material.dart';
import 'package:dashscan/utils/constants/colors.dart';

class EmptyHistory extends StatelessWidget {
  const EmptyHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No history items available.',
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontFamily: 'Poppins',
          fontSize: 18.0,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
