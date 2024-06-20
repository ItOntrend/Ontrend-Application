import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/navigation_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';

class NavigationManu extends StatelessWidget {
  const NavigationManu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      NavigationController(),
    );
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          animationDuration: const Duration(milliseconds: 1000),
          elevation: 0,
          height: 80,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: kWhite,
          // indicatorColor: kBlack,
          destinations: [
            NavigationDestination(
              icon: Image.asset("assets/icons/home_icon.png"),
              label: "Home",
            ),
            NavigationDestination(
              icon: Image.asset("assets/icons/food_icon.png"),
              label: "Food",
            ),
            NavigationDestination(
              icon: Image.asset("assets/icons/store_icon.png"),
              label: "E Store",
            ),
            NavigationDestination(
              icon: Image.asset("assets/icons/user_icon.png"),
              label: "Profile",
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value],),
    );
  }
}
