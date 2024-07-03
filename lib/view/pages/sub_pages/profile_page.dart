import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/model/vendor_model.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/item_food_card.dart';
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
    // vendorController.getVendorByUId(widget.userId);
    vendorController.getItems(widget.userId);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset("assets/image/account_banner.png"),
                ),
                Positioned(
                  left: 12,
                  top: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 38,
                      width: 38,
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
                Positioned(
                  left: 50,
                  child: Image.asset("assets/image/big_pizza.png"),
                ),
                Positioned(
                  child: ProfileCard(
                    userId: widget.userId,
                  ),
                ),
              ],
            ),
            kHiegth20,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bestseller",
                  style: TextStyle(
                    color: kOrange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Obx(() {
              if (vendorController.isItemsLoading.value) {
                log("Loading items...");
                return const Center(child: CircularProgressIndicator());
              } else {
                if (vendorController.itemsList.isEmpty) {
                  return const Center(child: Text("No items found"));
                }
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
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
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
