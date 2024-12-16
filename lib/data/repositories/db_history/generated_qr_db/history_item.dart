class HistoryItem {
  int? id;
  String title;
  String date;
  String qrImage;

  HistoryItem({
    this.id,
    required this.title,
    required this.date,
    required this.qrImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'qrImage': qrImage,
    };
  }

  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      id: map['id'],
      title: map['title'],
      date: map['date'],
      qrImage: map['qrImage'],
    );
  }
}
