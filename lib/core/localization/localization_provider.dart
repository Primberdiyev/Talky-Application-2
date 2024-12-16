import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/localization/localization_name.dart';

class LocalizationProvider with ChangeNotifier {
  Locale _currentLocale = LocalizationName.en.locale;
  Locale get currentLocale => _currentLocale;

  void setLocale() {
    _currentLocale = _currentLocale == LocalizationName.en.locale
        ? LocalizationName.ru.locale
        : LocalizationName.en.locale;
    notifyListeners();
  }
}
