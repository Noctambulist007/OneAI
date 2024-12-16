import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scannify/features/generate/screens/generate_qr_screen.dart';
import 'qr_provider.dart';

class GenerateQR extends StatelessWidget {
  const GenerateQR({super.key, required this.itemText});

  final String itemText;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QRState(),
      child: GenerateQRCode(itemText: itemText),
    );
  }
}
