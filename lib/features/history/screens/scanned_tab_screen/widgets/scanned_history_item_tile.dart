import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dashscan/data/repositories/db_history/scanned_qr_db/scannedQR.dart';
import 'scanned_history_tile.dart';

class ScannedHistoryItemTile extends StatelessWidget {
  final ScannedQR historyItem;
  final void Function() onDelete;

  const ScannedHistoryItemTile({
    super.key,
    required this.historyItem,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('MMMM d, y hh:mm a').format(historyItem.date);

    return ScannedHistoryTile(
      id: historyItem.id,
      title: historyItem.title,
      date: formattedDate,
      onDelete: onDelete,
      icon: Image.asset('assets/images/qr_code.png'),
    );
  }
}
