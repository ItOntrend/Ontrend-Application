import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/food_item_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/profile_card.dart';
import 'item_view_page.dart'; // Import the ItemViewPage

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
  final CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    vendorController.getItems(widget.userId);
    print("profile......................................${widget.userId}");
    vendorController.getVendors(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Obx(
                () => SizedBox(
                  height: 200.h,
                  width: double.infinity,
                  child: Image.network(
                    vendorController.vendorDetail.value?.bannerImage ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Display a placeholder or error message on error
                      return Image.network(
                        'https://service.sarawak.gov.my/web/web/web/web/res/no_image.png', // Replace with your asset path
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
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
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 30,
                right: 30,
                child: Center(
                  child: ProfileCard(
                    userId: widget.userId,
                  ),
                ),
              ),
              kHiegth20,
              Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Column(
                  children: [
                    Text(
                      "Best Sellers".tr,
                      style: const TextStyle(
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
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: vendorController.itemsList.length,
                          itemBuilder: (context, index) {
                            final item = vendorController.itemsList[index];
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => ItemViewPage(
                                    item:
                                        item)); // Navigate to ItemViewPage with item data
                              },
                              child: FoodItemCard(
                                name: item.name,
                                image: item.imageUrl,
                                description: item.description,
                                price: item.price,
                                addedBy: item.addedBy,
                                restaurantName: item.restaurantName,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    kHiegth25,
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() {
          return BottomAppBar(
            color: kTransparent,
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: kGreen),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Items in Cart: ${cartController.getItemCount()}',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: kWhite),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => const AddToCartPage(
                            addedBy: '',
                            restaurantName: '',
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: kGreen,
                      backgroundColor: kWhite,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                    ),
                    child: const Text(
                      'View Cart',
                      style: TextStyle(
                        color: kOrange,
                        decoration: TextDecoration.underline,
                        decorationColor: kOrange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
