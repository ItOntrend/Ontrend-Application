import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/constant.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard({
    super.key,
    required this.image,
    this.tabIndex,
    required this.onTap,
    required this.name,
    this.locatioCity,
  });

  final String name;
  final String? locatioCity;
  final String? image;
  final int? tabIndex;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        height: 286.h,
        width: 383.w,
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
            image != null && image!.isNotEmpty
                ? Image.network(
                    image!,
                    height: 163.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 163.h,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text(
                        'No image has uploaded',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ).copyWith(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 4),
                      //   height: 29.h,
                      //   width: 63.w,
                      //   decoration: BoxDecoration(
                      //     color: kGreen,
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      //   child: const Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "4.2",
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           color: kWhite,
                      //         ),
                      //       ),
                      //       Icon(
                      //         Icons.star,
                      //         size: 20,
                      //         color: kWhite,
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  kHiegth6,
                  Row(
                    children: [
                      // const Text(
                      //   "Pizza, Pastas, Desserts",
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //   ),
                      // ),
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
      ),
    );
  }
}
