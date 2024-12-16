import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:scannify/features/scanai/providers/scan_ai_provider.dart';
import 'package:scannify/features/scanai/widgets/buttons.dart';
import 'package:scannify/features/scanai/widgets/description.dart';
import 'package:scannify/features/scanai/widgets/image_display.dart';
import 'package:scannify/utils/constants/colors.dart';

class ScanAiScreen extends StatelessWidget {
  const ScanAiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scanProvider = Provider.of<ScanAIProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0F826B), Color(0xff014348)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  ImageDisplay(scanProvider: scanProvider),
                  SizedBox(height: 30),
                  Buttons(scanProvider: scanProvider),
                  SizedBox(height: 30),
                  if (scanProvider.description.isNotEmpty)
                    Description(description: scanProvider.description),
                ],
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'ScanAI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
