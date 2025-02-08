import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:one_ai/features/generate/models/qr_utils.dart';

class QRFeatureProvider extends ChangeNotifier {
  String _data = '';
  TextEditingController textController = TextEditingController(text: '');
  GlobalKey qrKey = GlobalKey();
  bool isBottomSheetOpen = false;
  bool dirExists = false;
  String externalDir = '/storage/emulated/0/Download/Qr_code';

  String get data => _data;

  set data(String newData) {
    _data = newData;
    textController.text = newData;
    notifyListeners();
  }

  Future<Uint8List> captureAndSavePng() async {
    return QRUtils.captureAndSavePng(
      qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary,
    );
  }

  void generateClipboardQR(String text) {
    data = text;
  }

  void generateWebsiteQR(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    data = url;
  }

  void generateWifiQR({
    required String ssid,
    required String password,
    String encryption = 'WPA', // WPA, WEP, or nopass
  }) {
    data = 'WIFI:T:$encryption;S:$ssid;P:$password;;';
  }

  void generateSocialProfileQR({
    required String platform,
    required String username,
  }) {
    Map<String, String> platformUrls = {
      'facebook': 'https://facebook.com/',
      'youtube': 'https://youtube.com/@',
      'twitter': 'https://twitter.com/',
      'instagram': 'https://instagram.com/',
      'linkedin': 'https://linkedin.com/in/',
      'spotify': 'https://open.spotify.com/user/',
      'whatsapp': 'https://wa.me/',
      'telegram': 'https://t.me/',
      'discord': 'https://discord.gg/',
      'slack': 'https://slack.com/app_redirect?channel=',
    };

    if (platformUrls.containsKey(platform.toLowerCase())) {
      data = '${platformUrls[platform.toLowerCase()]}$username';
    }
  }

  void generateContactQR({
    required String name,
    required String phone,
    String? email,
    String? organization,
  }) {
    final vCard = '''BEGIN:VCARD
VERSION:3.0
FN:$name
TEL:$phone
${email != null ? 'EMAIL:$email' : ''}
${organization != null ? 'ORG:$organization' : ''}
END:VCARD''';

    data = vCard;
  }

  // Email
  void generateEmailQR({
    required String email,
    String? subject,
    String? body,
  }) {
    String mailtoUrl = 'mailto:$email';
    if (subject != null || body != null) {
      mailtoUrl += '?';
      if (subject != null)
        mailtoUrl += 'subject=${Uri.encodeComponent(subject)}';
      if (body != null) {
        if (subject != null) mailtoUrl += '&';
        mailtoUrl += 'body=${Uri.encodeComponent(body)}';
      }
    }
    data = mailtoUrl;
  }

  void generateSMSQR({
    required String phoneNumber,
    String? message,
  }) {
    String smsUrl = 'sms:$phoneNumber';
    if (message != null) {
      smsUrl += '?body=${Uri.encodeComponent(message)}';
    }
    data = smsUrl;
  }

  void generateCalendarQR({
    required String summary,
    required DateTime start,
    required DateTime end,
    String? description,
    String? location,
  }) {
    final event = '''BEGIN:VEVENT
SUMMARY:$summary
DTSTART:${_formatDateTime(start)}
DTEND:${_formatDateTime(end)}
${description != null ? 'DESCRIPTION:$description' : ''}
${location != null ? 'LOCATION:$location' : ''}
END:VEVENT''';

    data = event;
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.toIso8601String().replaceAll('-', '').replaceAll(':', '').split('.')[0]}Z';
  }

  void generatePayPalQR({
    required String paypalUsername,
    double? amount,
    String? currency = 'USD',
  }) {
    String paypalUrl = 'https://paypal.me/$paypalUsername';
    if (amount != null) {
      paypalUrl += '/$amount$currency';
    }
    data = paypalUrl;
  }

  void generateMyCardQR({
    required String name,
    required String title,
    required String phone,
    required String email,
    String? website,
    String? company,
    String? address,
  }) {
    final vCard = '''BEGIN:VCARD
VERSION:3.0
FN:$name
TITLE:$title
TEL:$phone
EMAIL:$email
${website != null ? 'URL:$website' : ''}
${company != null ? 'ORG:$company' : ''}
${address != null ? 'ADR:;;$address' : ''}
END:VCARD''';

    data = vCard;
  }

  void generateTextQR(String text) {
    data = text;
  }

  void clearData() {
    data = '';
    textController.clear();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
