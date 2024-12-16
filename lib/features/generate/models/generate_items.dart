import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'generate_item_model.dart';

class GenerateItems {
  List<GenerateItemModel> generateItems() {
    return [
      GenerateItemModel(icon: FontAwesomeIcons.clipboardList, text: 'Clipboard'),
      GenerateItemModel(icon: FontAwesomeIcons.link, text: 'Website'),
      GenerateItemModel(icon: FontAwesomeIcons.wifi, text: 'Wi-Fi'),
      GenerateItemModel(icon: FontAwesomeIcons.facebook, text: 'Facebook'),
      GenerateItemModel(icon: FontAwesomeIcons.youtube, text: 'Youtube'),
      GenerateItemModel(icon: FontAwesomeIcons.whatsapp, text: 'Whatsapp'),
      GenerateItemModel(icon: FontAwesomeIcons.solidFileText, text: 'Text'),
      GenerateItemModel(icon: FontAwesomeIcons.solidContactBook, text: 'Contacts'),
      GenerateItemModel(icon: FontAwesomeIcons.phone, text: 'Phone'),
      GenerateItemModel(icon: FontAwesomeIcons.solidEnvelope, text: 'E-Mail'),
      GenerateItemModel(icon: FontAwesomeIcons.solidMessage, text: 'SMS'),
      GenerateItemModel(icon: FontAwesomeIcons.solidIdCard, text: 'My Card'),
      GenerateItemModel(icon: FontAwesomeIcons.instagram, text: 'Instagram'),
      GenerateItemModel(icon: FontAwesomeIcons.twitter, text: 'Twitter'),
      GenerateItemModel(icon: FontAwesomeIcons.spotify, text: 'Spotify'),
      GenerateItemModel(icon: FontAwesomeIcons.paypal, text: 'Paypal'),
      GenerateItemModel(icon: FontAwesomeIcons.solidCalendar, text: 'Calendar'),
      GenerateItemModel(icon: FontAwesomeIcons.telegram, text: 'Telegram'),
      GenerateItemModel(icon: FontAwesomeIcons.linkedin, text: 'LinkedIn'),
      GenerateItemModel(icon: FontAwesomeIcons.slack, text: 'Slack'),
      GenerateItemModel(icon: FontAwesomeIcons.discord, text: 'Discord'),
    ];
  }
}
