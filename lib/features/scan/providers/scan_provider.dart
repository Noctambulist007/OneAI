import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:one_ai/data/repositories/db_history/scanned_qr_db/scanned_qr.dart';
import 'package:one_ai/data/repositories/db_history/scanned_qr_db/scanned_qr_database_provider.dart';
import 'package:wifi_iot/wifi_iot.dart';

class ScanProvider extends ChangeNotifier {
  final ScannedQRDatabaseProvider _databaseProvider =
      ScannedQRDatabaseProvider.instance;

  String _qrResult = '';
  bool _isWiFiQR = false;
  bool _isConnecting = false;
  bool _isConnected = false;
  Map<String, String> _wifiDetails = {};

  String get qrResult => _qrResult;

  bool get isWiFiQR => _isWiFiQR;

  bool get isConnecting => _isConnecting;

  bool get isConnected => _isConnected;

  Map<String, String> get wifiDetails => _wifiDetails;

  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#0A585D',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (qrCode != '-1') {
        _parseQRCode(qrCode);

        final scannedQR = ScannedQR(
          id: 0,
          qrImage: '',
          title: _isWiFiQR ? 'WiFi Network' : 'QR Scan',
          result: _qrResult,
          date: DateTime.now(),
        );

        await _databaseProvider.insertScannedQR(scannedQR);

        if (_isWiFiQR) {
          try {
            await connectToWiFi();
          } catch (e) {
            print('Error connecting to WiFi: $e');
          }
        }

        notifyListeners();
      }
    } on PlatformException catch (e) {
      print('Error scanning QR code: $e');
    }
  }

  void _parseQRCode(String qrCode) {
    _isWiFiQR = false;
    _wifiDetails = {};
    _isConnected = false;

    final wifiRegex = RegExp(
      r'^WIFI:((?:S:([^;]*);T:([^;]*);P:([^;]*);)|(?:T:([^;]*);S:([^;]*);P:([^;]*);))',
      caseSensitive: false,
    );

    final match = wifiRegex.firstMatch(qrCode);
    if (match != null) {
      _isWiFiQR = true;
      final ssid = match[2] ?? match[6] ?? '';
      final encryption = match[3] ?? match[5] ?? 'WPA2';
      final password = match[4] ?? match[7] ?? '';

      _wifiDetails = {
        'ssid': ssid.trim(),
        'password': password.trim(),
        'encryption': encryption.toUpperCase(),
      };

      _qrResult = '''
WiFi Network Details:
SSID: ${_wifiDetails['ssid']}
Encryption: ${_wifiDetails['encryption']}
Password: ${_wifiDetails['password']}
''';
    } else {
      _qrResult = qrCode;
    }
  }

  Future<bool> connectToWiFi() async {
    if (!_isWiFiQR || _wifiDetails.isEmpty) return false;

    final ssid = _wifiDetails['ssid']!;
    final password = _wifiDetails['password']!;
    final encryption = _wifiDetails['encryption']!;

    _isConnecting = true;
    notifyListeners();

    try {
      await WiFiForIoTPlugin.removeWifiNetwork(ssid);
      await WiFiForIoTPlugin.disconnect();

      final security = _parseSecurityType(encryption);

      final success = await WiFiForIoTPlugin.connect(
        ssid,
        password: password,
        security: security,
        joinOnce: true,
        withInternet: true,
      );

      if (success) {
        await Future.delayed(const Duration(seconds: 2));
        final currentSSID = await WiFiForIoTPlugin.getSSID();
        _isConnected = currentSSID == ssid;
        if (_isConnected) {
          _qrResult += '\n\n✅ Connected successfully!';
        }
      }

      return _isConnected;
    } catch (e) {
      print('WiFi Connection Error: $e');
      _qrResult += '\n\n❌ Connection failed: ${e.toString()}';
      return false;
    } finally {
      _isConnecting = false;
      notifyListeners();
    }
  }

  NetworkSecurity _parseSecurityType(String encryption) {
    switch (encryption.toUpperCase()) {
      case 'WEP':
        return NetworkSecurity.WEP;
      case 'WPA':
      case 'WPA2':
      case 'WPA3':
        return NetworkSecurity.WPA;
      case 'NONE':
      case 'NOPASS':
        return NetworkSecurity.NONE;
      default:
        return NetworkSecurity.WPA;
    }
  }
}
