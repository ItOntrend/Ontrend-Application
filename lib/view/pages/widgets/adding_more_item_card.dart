import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';

class AddingMoreItemCard extends StatelessWidget {
  const AddingMoreItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ).copyWith(
          left: 9,
          right: 17,
        ),
        height: 91.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: Border.all(
            color: kGrey.shade400,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add more items",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  height: 19.h,
                  width: 19.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kWhite,
                    border: Border.all(
                      color: kGreen,
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 12,
                    color: kBlack,
                  ),
                ),
              ],
            ),
            kHiegth9,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add cooking requests",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  height: 19.h,
                  width: 19.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kWhite,
                    border: Border.all(
                      color: kGreen,
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 12,
                    color: kBlack,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
