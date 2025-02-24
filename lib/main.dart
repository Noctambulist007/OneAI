import 'package:flutter/services.dart';
import 'package:motion/motion.dart';
import 'package:one_ai/features/auth/provider/auth_provider.dart';
import 'package:one_ai/features/image_ai/provider/image_ai_provider.dart';
import 'package:one_ai/features/push_notification/services/firebase_api.dart';
import 'package:one_ai/features/walkthrough/provider/onboarding/onboarding_provider.dart';
import 'package:one_ai/one_ai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/subscription/provider/subscription_provider.dart';
import 'firebase_options.dart';
import 'features/text_ai/provider/language_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'features/home/provider/home_provider.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      print('Error loading .env file: $e');
    }

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseApi().initNotifications();

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
          ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
          ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
          ChangeNotifierProvider(create: (_) => ImageAiProvider()),
          ChangeNotifierProvider(create: (_) => LanguageProvider()),
          ChangeNotifierProvider(
            create: (context) => HomeProvider(
              vsync: NavigatorState(),
            ),
          ),
        ],
        child: const OneAI(),
      ),
    );
  } catch (e) {
    print('Error initializing app: $e');
  }
}
