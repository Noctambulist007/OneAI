import 'package:flutter/material.dart';
import 'package:scannify/features/generate/providers/qr_provider.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.qrState,
    required this.onGenerate,
    required this.itemText,
  });

  final QRState qrState;
  final Function(String) onGenerate;
  final String itemText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff0F826B), Color(0xff014348)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: double.infinity,
        child: RawMaterialButton(
          onPressed: () async {
            try {
              String inputText = qrState.textController.text.trim();

              if (inputText.isEmpty) {
                const snackBar = SnackBar(
                  content: Text(
                    'QR message cannot be empty.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (inputText.trim() == qrState.data.trim()) {
                const snackBar = SnackBar(
                  content: Text(
                    'QR message has not changed.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  backgroundColor: Colors.deepOrangeAccent,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                onGenerate(inputText);
              }
            } catch (e) {
              print('Error: $e');
            }
          },
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: const Text(
            'Generate',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}
