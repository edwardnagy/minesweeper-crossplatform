import 'dart:ui';

import 'package:flutter/foundation.dart';

class AppLocalizationProvider with ChangeNotifier {
  static AppLocalizationProvider? _instance;

  static AppLocalizationProvider get instance => _instance ??= AppLocalizationProvider();

  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
