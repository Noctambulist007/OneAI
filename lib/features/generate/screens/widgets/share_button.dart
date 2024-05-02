import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dashscan/features/generate/providers/qr_provider.dart';
import 'package:share/share.dart';
import 'container_button.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key, required this.qrState});

  final QRState qrState;

  @override
  Widget build(BuildContext context) {
    return ContainerButton(
      icon: Icons.share,
      text: 'Share',
      onTap: () async {
        Uint8List qrImageBytes = await qrState.captureAndSavePng();
        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/qr_code.png');
        await tempFile.writeAsBytes(qrImageBytes);
        Share.shareFiles([tempFile.path], text: 'Check out my QR code image!');
      },
    );
  }
}
