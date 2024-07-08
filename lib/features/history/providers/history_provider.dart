import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:scannify/data/repositories/db_history/generated_qr_db/history_database_provider.dart';
import 'package:scannify/data/repositories/db_history/generated_qr_db/history_item.dart';

class HistoryState extends ChangeNotifier {
  List<HistoryItem> _historyItems = [];

  List<HistoryItem> get historyItems => _historyItems;

  Map<String, List<HistoryItem>> get historyItemsGroupedByDate =>
      groupBy(_historyItems, (item) => item.date);

  Future<void> loadHistoryItems() async {
    _historyItems = await HistoryDatabaseProvider.instance.getHistoryItems();
    notifyListeners();
  }

  void deleteHistoryItem(int itemId) async {
    await HistoryDatabaseProvider.instance.deleteHistoryItem(itemId);
    _historyItems.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }
}
