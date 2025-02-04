import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:one_ai/features/generate/screens/generate_screen.dart';
import 'package:one_ai/features/history/screens/history_screen.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  List<Widget> screens = const [
    GenerateScreen(),
    HistoryScreen(),
  ];

  List<IconData> icons = [
    Iconsax.edit,
    Icons.history,
  ];

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  NavigationProvider();
}
