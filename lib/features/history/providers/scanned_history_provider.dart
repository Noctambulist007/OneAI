import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:scannify/data/repositories/db_history/scanned_qr_db/scanned_qr.dart';
import 'package:scannify/data/repositories/db_history/scanned_qr_db/scanned_qr_database_provider.dart';

class ScannedHistoryState extends ChangeNotifier {
  List<ScannedQR> _scannedQRItems = [];

  List<ScannedQR> get scannedQRItems => _scannedQRItems;

  Map<String, List<ScannedQR>> get scannedQRItemsGroupedByDate {
    return groupBy(_scannedQRItems, (item) => formatDate(item.date));
  }

  Future<List<ScannedQR>> loadScannedQRItems() async {
    _scannedQRItems = await ScannedQRDatabaseProvider.instance.getScannedQRs();
    notifyListeners();
    return _scannedQRItems;
  }

  Future<void> deleteScannedQRItem(int itemId) async {
    try {
      await ScannedQRDatabaseProvider.instance.deleteScannedQR(itemId);
      _scannedQRItems.removeWhere((item) => item.id == itemId);
      notifyListeners();
    } catch (e) {
      print('Error deleting scanned QR item: $e');
    }
  }

  String formatDate(DateTime date) {
    return DateFormat("MMMM d, y hh:mm a").format(date);
  }
}
