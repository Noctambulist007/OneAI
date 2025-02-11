import 'package:flutter/material.dart';
import 'package:one_ai/features/generate/screens/widgets/about_us_dialog.dart';
import 'package:one_ai/features/history/providers/history_sync_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:one_ai/utils/constants/colors.dart';
import 'package:one_ai/features/history/screens/history_screen.dart'; // Ensure you import the correct path

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: const Color(0xffe7ebee),
      offset: const Offset(0, 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onSelected: (String value) async {
        switch (value) {
          case 'Backup':
            await HistorySyncService.backupToFirestore(context);
            break;
          case 'Restore':
            await HistorySyncService.restoreFromFirestore(context);
            break;
          case 'About Us':
            _showAboutUsDialog(context);
            break;
          case 'More Apps':
            await launchUrl(Uri.parse(
                'https://play.google.com/store/apps/dev?id=8217403384611399596'));
            break;
          case 'Privacy and Policy':
            await launchUrl(Uri.parse('https://sites.google.com/view/scannify'));
            break;
        }
      },
      itemBuilder: (context) => [
        _buildMenuItem('Backup', Icons.backup_outlined),
        _buildMenuItem('Restore', Icons.restore),
        const PopupMenuDivider(),
        _buildMenuItem('About Us', Icons.info_outline),
        _buildMenuItem('More Apps', Icons.apps_outlined),
        // _buildMenuItem('Privacy and Policy', Icons.privacy_tip_outlined),
      ],
      icon: const Icon(
        Icons.more_vert,
        color: AppColors.white,
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(String text, IconData icon) {
    return PopupMenuItem<String>(
      value: text,
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutUsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const AboutUsDialog(),
    );
  }
}