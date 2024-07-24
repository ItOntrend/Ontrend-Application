import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/location_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/order_complete_splash_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/payment_option_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton.dart';

class BillDetailsCard extends StatefulWidget {
  const BillDetailsCard({
    super.key,
    required this.addedBy,
    required this.restaurantName,
  });

  final String addedBy;
  final String restaurantName;

  @override
  State<BillDetailsCard> createState() => _BillDetailsCardState();
}

class _BillDetailsCardState extends State<BillDetailsCard> {
  final CartController cartController = Get.find();
  final UserController userController = Get.find();
  final LocationController locationController = Get.find();

  @override
  void initState() {
    userController.fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16)
          .copyWith(bottom: 8, top: 16),
      height: 290.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHiegth6,
            BillDetailsRow(
              title: 'Item total'.tr,
              amount: cartController.itemTotal.value,
            ),
            kHiegth6,
            BillDetailsRow(
              title: 'Delivery fee'.tr,
              amount: cartController.deliveryFee.value,
            ),
            kHiegth6,
            BillDetailsRow(
              title: 'Service fee'.tr,
              amount: cartController.serviceFee.value,
            ),
            kHiegth6,
            BillDetailsRow(
              title: 'Total amount'.tr,
              amount: cartController.totalAmount,
              isBold: true,
            ),
            kHiegth10,
            GestureDetector(
              onTap: () {
                Get.to(
                  const PaymentOptionPage(),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 29.h,
                    width: 49.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kGrey),
                    ),
                    child: Image.asset(
                      "assets/icons/cash_on_delivery.png",
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Change".tr,
                    style: const TextStyle(
                      color: kGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  kWidth10,
                  Container(
                    height: 18.h,
                    width: 18.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kOrange),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    ),
                  ),
                ],
              ),
            ),
            kHiegth18,
            const Spacer(),
            MainBotton(
              onTap: () async {
                log("Place Order".tr);
                String userId = await LocalStorage.instance
                    .dataFromPrefs(key: HiveKeys.userData);

                // Validate if the location information is available
                if (locationController.currentAddress.value.isEmpty ||
                    locationController.streetName.value.isEmpty ||
                    locationController.cityName.value.isEmpty ||
                    locationController.countryName.value.isEmpty) {
                  Get.snackbar(
                    "Location Required".tr,
                    "You haven't selected your location".tr,
                    backgroundColor: kDarkOrange,
                    colorText: Colors.white,
                  );
                  return;
                }

                if (cartController.totalAmount > 0) {
                  String orderId = await cartController.placeOrder(
                    userId,
                    'Cash on Delivery',
                    userController.firstName.value,
                    userController.number.value,
                  );

                  Get.to(() => OrderCompleteSplashPage(orderId: orderId));
                  log("Order placed");
                }
              },
              name: "Place Order".tr,
            ),
          ],
        );
      }),
    );
  }
}

class BillDetailsRow extends StatelessWidget {
  const BillDetailsRow({
    super.key,
    required this.title,
    required this.amount,
    this.isBold = false,
  });

  final String title;
  final double amount;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        Text(
          '${"OMR".tr} ${amount.toStringAsFixed(3)}',
          style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
