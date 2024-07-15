import 'dart:ui';

import 'package:get/get.dart';

class LanguageController extends GetxController {
  Rx<Locale> currentLanguage = Locale('en', 'US').obs;

  void changeLanguage(Locale locale) {
    currentLanguage.value = locale;
    Get.updateLocale(locale);
  }
}
