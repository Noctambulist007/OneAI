import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/data/repositories/db_history/generated_qr_db/history_database_provider.dart';
import 'package:one_ai/data/repositories/db_history/generated_qr_db/history_item.dart';
import 'package:one_ai/data/repositories/db_history/scanned_qr_db/scanned_qr.dart';
import 'package:one_ai/data/repositories/db_history/scanned_qr_db/scanned_qr_database_provider.dart';
import 'package:one_ai/features/generate/screens/widgets/custom_popup_menu_button.dart';
import 'package:one_ai/features/history/providers/history_provider.dart';
import 'package:one_ai/features/history/providers/scanned_history_provider.dart';
import 'package:one_ai/features/history/screens/common_widgets/empty_history.dart';
import 'package:one_ai/features/history/screens/common_widgets/generated_grouped_history_list.dart';
import 'package:one_ai/features/history/screens/common_widgets/scanned_grouped_history_list.dart';
import 'package:one_ai/utils/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.secondary,
              Color(0xFF1D5C5C),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoMono',
                    color: AppColors.white,
                  ),
                ),
                CustomPopupMenuButton(),
              ],
            ),
            bottom: const TabBar(
              labelColor: AppColors.primary,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'RobotoMono',
                color: AppColors.black,
              ),
              indicatorColor: AppColors.primary,
              tabs: [
                Tab(text: 'Scanned'),
                Tab(text: 'Generated'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildScannedTab(),
              _buildGeneratedTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScannedTab() {
    return Consumer<ScannedHistoryState>(
      builder: (context, historyState, _) {
        return FutureBuilder<List<ScannedQR>>(
          future: ScannedQRDatabaseProvider.instance.getScannedQRs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const EmptyHistory();
            } else {
              List<ScannedQR> scannedQRs = snapshot.data!;

              _saveOrUpdateScannedHistory(scannedQRs);

              List<ScannedQR> historyItems = scannedQRs.map((scannedQR) {
                return ScannedQR(
                  id: scannedQR.id,
                  qrImage: scannedQR.qrImage,
                  title: scannedQR.result,
                  result: scannedQR.result ?? '',
                  date: scannedQR.date,
                );
              }).toList();

              Map<String, List<ScannedQR>> groupedHistory =
                  _groupByDateScannedQR(historyItems);

              return ScannedGroupedHistoryList(
                groupedHistory: groupedHistory,
                historyState: historyState,
              );
            }
          },
        );
      },
    );
  }

  Widget _buildGeneratedTab() {
    return Consumer<HistoryState>(
      builder: (context, historyState, _) {
        return FutureBuilder<List<HistoryItem>>(
          future: HistoryDatabaseProvider.instance.getHistoryItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const EmptyHistory();
            } else {
              List<HistoryItem> historyItems = snapshot.data!;

              _saveOrUpdateGeneratedHistory(historyItems);

              Map<String, List<HistoryItem>> groupedHistory =
                  _groupByDate(historyItems);
              return GeneratedGroupedHistoryList(
                groupedHistory: groupedHistory,
                historyState: historyState,
              );
            }
          },
        );
      },
    );
  }

  Map<String, List<HistoryItem>> _groupByDate(List<HistoryItem> historyItems) {
    Map<String, List<HistoryItem>> groupedHistory = {};

    for (var historyItem in historyItems) {
      DateTime dateTime =
          DateFormat("MMMM d, y hh:mm a").parse(historyItem.date);
      String formattedDate = DateFormat("MMMM d, y").format(dateTime);

      if (groupedHistory.containsKey(formattedDate)) {
        groupedHistory[formattedDate]!.add(historyItem);
      } else {
        groupedHistory[formattedDate] = [historyItem];
      }
    }

    return groupedHistory;
  }

  Map<String, List<ScannedQR>> _groupByDateScannedQR(
      List<ScannedQR> historyItems) {
    Map<String, List<ScannedQR>> groupedHistory = {};

    for (var historyItem in historyItems) {
      String formattedDate = DateFormat("MMMM d, y").format(historyItem.date);

      if (groupedHistory.containsKey(formattedDate)) {
        groupedHistory[formattedDate]!.add(historyItem);
      } else {
        groupedHistory[formattedDate] = [historyItem];
      }
    }

    return groupedHistory;
  }

  void _saveOrUpdateGeneratedHistory(List<HistoryItem> historyItems) async {
    final user = FirebaseAuth.instance.currentUser;
    final generatedHistoryCollection =
        FirebaseFirestore.instance.collection('generated_history');

    for (var historyItem in historyItems) {
      try {
        await generatedHistoryCollection
            .doc('${user!.uid}_${historyItem.id}')
            .set({
          'id': historyItem.id,
          'title': historyItem.title,
          'qrImage': historyItem.qrImage,
          'date': historyItem.date,
        });
      } catch (e) {
        print('Error saving history item: $e');
      }
    }
  }

  void _saveOrUpdateScannedHistory(List<ScannedQR> scannedQRs) async {
    final user = FirebaseAuth.instance.currentUser;
    final scannedHistoryCollection =
        FirebaseFirestore.instance.collection('scanned_history');

    for (var scannedQR in scannedQRs) {
      try {
        await scannedHistoryCollection.doc('${user!.uid}_${scannedQR.id}').set({
          'id': scannedQR.id,
          'qrImage': scannedQR.qrImage,
          'result': scannedQR.result,
          'date': scannedQR.date,
        });
      } catch (e) {
        print('Error saving scanned QR: $e');
      }
    }
  }

  void backupDataToFirestore() {
    final user = FirebaseAuth.instance.currentUser;
    final scannedHistoryCollection =
        FirebaseFirestore.instance.collection('scanned_history');
    final generatedHistoryCollection =
        FirebaseFirestore.instance.collection('generated_history');

    ScannedQRDatabaseProvider.instance.getScannedQRs().then((scannedQRs) {
      for (var scannedQR in scannedQRs) {
        try {
          scannedHistoryCollection.doc('${user!.uid}_${scannedQR.id}').set({
            'id': scannedQR.id,
            'qrImage': scannedQR.qrImage,
            'result': scannedQR.result,
            'date': scannedQR.date,
          });
        } catch (e) {
          print('Error backing up scanned QR: $e');
        }
      }
    });

    HistoryDatabaseProvider.instance.getHistoryItems().then((historyItems) {
      for (var historyItem in historyItems) {
        try {
          generatedHistoryCollection.doc('${user!.uid}_${historyItem.id}').set({
            'id': historyItem.id,
            'title': historyItem.title,
            'qrImage': historyItem.qrImage,
            'date': historyItem.date,
          });
        } catch (e) {
          print('Error backing up generated history item: $e');
        }
      }
    });
  }

  void restoreDataFromFirestore() {
    final user = FirebaseAuth.instance.currentUser;
    final scannedHistoryCollection =
        FirebaseFirestore.instance.collection('scanned_history');
    final generatedHistoryCollection =
        FirebaseFirestore.instance.collection('generated_history');

    scannedHistoryCollection.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.id.startsWith(user!.uid)) {
          try {
            ScannedQR scannedQR = ScannedQR(
              id: doc['id'],
              qrImage: doc['qrImage'],
              title: doc['title'],
              result: doc['result'],
              date: doc['date'] != null
                  ? (doc['date'] as Timestamp).toDate()
                  : DateTime.now(),
            );
            ScannedQRDatabaseProvider.instance.insertScannedQR(scannedQR);
          } catch (e) {
            print('Error restoring scanned QR: $e');
          }
        }
      });
    });

    generatedHistoryCollection.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.id.startsWith(user!.uid)) {
          try {
            HistoryItem historyItem = HistoryItem(
              id: doc['id'],
              title: doc['title'],
              qrImage: doc['qrImage'],
              date: doc['date'],
            );
            HistoryDatabaseProvider.instance.insertHistoryItem(historyItem);
          } catch (e) {
            print('Error restoring generated history item: $e');
          }
        }
      });
    });
  }
}
