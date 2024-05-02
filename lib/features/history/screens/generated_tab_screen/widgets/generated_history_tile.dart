import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:dashscan/utils/constants/colors.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneratedHistoryTile extends StatelessWidget {
  final int? id;
  final String type;
  final String title;
  final String date;
  final Widget icon;
  final VoidCallback onDelete;

  const GeneratedHistoryTile({
    super.key,
    required this.id,
    required this.title,
    required this.date,
    required this.onDelete,
    required this.icon,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ObjectKey(id),
      trailingActions: [
        SwipeAction(
          performsFirstActionWithFullSwipe: true,
          onTap: (CompletionHandler handler) async {
            onDelete();
            handler(true);
          },
          color: Colors.red,
          content: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 20.0,
            ),
          ),
        ),
      ],
      child: Container(
        color: const Color(0xffe7ebee),
        child: ListTile(
          leading: icon,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                type,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          subtitle: Text(date),
          trailing: _buildCustomPopupMenuButton(context, title),
        ),
      ),
    );
  }

  Widget _buildCustomPopupMenuButton(BuildContext context, String title) {
    return PopupMenuButton<int>(
      color: const Color(0xffe7ebee),
      offset: const Offset(0, 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      itemBuilder: (context) => [
        _buildCustomPopupMenuItem(context, 'Go to', Icons.link_outlined, title),
        _buildCustomPopupMenuItem(context, 'Copy', Icons.copy_outlined, title),
        _buildCustomPopupMenuItem(
            context, 'Share', Icons.share_outlined, title),
      ],
      onSelected: (int value) {},
      icon: const Icon(Icons.more_horiz),
    );
  }

  void _goToLink(BuildContext context, String url) async {
    if (_isValidUrl(url)) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      const snackBar = SnackBar(
        content: Text(
          'This is not a valid URL',
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
    }
  }

  bool _isValidUrl(String url) {
    RegExp urlRegExp = RegExp(
      r'^(?:http|https):\/\/'
      r'(?:www\.)?'
      r'(?:(?!ww\d{1,3}\.))'
      r'(?:(?!ww\d{1,3}\.)(?:[a-zA-Z0-9][a-zA-Z0-9-]{0,61}[a-zA-Z0-9]\.)+'
      r'[a-zA-Z]{2,6}'
      r'(?:\/[^\/#?]+)+\/?)'
      r'(?:\/|$)',
      caseSensitive: false,
      multiLine: false,
    );
    return urlRegExp.hasMatch(url);
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    const snackBar = SnackBar(
      content: Text(
        'Copied to clipboard',
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
  }

  void _shareContent(String text) {
    Share.share(text);
  }

  PopupMenuItem<int> _buildCustomPopupMenuItem(
    BuildContext context,
    String text,
    IconData icon,
    String title,
  ) {
    return PopupMenuItem<int>(
      value: text.hashCode,
      child: GestureDetector(
        onTap: () {
          switch (text) {
            case 'Go to':
              _goToLink(context, title);
              break;
            case 'Copy':
              _copyToClipboard(context, title);
              break;
            case 'Share':
              _shareContent(title);
              break;
          }
        },
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8.0),
            Text(
              text,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
