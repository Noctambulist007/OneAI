import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:dashscan/features/generate/providers/qr_provider.dart';
import 'package:dashscan/features/generate/screens/widgets/save_image_button.dart';
import 'package:dashscan/features/generate/screens/widgets/share_button.dart';
import 'copy_button.dart';

class QrCodeSection extends StatelessWidget {
  const QrCodeSection({super.key, required this.qrState});

  final QRState qrState;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          RepaintBoundary(
            key: qrState.qrKey,
            child: QrImageView(
              data: qrState.data,
              version: QrVersions.auto,
              size: 250.0,
              gapless: true,
              errorStateBuilder: (ctx, err) {
                return const Center(
                  child: Text(
                    'Something went wrong.',
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CopyButton(qrState: qrState),
              SaveImageButton(qrState: qrState),
              ShareButton(qrState: qrState),
            ],
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
