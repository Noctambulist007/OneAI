import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dashscan/features/scan/providers/scan_provider.dart';

class TapToScan extends StatelessWidget {
  const TapToScan({super.key});

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanProvider>(context);
    return Container(
      width: 150,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff0F826B), Color(0xff014348)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        onPressed: () => scanProvider.scanQR(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Ink(
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              'Tap To Scan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
