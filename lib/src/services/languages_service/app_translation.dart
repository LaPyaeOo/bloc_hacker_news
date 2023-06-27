//Step 1
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Step 2
class AppTranslation {
  //Step 3
  late final Locale _locale;

  AppTranslation(this._locale);

//Step 4
  static AppTranslation of(BuildContext context) {
    return Localizations.of<AppTranslation>(context, AppTranslation)!;
  }

//Step 5
  late Map<String, String> _localizedValues;

  Future loadLanguage() async {
    String jsonStringValues =
        await rootBundle.loadString("assets/lang/${_locale.languageCode}.json");
    Map<String, dynamic> mappedValues = json.decode(jsonStringValues);

    _localizedValues =
        mappedValues.map((key, value) => MapEntry(key, value.toString()));
  }

//Step 6
  String? getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<AppTranslation> delegate =
      _AppTranslationDelegate();
}

//Step 7

class _AppTranslationDelegate extends LocalizationsDelegate<AppTranslation> {
  const _AppTranslationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "my"].contains(locale.languageCode);
  }

  @override
  Future<AppTranslation> load(Locale locale) async {
    AppTranslation appLocalization = AppTranslation(locale);
    await appLocalization.loadLanguage();
    return appLocalization;
  }

  @override
  bool shouldReload(_AppTranslationDelegate old) => false;
}
