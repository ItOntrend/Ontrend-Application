import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  Rx<Locale> currentLanguage = Locale('en', 'US').obs;
  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
  }

  void changeLanguage(Locale locale) async {
    currentLanguage.value = locale;
    Get.updateLocale(locale);
    await _saveLanguage(locale);
  }

  Future<void> _saveLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'en';
    currentLanguage.value = Locale(languageCode);
    Get.updateLocale(currentLanguage.value);
  }
}
