import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/constant.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.image,
  });

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 107.h,
      decoration: BoxDecoration(
        color: Colors.white, // Adjust background color as needed
        border: Border.all(color: kGrey),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Add a subtle shadow
            spreadRadius: 2.0, // Adjust shadow spread
            blurRadius: 5.0, // Adjust shadow blur
            offset: const Offset(1.0, 2.0), // Shadow offset
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(image),
              kWidth20,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const Text(
                    "Your order is confirmed with\n order number # 35345678990...",
                    maxLines: 3, // Limit text lines for better display
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Today, 06:30 pm",
                        style: TextStyle(
                          color: kBlue,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
