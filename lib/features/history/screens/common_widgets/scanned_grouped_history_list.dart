import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:dashscan/data/repositories/db_history/scanned_qr_db/scannedQR.dart';
import 'package:dashscan/data/repositories/db_history/scanned_qr_db/scanned_qr_database_provider.dart';
import 'package:dashscan/features/history/providers/scanned_history_provider.dart';
import 'package:dashscan/features/history/screens/scanned_tab_screen/widgets/scanned_history_item_tile.dart';
import 'package:dashscan/utils/constants/colors.dart';

class ScannedGroupedHistoryList extends StatelessWidget {
  final Map<String, List<ScannedQR>> groupedHistory;
  final ScannedHistoryState historyState;

  const ScannedGroupedHistoryList({
    super.key,
    required this.groupedHistory,
    required this.historyState,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: groupedHistory.keys.length,
      separatorBuilder: (context, index) => const SizedBox(height: 0),
      itemBuilder: (context, index) {
        String date = groupedHistory.keys.toList()[index];
        List<ScannedQR> items = groupedHistory[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                date,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                  color: AppColors.primary,
                ),
              ),
            ),
            AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, innerIndex) {
                  ScannedQR historyItem = items[innerIndex];

                  return AnimationConfiguration.staggeredList(
                    position: innerIndex,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: ScannedHistoryItemTile(
                          historyItem: historyItem,
                          onDelete: () async {
                            historyState.deleteScannedQRItem(historyItem.id!);
                            await ScannedQRDatabaseProvider.instance
                                .deleteScannedQR(historyItem.id!);

                            groupedHistory[date]!.remove(historyItem);
                            if (groupedHistory[date]!.isEmpty) {
                              groupedHistory.remove(date);
                            }

                            historyState.notifyListeners();

                            var snackBar = const SnackBar(
                              content: Text(
                                'Item Deleted.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
