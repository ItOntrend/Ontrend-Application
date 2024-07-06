import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
// import 'package:ontrend_food_and_e_commerce/model/vendor_model.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/food_item_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/profile_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    this.initialTabIndex = 0,
    required this.userId,
  });
  final int initialTabIndex;
  final String userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final VendorController vendorController = Get.put(VendorController());

  @override
  void initState() {
    super.initState();
    // getVendorNameDetails();
    log(widget.userId);
    // vendorController.getVendorByUId(userId: widget.userId);
    vendorController.getItems(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: 200.h,
                width: 430.w,
                child: Image.asset("assets/image/account_banner.png"),
              ),
              Positioned(
                left: 12,
                top: 20,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 38.h,
                    width: 38.w,
                    decoration: const BoxDecoration(
                      color: kWhite,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   left: 50,
              //   child: Image.asset("assets/image/big_pizza.png"),
              // ),
              Positioned(
                top: 100,
                left: 30,
                child: Center(
                  child: ProfileCard(userId: widget.userId),
                ),
              ),
              kHiegth20,
              Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Column(
                  children: [
                    const Text(
                      "Bestseller",
                      style: TextStyle(
                        color: kOrange,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    kHiegth25,
                    Obx(
                      () {
                        if (vendorController.isItemsLoading.value) {
                          log("Loading items...");
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          if (vendorController.itemsList.isEmpty) {
                            return const Center(child: Text("No items found"));
                          }
                        }
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: vendorController.itemsList.length,
                          itemBuilder: (context, index) {
                            final item = vendorController.itemsList[index];
                            return FoodItemCard(
                              name: item.name,
                              image: item.imageUrl,
                              description: item.description,
                              price: item.price,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









// Obx(
                    //   () {
                    //     if (vendorController.isItemsLoading.value) {
                    //       log("Loading items...");
                    //       return const Center(child: CircularProgressIndicator());
                    //     } else {
                    //       if (vendorController.itemsList.isEmpty) {
                    //         return const Center(child: Text("No items found"));
                    //       }
                    //       return SizedBox(
                    //         height: 400,
                    //         child: ListView.builder(
                    //           shrinkWrap: true,
                    //           scrollDirection: Axis.horizontal,
                    //           itemCount: vendorController.itemsList.length,
                    //           itemBuilder: (context, index) {
                    //             final item = vendorController.itemsList[index];
                    //             return FoodItemCard(
                    //               name: item.name,
                    //               image: item.imageUrl,
                    //               description: item.description,
                    //               price: item.price,
                    //             );
                    //           },
                    //         ),
                    //       );
                    //     }
                    //   },
                    // ),