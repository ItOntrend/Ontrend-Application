import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/constant.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 296.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: kGrey,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(1, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Positioned.fill(
            child: Image.asset(
              image,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Domino's Pizza",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      height: 30.h,
                      width: 64.w,
                      decoration: BoxDecoration(
                        color: kGreen,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "4.2",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kWhite,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            size: 20,
                            color: kWhite,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                kHiegth10,
                Row(
                  children: [
                    const Text(
                      "Pizza, Pastas, Desserts",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    const Text("Salah"),
                    kWidth6,
                    Image.asset("assets/image/small_location_image.png")
                  ],
                ),
                kHiegth6,
                const Text(
                  "6.8 km",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
