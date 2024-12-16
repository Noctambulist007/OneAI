import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scannify/features/generate/models/qr_utils.dart';

class QRState extends ChangeNotifier {
  String _data = '';
  TextEditingController textController = TextEditingController(text: '');
  GlobalKey qrKey = GlobalKey();
  bool isBottomSheetOpen = false;
  bool dirExists = false;
  String externalDir = '/storage/emulated/0/Download/Qr_code';

  String get data => _data;

  set data(String newData) {
    _data = newData;
    notifyListeners();
  }

  Future<Uint8List> captureAndSavePng() async {
    return QRUtils.captureAndSavePng(
      qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary,
    );
  }
}
