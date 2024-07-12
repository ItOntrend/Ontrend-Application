import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/navigation_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavigationManu extends StatefulWidget {
  const NavigationManu({super.key});

  @override
  State<NavigationManu> createState() => _NavigationManuState();
}

class _NavigationManuState extends State<NavigationManu> {
  // Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      await Permission.location.request();
    }

    if (await Permission.location.isGranted) {
      _getCurrentLocation();
    } else {
      // Handle the case when the user denies the permission
      // You can show a dialog or redirect to another page
    }
  }

  Future<void> _getCurrentLocation() async {
    // _currentPosition = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Obx(() {
      return PersistentTabView(
        context,
        controller: controller.tabController.value,
        screens: controller.buildScreens(""),
        items: controller.navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style13,
      );
    });
  }
}

 
    // 
    // 
    // Scaffold(
    //   bottomNavigationBar: Obx(
    //     () => NavigationBar(
    //       animationDuration: const Duration(milliseconds: 1000),
    //       elevation: 0,
    //       height: 80,
    //       selectedIndex: controller.selectedIndex.value,
    //       onDestinationSelected: (index) =>
    //           controller.selectedIndex.value = index,
    //       backgroundColor: kWhite,
    //       // indicatorColor: kBlack,
    //       destinations: [
    //         NavigationDestination(
    //           icon: Image.asset("assets/icons/home_icon.png"),
    //           label: "Home",
    //         ),
    //         NavigationDestination(
    //           icon: Image.asset("assets/icons/food_icon.png"),
    //           label: "Food",
    //         ),
    //         NavigationDestination(
    //           icon: Image.asset("assets/icons/store_icon.png"),
    //           label: "E Store",
    //         ),
    //         NavigationDestination(
    //           icon: Image.asset("assets/icons/user_icon.png"),
    //           label: "Profile",
    //         ),
    //       ],
    //     ),
    //   ),
    //   body: Obx(() => controller.screens[controller.selectedIndex.value]),
    // )