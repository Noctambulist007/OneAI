import 'package:dashscan/dashscan.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/repositories/db_history/scanned_qr_db/scanned_qr_database_provider.dart';
import 'features/history/providers/history_provider.dart';
import 'features/history/providers/scanned_history_provider.dart';
import 'features/push_notifications/services/firebase_api.dart';
import 'features/scan/providers/scan_provider.dart';
import 'features/walkthrough/providers/onboarding/onboarding_provider.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDrsxVq_bBAyLzJix3oJCUEBlObuw6SfJE",
        appId: "1:830276298820:android:010d7f0299f7f7c1563411",
        messagingSenderId: "830276298820",
        projectId: "dashscan-b672c",
      ),
    );
    await FirebaseApi().initNotifications();
    await ScannedQRDatabaseProvider.instance.initialize();

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => OnBoardingProvider()),
          ChangeNotifierProvider(create: (context) => ScanProvider()),
          ChangeNotifierProvider(create: (context) => ScannedHistoryState()),
          ChangeNotifierProvider(create: (context) => HistoryState()),
        ],
        child: const DashScan(),
      ),
    );
  } catch (e) {
    print('Error initializing app: $e');
  }
}
