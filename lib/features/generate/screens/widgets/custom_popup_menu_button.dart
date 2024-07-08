import 'package:flutter/material.dart';
import 'package:scannify/features/generate/screens/widgets/about_us_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scannify/utils/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scannify/features/history/screens/history_screen.dart'; // Ensure you import the correct path

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
      onSelected: (String value) {
        if (value == 'About Us') {
          _showAboutUsDialog(context);
        } else if (value == 'More Apps') {
          launch('https://play.google.com/store/apps/dev?id=8217403384611399596');
        } else if (value == 'Privacy and Policy') {
          launch('https://sites.google.com/view/scannify');
        } else if (value == 'Backup') {
          _backupData(context);
        } else if (value == 'Restore') {
          _restoreData(context);
        }
      },
      itemBuilder: (context) => [
        _customPopupMenuItem('Backup', Icons.backup_outlined),
        _customPopupMenuItem('Restore', Icons.restore),
        PopupMenuDivider(),
        _customPopupMenuItem('About Us', Icons.info_outline),
        _customPopupMenuItem('More Apps', Icons.apps_outlined),
        _customPopupMenuItem('Privacy and Policy', Icons.privacy_tip_outlined),
      ],
      icon: const Icon(
        Icons.more_vert,
        color: AppColors.primary,
      ),
    );
  }

  PopupMenuItem<String> _customPopupMenuItem(String text, IconData icon) {
    return PopupMenuItem<String>(
      value: text,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Poppins',
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
      builder: (BuildContext context) {
        return const AboutUsDialog();
      },
    );
  }

  void _backupData(BuildContext context) {
    final historyScreen = HistoryScreen();
    historyScreen.backupDataToFirestore();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Backup successful')),
    );
  }

  void _restoreData(BuildContext context) {
    final historyScreen = HistoryScreen();
    historyScreen.restoreDataFromFirestore();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Restore successful')),
    );
  }
}
