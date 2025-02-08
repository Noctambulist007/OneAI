import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/generate/providers/qr_provider.dart';
import 'package:one_ai/features/generate/screens/widgets/generate_body_content.dart';
import 'package:one_ai/utils/constants/colors.dart';

class GenerateQRCode extends StatefulWidget {
  final String itemText;

  const GenerateQRCode({super.key, required this.itemText});

  @override
  State<GenerateQRCode> createState() =>
      _GenerateQRCodeState(itemText: itemText);
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  final String itemText;

  _GenerateQRCodeState({required this.itemText});

  @override
  Widget build(BuildContext context) {
    QRState qrState = Provider.of<QRState>(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
            Color(0xFF1D5C5C),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            itemText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
              color: AppColors.white,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: BodyContent(itemText: itemText, qrState: qrState),
      ),
    );
  }
}
