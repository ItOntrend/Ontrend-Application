import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/e_store_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/estore/estore_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/food_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/home_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/user_profile_page.dart';
import 'package:persistent_bottom_nav_bar_plus/persistent_bottom_nav_bar_plus.dart';

class NavigationController extends GetxController {
  // final Rx<int>selectedIndex = 0.obs;
  Rx<PersistentTabController> tabController =
      PersistentTabController(initialIndex: 0).obs;

  List<Widget> buildScreens() {
    return [
      HomePage(),
      const FoodPage(),
      const EstorePage(),
      UserProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/icons/home_icon.png"),
        title: ("Home".tr),
        activeColorPrimary: kDarkOrange,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/icons/food_icon.png"),
        title: ("Food".tr),
        activeColorPrimary: kDarkOrange,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/icons/store_icon.png"),
        title: ("E-Store".tr),
        activeColorPrimary: kDarkOrange,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/icons/user_icon.png"),
        title: ("Profile".tr),
        activeColorPrimary: kDarkOrange,
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