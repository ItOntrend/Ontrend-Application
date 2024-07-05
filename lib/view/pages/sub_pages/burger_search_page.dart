import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/profile_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';

class BurgerSearchPage extends StatefulWidget {
  const BurgerSearchPage({
    super.key,
    required this.userId,
  });
  final String userId;

  @override
  State<BurgerSearchPage> createState() => _BurgerSearchPageState();
}

class _BurgerSearchPageState extends State<BurgerSearchPage> {
  final VendorController vendorController = Get.put(VendorController());

  @override
  void initState() {
    super.initState();
    // vendorController.getVendors(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                const TextfieldWithMic(
                  hintText: "Burger...",
                ),
                kHiegth20,
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    const Text(
                      "Burger",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                kHiegth25,
                Obx(
                  () => vendorController.isVendorLoading.value
                      ? const CircularProgressIndicator()
                      : vendorController.vendorsList.isEmpty
                          ? const Center(child: Text("No Vendor Available"))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: vendorController.vendorsList.length,
                              itemBuilder: (context, index) {
                                final vendor =
                                    vendorController.vendorsList[index];
                                log("Vendor Images");
                                log(vendor.bannerImage.toString());
                                return ExploreCard(
                                  name: vendor.restaurantName,
                                  image: vendor.bannerImage,
                                  onTap: () {
                                    Get.to(ProfilePage(userId: widget.userId));
                                  },
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
