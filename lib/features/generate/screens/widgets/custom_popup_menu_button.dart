import 'package:dashscan/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about_us_dialog.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({super.key});

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
          launch('https://play.google.com/store/apps/developer?id=Elort');
        } else if (value == 'Privacy and Policy') {
          launch('https://elort.com/privacy.html');
        }
      },
      itemBuilder: (context) => [
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
