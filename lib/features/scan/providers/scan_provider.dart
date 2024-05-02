import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:dashscan/data/repositories/db_history/scanned_qr_db/scannedQR.dart';
import 'package:dashscan/data/repositories/db_history/scanned_qr_db/scanned_qr_database_provider.dart';

class ScanProvider extends ChangeNotifier {
  final ScannedQRDatabaseProvider _databaseProvider =
      ScannedQRDatabaseProvider.instance;

  String _qrResult = '';

  String get qrResult => _qrResult;

  ScanProvider() {
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    try {
      await _databaseProvider.initialize();
    } catch (e) {
      print('Error initializing database: $e');
    }
  }

  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#0A585D',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (qrCode != '-1') {
        final scannedQR = ScannedQR(
          id: 0,
          qrImage: '',
          title: '',
          result: qrCode.toString(),
          date: DateTime.now(),
        );

        await _databaseProvider.insertScannedQR(scannedQR);
        _qrResult = qrCode.toString();
        notifyListeners();
      }
    } on PlatformException catch (e) {
      print('Error scanning QR code: $e');
    }
  }

  void resetResult() {
    _qrResult = 'Loading...';
    notifyListeners();
  }
}
