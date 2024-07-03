import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/auth_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/best_seller_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/food_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';

Future<void> initServices() async {
  Get.put<AuthController>(AuthController());
  Get.put<BestSellerController>(BestSellerController());
  Get.put<FoodController>(FoodController());
  Get.put<UserController>(UserController());
  Get.put<VendorController>(VendorController());
}
