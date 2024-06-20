import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/e_store_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/food_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/home_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/user_profile_page.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomePage(),
    const FoodPage(),
    const EStorePage(),
    const UserProfilePage(),
  ];
}