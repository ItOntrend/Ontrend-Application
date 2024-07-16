import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/best_seller_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/location_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/navigation_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/groceries_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/notification_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/profile_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/select_location_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/carousal_slider.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/best_seller_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/oru_service_big_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/oru_service_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
import 'package:persistent_bottom_nav_bar_plus/persistent_bottom_nav_bar_plus.dart';

class HomePage extends StatefulWidget {
  final NavigationController? controller;

  HomePage({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BestSellerController bestSellerController =
      Get.put(BestSellerController());
  final userController = Get.find<UserController>();
  final LocationController locationController = Get.put(LocationController());
  final CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bestSellerController.getBestSeller();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            Get.to(() => const SelectLocationPage());
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset("assets/icons/location_icon.png"),
          ),
        ),
        title: Obx(() {
          if (locationController.isLoading.value) {
            return const CircularProgressIndicator();
          } else {
            return GestureDetector(
              onTap: () {
                Get.to(() => const SelectLocationPage());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locationController.streetName.value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        locationController.countryName.value,
                        style: const TextStyle(
                          color: kBlue,
                          fontSize: 10,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        }),
        actions: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const NotificationPage());
                    },
                    child: Image.asset("assets/icons/notification_icon.png"),
                  ),
                  kWidth25,
                  Badge.count(
                    count: cartController.getItemCount(),
                    backgroundColor: kDarkOrange,
                    textColor: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const AddToCartPage(
                          addedBy: "",
                          restaurantName: "",
                        ));
                      },
                      child: Image.asset("assets/icons/cart_icon.png"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextfieldWithMic(
                hintText: "Biryani, Burger, Ice Cream...".tr,
                onTap: () {
                  Get.to(() => SearchPage());
                },
              ),
              SizedBox(height: 15),
              SPromoSliderWidget(),
              SizedBox(height: 25),
              OneTextHeading(
                heading: "Our Services".tr,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.find<NavigationController>().changeTabIndex(2);
                },
                child: OruServiceBigCard(
                  image: "assets/image/home_appliance_image.png",
                  name: "E-Store".tr,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: GroceriesPage(),
                        withNavBar: true,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: OurServiceCard(
                      name: 'Groceries'.tr,
                      image: "assets/image/grocerry_image.png",
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Get.find<NavigationController>().changeTabIndex(1);
                    },
                    child: OurServiceCard(
                      name: 'Food'.tr,
                      image: "assets/image/service_food_image.png",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              OneTextHeading(
                heading: "Best Sellers".tr,
              ),
              SizedBox(height: 20),
              Obx(
                () => bestSellerController.isBestSellerLoading.value
                    ? CircularProgressIndicator()
                    : SizedBox(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: bestSellerController.bestSellerList.length,
                          itemBuilder: (context, index) {
                            log("Best Sellers");
                            final bestSeller =
                                bestSellerController.bestSellerList[index];
                            return BestSellerCard(
                              onTap: () {
                                Get.to(
                                  () => ProfilePage(
                                    userId: bestSeller.addedBy,
                                    cat: "Best Seller",
                                    type: "Food",
                                  ),
                                );
                              },
                              name: bestSeller.name,
                              imagePath: bestSeller.image,
                              price: bestSeller.price,
                              vendor: bestSeller.restaurantName,
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
