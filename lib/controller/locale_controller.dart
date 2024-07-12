import 'dart:ui';

import 'package:get/get.dart';

class LocalizationController extends GetxController {
  var translations = Map<String, String>().obs;
  var locale = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void updateLocale(String newLocale) {
    locale.value = newLocale;

    Get.updateLocale(Locale(newLocale));
  }
}
