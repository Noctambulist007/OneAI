import 'package:flutter/material.dart';
import 'package:dashscan/data/repositories/db_history/generated_qr_db/history_database_provider.dart';
import 'package:dashscan/data/repositories/db_history/generated_qr_db/history_item.dart';
import 'package:dashscan/data/repositories/db_history/scanned_qr_db/scannedQR.dart';
import 'package:dashscan/data/repositories/db_history/scanned_qr_db/scanned_qr_database_provider.dart';
import 'package:dashscan/features/history/providers/history_provider.dart';
import 'package:dashscan/features/history/providers/scanned_history_provider.dart';
import 'package:dashscan/features/history/screens/common_widgets/scanned_grouped_history_list.dart';
import 'package:dashscan/utils/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'common_widgets/empty_history.dart';
import 'common_widgets/generated_grouped_history_list.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'History',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: AppColors.primary,
            ),
          ),
          bottom: const TabBar(
            labelColor: AppColors.primary,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
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
}
