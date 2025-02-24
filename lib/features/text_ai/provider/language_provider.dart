import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  String _currentLanguage = 'en';

  LanguageProvider() {
    _loadLanguage();
  }

  String get currentLanguage => _currentLanguage;

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString(_languageKey) ?? 'en';
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = _currentLanguage == 'en' ? 'bn' : 'en';
    await prefs.setString(_languageKey, _currentLanguage);
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = languageCode;
    await prefs.setString(_languageKey, languageCode);
    notifyListeners();
  }
}
