import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/e_store_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/food_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/home_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/user_profile_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavigationController extends GetxController {
  // final Rx<int>selectedIndex = 0.obs;
  Rx<PersistentTabController> tabController = PersistentTabController(initialIndex: 0).obs;

  List<Widget> buildScreens() {
    return [
      const HomePage(),
      const FoodPage(),
      const EStorePage(),
       UserProfilePage(),
    ];
  }
  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/icons/home_icon.png"),
        title: ("Home"),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/icons/food_icon.png"),
        title: ("Food"),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/icons/store_icon.png"),
        title: ("E-Store"),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/icons/user_icon.png"),
        title: ("Profile"),
        
      ),
    ];
  }
   void changeTabIndex(int index) {
    tabController.value.jumpToTab(index);
  }
}

//   final screens = [
//     const HomePage(),
//     const FoodPage(),
//     const EStorePage(),
//     const UserProfilePage(),
//   ];
// }