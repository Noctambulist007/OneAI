import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scannify/data/repositories/db_history/generated_qr_db/history_database_provider.dart';
import 'package:scannify/data/repositories/db_history/generated_qr_db/history_item.dart';
import 'package:scannify/features/generate/providers/qr_provider.dart';
import 'package:scannify/features/generate/screens/widgets/qr_code_section.dart';
import 'package:scannify/features/generate/screens/widgets/replaceable_lottie_animation.dart';
import 'package:scannify/features/generate/screens/widgets/save_button.dart';
import 'custom_text_field.dart';

class BodyContent extends StatelessWidget {
  const BodyContent({
    super.key,
    required this.itemText,
    required this.qrState,
  });

  final String itemText;
  final QRState qrState;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          CustomTextField(qrState: qrState),
          const SizedBox(
            height: 15,
          ),
          Visibility(
            visible: !qrState.isBottomSheetOpen && qrState.data.isNotEmpty,
            replacement: const LottieAnimation(),
            child: QrCodeSection(qrState: qrState),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SaveButton(
              qrState: qrState,
              itemText: itemText,
              onGenerate: (inputText) {
                qrState.data = inputText;
                HistoryItem historyItem = HistoryItem(
                  title: inputText,
                  date:
                      DateFormat('MMMM d, yyyy hh:mm a').format(DateTime.now()),
                  qrImage: itemText,
                );

                HistoryDatabaseProvider.instance.insertHistoryItem(historyItem);
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }
}
