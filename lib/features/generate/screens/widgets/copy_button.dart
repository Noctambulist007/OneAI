import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:scannify/features/generate/providers/qr_provider.dart';
import 'package:scannify/features/scan/screens/scan_screen.dart';
import 'container_button.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({super.key, required this.qrState});

  final QRState qrState;

  @override
  Widget build(BuildContext context) {
    return ContainerButton(
      icon: Iconsax.copy5,
      text: 'Copy',
      onTap: () {
        Clipboard.setData(ClipboardData(text: qrState.data));
        const ScanScreenContent().showSnackbar(context, 'Copied to clipboard');
      },
    );
  }
}
