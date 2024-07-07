import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  // Vendor? data;
  // Future<void> getVendorNameDetails() async {
  //   data = await _vendorController.getVendorByUId(userId: widget.userId);
  // }

  @override
  void initState() {
    super.initState();
    log("This is UserID ${widget.userId}");
    _vendorController.getVendorByUId(userId: widget.userId);
    // _vendorController.getItems(widget.userId);
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
        log("It's About Ventor Profile");
        if (_vendorController.isVendorLoading.value ||
            _vendorController.isItemsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_vendorController.vendorDetail.value == null) {
          return const Center(
            child: Text("Vendor not found"),
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
                    child: Image.network(
                      _vendorController.vendorDetail.value?.image ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                kWidth20,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // data!.restaurantName,
                      _vendorController.vendorDetail.value?.restaurantName ??
                          "Not found",
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Pizza, Pastas, Desserts",
                      style: TextStyle(fontSize: 14, color: kGrey),
                    ),
                  ],
                )
              ],
            ),
            kHiegth10,
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Delivery fee",
                      style: TextStyle(
                        fontSize: 14,
                        color: kGrey,
                      ),
                    ),
                    Text(
                      "OMR 0.380",
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
                      "Delivery time",
                      style: TextStyle(
                        fontSize: 14,
                        color: kGrey,
                      ),
                    ),
                    Text(
                      "18 min",
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
                      "Delivery by",
                      style: TextStyle(
                        fontSize: 14,
                        color: kGrey,
                      ),
                    ),
                    Text(
                      "Roofaas",
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
