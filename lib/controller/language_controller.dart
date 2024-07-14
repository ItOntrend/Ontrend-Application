import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ontrend_food_and_e_commerce/controller/grocery_controller.dart';

class LanguageController extends GetxController {
  var currentLanguage = 'en'.obs;

  void changeLanguage(String languageCode) {
    currentLanguage.value = languageCode;
    updateAllControllers();
    // Trigger translation logic for all controllers if needed
  }

  void updateAllControllers() {
    // Notify all controllers to update their data based on the new language
    Get.find<GroceryController>().translateCategories();
  }
}
