import 'package:dashscan/data/repositories/db_history/generated_qr_db/history_item.dart';
import 'package:flutter/material.dart';
import 'generated_history_tile.dart';

class GeneratedHistoryItemTile extends StatelessWidget {
  final HistoryItem historyItem;
  final Function onDelete;

  const GeneratedHistoryItemTile({
    super.key,
    required this.historyItem,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GeneratedHistoryTile(
      id: historyItem.id ?? 0,
      title: historyItem.title,
      type: historyItem.qrImage,
      date: historyItem.date,
      onDelete: () => onDelete(),
      icon: Image.asset('assets/images/qr_code.png'),
    );
  }
}
