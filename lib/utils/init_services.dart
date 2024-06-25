import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/auth_controller.dart';

Future<void> initServices ()async{
  Get.put<AuthController> (AuthController());
}