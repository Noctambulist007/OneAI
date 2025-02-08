import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/generate/screens/widgets/container_button.dart';
import 'package:one_ai/features/scan/providers/scan_provider.dart';
import 'package:one_ai/features/scan/screens/widgets/tap_to_scan_button.dart';
import 'package:one_ai/utils/constants/colors.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanScreenContent extends StatelessWidget {
  const ScanScreenContent({super.key});

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        content: Text(
          message,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w300,
            fontFamily: 'RobotoMono',
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanProvider>(context);
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
          iconTheme: const IconThemeData(
            color: AppColors.white,
          ),
          title: const Text(
            'Scannify',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
              color: AppColors.white,
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Place QR code inside the frame to scan.\nPlease avoid shake to get result quickly',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'RobotoMono',
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    height: 350,
                    child: Lottie.asset(
                      'assets/animations/dashscan.json',
                      reverse: true,
                      repeat: true,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Visibility(
                    visible: scanProvider.qrResult.isNotEmpty,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              scanProvider.isWiFiQR
                                  ? 'WiFi Network Detected'
                                  : 'Scan Result',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'RobotoMono',
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              scanProvider.qrResult,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontFamily: 'RobotoMono',
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ContainerButton(
                                  icon: Iconsax.copy5,
                                  text: 'Copy',
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(
                                        text: scanProvider.qrResult));
                                    showSnackbar(
                                        context, 'Copied to clipboard');
                                  },
                                ),
                                if (!scanProvider.isWiFiQR)
                                  ContainerButton(
                                    icon: FontAwesomeIcons.link,
                                    text: 'Go To',
                                    onTap: () {
                                      launch(scanProvider.qrResult);
                                    },
                                  ),
                                ContainerButton(
                                  icon: Iconsax.share5,
                                  text: 'Share',
                                  onTap: () {
                                    Share.share(scanProvider.qrResult);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const TapToScan(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
