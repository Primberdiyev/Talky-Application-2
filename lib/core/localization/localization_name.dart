import 'package:flutter/material.dart';

enum LocalizationName {
  ru(Locale('ru')),
  en(Locale('en'));

  const LocalizationName(this.locale);
  final Locale locale;
}
