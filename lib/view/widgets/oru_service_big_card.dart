import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';

class OruServiceBigCard extends StatelessWidget {
  const OruServiceBigCard({
    super.key,
    required this.name,
    required this.image,
  });

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    final LanguageController lang = Get.put(LanguageController());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        border: Border.all(color: kGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            image,
            height: 123.h,
            width: 201.w,
          ),
          kWidth10,
          Text(
            textAlign: TextAlign.center,
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          kHiegth10,
          Container(
            height: 20.h,
            width: 140.w,
            decoration: BoxDecoration(
              color: kBlue,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.percent_outlined,
                  size: 14,
                  color: kRed,
                ),
                kWidth10,
                Text(
                  lang.currentLanguage.value.languageCode == "ar"
                      ? "تخفيض يصل إلى ٤٠٪"
                      : "Up to 40% Off",
                  style: TextStyle(
                    fontSize: 10,
                    color: kWhite,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
