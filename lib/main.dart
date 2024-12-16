import 'package:scannify/features/generate/providers/auth_provider.dart';
import 'package:scannify/features/scanai/providers/scan_ai_provider.dart';
import 'package:scannify/scannify.dart';
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
      options: FirebaseOptions(
        apiKey: 'AIzaSyBPYxs3shA7QsGR8Yv_a0zEUd3K3AskiB0',
        appId: '1:480769648249:android:d428332db33ba2d787d6a8',
        messagingSenderId: '480769648249',
        projectId: 'scannify-3ddee',
        storageBucket: 'scannify-3ddee.appspot.com',

      ),
    );
    await FirebaseApi().initNotifications();
    await ScannedQRDatabaseProvider.instance.initialize();

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => OnBoardingProvider()),
          ChangeNotifierProvider(create: (context) => ScanProvider()),
          ChangeNotifierProvider(create: (context) => ScannedHistoryState()),
          ChangeNotifierProvider(create: (context) => HistoryState()),
          ChangeNotifierProvider(create: (context) => ScanAIProvider()),
        ],
        child: const Scannify(),
      ),
    );
  } catch (e) {
    print('Error initializing app: $e');
  }
}
