import 'package:cloud_firestore/cloud_firestore.dart';

class ScannedQR {
  int? id;
  String qrImage;
  String title;
  String result;
  DateTime date;

  ScannedQR({
    this.id,
    required this.qrImage,
    required this.title,
    required this.result,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'qrImage': qrImage,
      'title': title,
      'result': result,
      'date': date.toIso8601String(),
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'qrImage': qrImage,
      'title': title,
      'result': result,
      'date': date,
    };
  }

  factory ScannedQR.fromMap(Map<String, dynamic> map) {
    return ScannedQR(
      id: map['id'],
      qrImage: map['qrImage'],
      title: map['title'] ?? map['result'] ?? '',
      result: map['result'] ?? '',
      date: map['date'] is String
          ? DateTime.parse(map['date'])
          : (map['date'] as Timestamp).toDate(),
    );
  }
}