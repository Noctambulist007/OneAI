import 'package:flutter/material.dart';

class CurrentPlanButton extends StatelessWidget {
  const CurrentPlanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: null,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.white.withOpacity(0.3)),
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text(
        'Current Plan',
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 18,
        ),
      ),
    );
  }
}
