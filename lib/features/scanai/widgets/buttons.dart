import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scannify/features/scanai/providers/scan_ai_provider.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    Key? key,
    required this.scanProvider,
  }) : super(key: key);

  final ScanAIProvider scanProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: scanProvider.getImage,
          style: ElevatedButton.styleFrom(
            foregroundColor: Color(0xff0F826B),
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text('Choose Image', style: TextStyle(fontSize: 18)),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed:
          scanProvider.image != null ? scanProvider.generateDescription : null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xff0F826B),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: scanProvider.isLoading
              ? Lottie.asset(
            'assets/animations/loading.json',
            height: 50,
            width: 50,
            fit: BoxFit.contain,
          )
              : Text('Scannify', style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}