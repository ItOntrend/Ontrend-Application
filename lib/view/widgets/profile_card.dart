import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    super.key,
    required this.userId,
  });
  final String userId;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final VendorController _vendorController = Get.put(VendorController());
  final LanguageController lang = Get.find();
  @override
  void initState() {
    super.initState();
    log("This is UserID ${widget.userId}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vendorController.getVendorByUId(userId: widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 152.h,
      width: 340.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Obx(() {
        log("It's About Vendor Profile");
        if (_vendorController.isVendorLoading.value ||
            _vendorController.isItemsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_vendorController.vendorDetail.value == null) {
          return Center(
            child: Text("Vendor not found".tr),
          );
        }
        return Column(
          children: [
            Row(
              children: [
                Container(
                  height: 65.h,
                  width: 84.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:
                        _vendorController.vendorDetail.value?.image != null &&
                                _vendorController.vendorDetail.value!.image
                                    .startsWith('http')
                            ? Image.network(
                                _vendorController.vendorDetail.value!
                                    .image, // Use ! for non-null access
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                'https://service.sarawak.gov.my/web/web/web/web/res/no_image.png', // Replace with your asset path
                                fit: BoxFit.cover,
                              ),
                  ),
                ),
                kWidth20,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _vendorController.vendorDetail.value?.restaurantName ??
                          "Not found",
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Pizza, Pastas, Desserts".tr,
                      style: TextStyle(fontSize: 14, color: kGrey),
                    ),
                  ],
                )
              ],
            ),
            kHiegth10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Delivery fee".tr,
                      style: TextStyle(
                        fontSize: 12,
                        color: kGrey,
                      ),
                    ),
                    Text(
                      "${_vendorController.deliveryFee}",
                      style: TextStyle(
                        fontSize: 12,
                        color: kBlack,
                      ),
                    ),
                  ],
                ),
                VerticalDivider(
                  thickness: 10,
                  color: kBlue,
                ),
                Column(
                  children: [
                    Text(
                      "Delivery time".tr,
                      style: TextStyle(
                        fontSize: 12,
                        color: kGrey,
                      ),
                    ),
                    Text(
                      "18 min".tr,
                      style: TextStyle(
                        fontSize: 12,
                        color: kBlack,
                      ),
                    ),
                  ],
                ),
                VerticalDivider(
                  thickness: 10,
                  color: kBlack,
                ),
                Column(
                  children: [
                    Text(
                      "Delivery by".tr,
                      style: TextStyle(
                        fontSize: 12,
                        color: kGrey,
                      ),
                    ),
                    Text(
                      "OnTrend".tr,
                      style: TextStyle(
                        fontSize: 12,
                        color: kOrange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
