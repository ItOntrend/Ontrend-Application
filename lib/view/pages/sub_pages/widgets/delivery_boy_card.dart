import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';

class DeliveryBoyCard extends StatelessWidget {
  const DeliveryBoyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(bottom: 9, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kLiteBackground,
      ),
      height: 81.h,
      child: Row(
        children: [
          Image.asset(
            "assets/image/delivery_boy_image.png",
            height: 74.h,
            width: 92.w,
          ),
          kWidth15,
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Mohammed",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "is your delivery hero for\ntoday.",
                style: TextStyle(
                  fontSize: 10,
                  color: kTextStyleGrey,
                ),
              ),
            ],
          ),
          kWidth16,
          Container(
            height: 32.h,
            width: 32.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: kGrey,
              ),
            ),
            child: Image.asset(
              "assets/icons/message_icon_image.png",
              height: 21.h,
              width: 21.w,
            ),
          ),
          kWidth16,
          Container(
            height: 32.h,
            width: 32.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: kGrey,
              ),
            ),
            child: Image.asset(
              "assets/icons/call_icon_image.png",
              height: 19.h,
              width: 19.w,
            ),
          ),
        ],
      ),
    );
  }
}
