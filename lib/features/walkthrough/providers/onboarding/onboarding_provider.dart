import 'package:flutter/material.dart';
import 'package:dashscan/features/navigation/screens/navigation_menu.dart';

class OnBoardingProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  void updatePageIndicator(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  void dotNavigationClick(int index) {
    _currentPageIndex = index;
    pageController.jumpTo(index.toDouble());
    notifyListeners();
  }

  void nextPage(BuildContext context) {
    if (_currentPageIndex == 2) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const NavigationMenu(),
      ));
    } else {
      _currentPageIndex++;
      pageController.jumpToPage(_currentPageIndex);
      notifyListeners();
    }
  }

  void skipPage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const NavigationMenu(),
    ));
  }

  static OnBoardingProvider get instance => _instance!;
  static OnBoardingProvider? _instance;

  OnBoardingProvider._internal() {
    _instance = this;
  }

  factory OnBoardingProvider() {
    return _instance ?? OnBoardingProvider._internal();
  }
}
