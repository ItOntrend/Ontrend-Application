import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/order_complete_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/payment_option_page.dart';

class BillDetailsCard extends StatelessWidget {
  const BillDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    
    return Container(
      // margin: const EdgeInsets.symmetric(
      //   horizontal: 24,
      //   vertical: 10,
      // ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      height: 230.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        color: kLiteBackground,
        border: Border.all(
          color: kGrey,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Item Total",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "OMR ${cartController.itemTotal.value}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          kHiegth10,
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Partner fee",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "OMR 25",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          kHiegth10,
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Platform fee",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "OMR 15",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
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
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    border: Border.all(
                      color: kGrey,
                    ),
                  ),
                  child: Image.asset(
                    "assets/icons/cash_on_delivery.png",
                  ),
                ),
                const Spacer(),
                const Text(
                  "Change",
                  style: TextStyle(
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
                    border: Border.all(
                      color: kOrange,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
          kHiegth10,
          GestureDetector(
            onTap: ()async {
              String userId =
          await LocalStorage.instance.DataFromPrefs(key: HiveKeys.userData);
              if (cartController.totalAmount > 0) {
                cartController.placeOrder(userId, 'Cash on Delivery', 'Some Restaurant');
              }
              if (cartController.totalAmount > 0) {
                Get.to(OrderCompletePage());
              }
            },
            child: Obx(
              () => Container(
                height: 48.h,
                width: 308.w,
                decoration: BoxDecoration(
                  color: kOrange,
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Pay ${cartController.totalAmount > 0 ? cartController.totalAmount : 0}",
                    style: const TextStyle(
                      color: kWhite,
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          kHiegth6,
        ],
      ),
    );
  }
}
