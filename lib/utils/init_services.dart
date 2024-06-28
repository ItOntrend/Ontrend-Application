import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/auth_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/food_controller.dart';

Future<void> initServices() async {
  Get.put<AuthController>(AuthController());
  Get.put<FoodController>(FoodController());
}
