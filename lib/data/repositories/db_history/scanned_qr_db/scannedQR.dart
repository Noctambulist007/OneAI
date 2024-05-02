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
      'qrImage': qrImage,
      'title': title,
      'result': result,
      'date': date.toIso8601String(),
    };
  }

  factory ScannedQR.fromMap(Map<String, dynamic> map) {
    return ScannedQR(
      id: map['id'],
      qrImage: map['qrImage'],
      title: map['title'],
      result: map['result'],
      date: DateTime.parse(map['date']),
    );
  }
}
