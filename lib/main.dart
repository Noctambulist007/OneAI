import 'package:flutter/services.dart';
import 'package:motion/motion.dart';
import 'package:one_ai/features/generate/providers/auth_provider.dart';
import 'package:one_ai/features/scan_ai/providers/scan_ai_provider.dart';
import 'package:one_ai/one_ai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/repositories/db_history/scanned_qr_db/scanned_qr_database_provider.dart';
import 'features/history/providers/history_provider.dart';
import 'features/history/providers/scanned_history_provider.dart';
import 'features/push_notifications/services/firebase_api.dart';
import 'features/scan/providers/scan_provider.dart';
import 'features/walkthrough/providers/onboarding/onboarding_provider.dart';
import 'firebase_options.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseApi().initNotifications();
    await ScannedQRDatabaseProvider.instance.initialize();

    await Motion.instance.initialize();
    Motion.instance.setUpdateInterval(60.fps);

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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
        child: const OneAI(),
      ),
    );
  } catch (e) {
    print('Error initializing app: $e');
  }
}
