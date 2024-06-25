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
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}






 //  List<Widget> _buildScreens() {
    //   return [
    //     HomePage(controller: controller),
    //     const FoodPage(),
    //     const EStorePage(),
    //     const UserProfilePage(),
    //   ];
    // }

    // List<PersistentBottomNavBarItem> _navBarsItems() {
    //   return [
    //     PersistentBottomNavBarItem(
    //       icon: Image.asset("assets/icons/home_icon.png"),
    //       title: "Home",
    //       activeColorPrimary: Colors.blue,
    //       inactiveColorPrimary: Colors.grey,
    //     ),
    //     PersistentBottomNavBarItem(
    //       icon: Image.asset("assets/icons/food_icon.png"),
    //       title: "Food",
    //       activeColorPrimary: Colors.blue,
    //       inactiveColorPrimary: Colors.grey,
    //     ),
    //     PersistentBottomNavBarItem(
    //       icon: Image.asset("assets/icons/store_icon.png"),
    //       title: "E Store",
    //       activeColorPrimary: Colors.blue,
    //       inactiveColorPrimary: Colors.grey,
    //     ),
    //     PersistentBottomNavBarItem(
    //       icon: Image.asset("assets/icons/user_icon.png"),
    //       title: "Profile",
    //       activeColorPrimary: Colors.blue,
    //       inactiveColorPrimary: Colors.grey,
    //     ),
    //   ];
    // }

    // return PersistentTabView(
    //   context,
    //   controller: controller.persistentTabController,
    //   screens: _buildScreens(),
    //   items: _navBarsItems(),
    //   confineInSafeArea: true,
    //   backgroundColor: kWhite,
    //   handleAndroidBackButtonPress: true,
    //   resizeToAvoidBottomInset: true,
    //   stateManagement: true,
    //   hideNavigationBarWhenKeyboardShows: true,
    //   decoration: NavBarDecoration(
    //     borderRadius: BorderRadius.circular(10.0),
    //     colorBehindNavBar: Colors.white,
    //   ),
    //   popAllScreensOnTapOfSelectedTab: true,
    //   popActionScreens: PopActionScreensType.all,
    //   itemAnimationProperties: ItemAnimationProperties(
    //     duration: const Duration(milliseconds: 200),
    //     curve: Curves.ease,
    //   ),
    //   screenTransitionAnimation: ScreenTransitionAnimation(
    //     animateTabTransition: true,
    //     curve: Curves.ease,
    //     duration: const Duration(milliseconds: 200),
    //   ),
    //   navBarStyle: NavBarStyle.style1,
    // ); 
    // 
    // 