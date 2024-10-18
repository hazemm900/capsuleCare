import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');

    // Check if a language is saved in SharedPreferences
    if (languageCode != null) {
      _locale = Locale(languageCode);
    } else {
      // If no language is saved, use the device's locale
      final systemLocale = ui.window.locale;
      _locale = Locale(systemLocale.languageCode);
    }

    notifyListeners();
  }

  void setLocale(Locale locale) async {
    _locale = locale;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    notifyListeners();
  }

  void clearLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('languageCode');
    _locale = null;
    notifyListeners();
  }
}
