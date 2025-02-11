import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_ai/data/repositories/db_history/generated_qr_db/history_database_provider.dart';
import 'package:one_ai/data/repositories/db_history/generated_qr_db/history_item.dart';
import 'package:one_ai/data/repositories/db_history/scanned_qr_db/scanned_qr.dart';
import 'package:one_ai/data/repositories/db_history/scanned_qr_db/scanned_qr_database_provider.dart';

class HistorySyncService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> backupToFirestore(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      final scannedQRs =
          await ScannedQRDatabaseProvider.instance.getScannedQRs();
      final scannedBatch = _firestore.batch();

      for (var qr in scannedQRs) {
        final docRef = _firestore
            .collection('users')
            .doc(user.uid)
            .collection('scanned_history')
            .doc(qr.id.toString());
        scannedBatch.set(docRef, qr.toFirestore());
      }
      await scannedBatch.commit();

      final historyItems =
          await HistoryDatabaseProvider.instance.getHistoryItems();
      final generatedBatch = _firestore.batch();

      for (var item in historyItems) {
        final docRef = _firestore
            .collection('users')
            .doc(user.uid)
            .collection('generated_history')
            .doc(item.id.toString());
        generatedBatch.set(docRef, item.toFirestore());
      }
      await generatedBatch.commit();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup completed successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Backup failed: ${e.toString()}')),
      );
    }
  }

  static Future<void> restoreFromFirestore(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      final scannedSnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('scanned_history')
          .get();

      for (var doc in scannedSnapshot.docs) {
        final scannedQR = ScannedQR.fromMap(doc.data());
        await ScannedQRDatabaseProvider.instance.insertScannedQR(scannedQR);
      }

      final generatedSnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('generated_history')
          .get();

      for (var doc in generatedSnapshot.docs) {
        final historyItem = HistoryItem.fromMap(doc.data());
        await HistoryDatabaseProvider.instance.insertHistoryItem(historyItem);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Restore completed successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Restore failed: ${e.toString()}')),
      );
    }
  }
}
