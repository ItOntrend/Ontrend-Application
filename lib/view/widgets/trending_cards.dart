import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';

class TrendingCards extends StatelessWidget {
  const TrendingCards({
    super.key,
    required this.imagePath,
    required this.itemPrice,
    required this.name,
    required this.onTap,

    // required this.image,
    // required this.offerLabel,
    // required this.brandName,
  });
  final String imagePath;
  final Widget itemPrice;
  final String name;
  final VoidCallback onTap;
  // final String image;
  // final Widget offerLabel;
  // final String brandName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 176.h,
        width: 140.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                imagePath.startsWith('http://') ||
                        imagePath.startsWith('https://')
                    ? Image.network(
                        imagePath,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                Positioned(bottom: 0, child: itemPrice),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8).copyWith(left: 4),
              child: Text(
                maxLines: 1,
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kBlack,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
