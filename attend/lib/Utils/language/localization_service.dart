import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_us.dart';


class LocalizationService extends Translations {
  static const locale = Locale('en', 'US');

  static const fallbackLocale = Locale('ta', 'IN');

  static Locale get currentLocale {
    switch ("langCode") {
      case 'ta':
        return const Locale('ta', 'IN');
      case 'ar':
        return const Locale('ar', 'AR');
    }
    return const Locale('en', 'US');
  }

  // Supported Languages
  static const langs = [
    'English',
    'தமிழ்',
    'عربى',
  ];

  // Supported Locales
  static const locales = [
    Locale('en', 'US'),
    Locale('ta', 'IN'),
    Locale('ar', 'AR'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS,
    'ta_IN': enUS,
    'ar_AR': enUS,
  };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }
}
