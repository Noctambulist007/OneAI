import 'package:flutter/material.dart';
import 'features/splash/screen/splash_screen.dart';

class DashScan extends StatelessWidget {
  const DashScan({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
