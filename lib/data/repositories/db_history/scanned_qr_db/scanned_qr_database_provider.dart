import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:scannify/data/repositories/db_history/scanned_qr_db/scanned_qr.dart';

class ScannedQRDatabaseProvider {
  late Database _database;

  ScannedQRDatabaseProvider._();

  static final ScannedQRDatabaseProvider _instance =
      ScannedQRDatabaseProvider._();

  static ScannedQRDatabaseProvider get instance => _instance;

  Future<void> initialize() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'scanned_qr_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE scanned_qrs(id INTEGER PRIMARY KEY AUTOINCREMENT, qrImage TEXT, title TEXT, result TEXT, date TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertScannedQR(ScannedQR scannedQR) async {
    try {
      await _database.insert(
        'scanned_qrs',
        scannedQR.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting scanned QR: $e');
    }
  }

  Future<List<ScannedQR>> getScannedQRs() async {
    final List<Map<String, dynamic>> maps =
        await _database.query('scanned_qrs');

    return List.generate(maps.length, (i) {
      return ScannedQR.fromMap(maps[i]);
    });
  }

  Future<void> deleteScannedQR(int id) async {
    try {
      await _database.delete('scanned_qrs', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting scanned QR: $e');
      rethrow;
    }
  }

  Future<void> close() async {
    await _database.close();
  }
}
