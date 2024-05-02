import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:dashscan/features/scan/providers/scan_provider.dart';
import 'package:dashscan/features/scan/screens/scan_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScanProvider(),
      child: const ScanScreenContent(),
    );
  }
}
