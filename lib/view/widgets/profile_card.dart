import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/shimmer_skelton.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/vendor_info.dart';

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
      _vendorController.vendorDetail.value = null; // Clear previous vendor data
      _vendorController.isVendorLoading.value = true;
      _vendorController.getVendorByUId(userId: widget.userId);
    });
    print("vendor is ${widget.userId}");
  }

  double _estimateDeliveryTime(double distance) {
    // Assume an average speed of 40 km/h
    const double averageSpeed = 40;
    final double time = (distance / averageSpeed) * 60; // time in minutes
    return time;
  }

  @override
  Widget build(BuildContext context) {
    final v = _vendorController.vendorDetail.value;
    final dis = _vendorController.calculateDistance(v!.location);
    double estimatedTime = _estimateDeliveryTime(dis);
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 152.h,
      width: 340.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kWhite,
      ),
      child: Obx(() {
        log("It's About Vendor Profile");
        if (_vendorController.isVendorLoading.value) {
          return const ShimmerProfile();
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
                            ? CachedNetworkImage(
                                imageUrl: _vendorController.vendorDetail.value!
                                    .image, // Use ! for non-null access
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    'https://service.sarawak.gov.my/web/web/web/web/res/no_image.png', // Replace with your asset path
                                fit: BoxFit.cover,
                              ),
                  ),
                ),
                kWidth20,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 155.w,
                      child: Text(
                        // _vendorController.vendorDetail.value?.restaurantName ??
                        //   "Not found",   // Check the selected language
                        lang.currentLanguage.value.languageCode == 'ar'
                            ? _vendorController
                                .vendorDetail.value!.restaurantArabicName
                            : _vendorController
                                .vendorDetail.value!.restaurantName,

                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () {
                    Get.to(() => VendorInfoPage(
                        vendor: _vendorController.vendorDetail.value));
                  },
                ),
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
                      style: const TextStyle(
                        fontSize: 12,
                        color: kGrey,
                      ),
                    ),
                    Text(
                      _vendorController.deliveryFee.value.toStringAsFixed(3),
                      style: const TextStyle(
                        fontSize: 12,
                        color: kBlack,
                      ),
                    ),
                  ],
                ),
                const VerticalDivider(
                  thickness: 10,
                  color: kBlue,
                ),
                Column(
                  children: [
                    Text(
                      "Delivery time".tr,
                      style: const TextStyle(
                        fontSize: 12,
                        color: kGrey,
                      ),
                    ),
                    Text(
                      "${estimatedTime.toStringAsFixed(0)} ${"min".tr}".tr,
                      style: const TextStyle(
                        fontSize: 12,
                        color: kBlack,
                      ),
                    ),
                  ],
                ),
                const VerticalDivider(
                  thickness: 10,
                  color: kBlack,
                ),
                Column(
                  children: [
                    Text(
                      "Delivery by".tr,
                      style: const TextStyle(
                        fontSize: 12,
                        color: kGrey,
                      ),
                    ),
                    Text(
                      "OnTrend".tr,
                      style: const TextStyle(
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

class ShimmerProfile extends StatelessWidget {
  const ShimmerProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Column(
            children: [
              Skelton(
                height: 55.h,
                width: 84.w,
              ),
              kHiegth6,
              Skelton(
                width: 84.w,
                height: 15.h,
              ),
              kHiegth2,
              Skelton(
                width: 40.w,
                height: 15.h,
              )
            ],
          ),
          kWidth10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Skelton(
                width: 70.w,
                height: 25.h,
              ),
              kHiegth10,
              Skelton(
                width: 100.w,
                height: 15.h,
              ),
              kHiegth13,
              Row(
                children: [
                  Column(
                    children: [
                      Skelton(
                        width: 84.w,
                        height: 15.h,
                      ),
                      kHiegth2,
                      Skelton(
                        width: 40.w,
                        height: 15.h,
                      )
                    ],
                  ),
                  kWidth10,
                  Column(
                    children: [
                      Skelton(
                        width: 84.w,
                        height: 15.h,
                      ),
                      kHiegth2,
                      Skelton(
                        width: 40.w,
                        height: 15.h,
                      )
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
