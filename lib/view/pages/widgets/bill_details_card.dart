import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/order_complete_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/payment_option_page.dart';

class BillDetailsCard extends StatelessWidget {
  const BillDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Item Total",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "OMR 349",
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
                    "assets/image/visa_image.png",
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
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
          kHiegth10,
          GestureDetector(
            onTap: () {
              Get.to(OrderCompletePage());
            },
            child: Container(
              height: 48.h,
              width: 308.w,
              decoration: BoxDecoration(
                color: kOrange,
                borderRadius: BorderRadius.circular(
                  50,
                ),
              ),
              child: const Center(
                child: Text(
                  "Pay 397",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
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
