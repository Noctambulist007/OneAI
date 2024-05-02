import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dashscan/features/generate/providers/qr_provider.dart';
import 'package:dashscan/utils/constants/colors.dart';
import 'container_button.dart';

class SaveImageButton extends StatelessWidget {
  const SaveImageButton({super.key, required this.qrState});

  final QRState qrState;

  @override
  Widget build(BuildContext context) {
    return ContainerButton(
      icon: FontAwesomeIcons.solidSave,
      text: 'Save',
      onTap: () async {
        await qrState.captureAndSavePng();
        const snackBar = SnackBar(
          content: Text(
            'QR image saved to download folder.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w300,
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: AppColors.primary,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
}
