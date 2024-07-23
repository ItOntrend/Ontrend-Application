import 'package:cached_network_image/cached_network_image.dart';
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
        height: 200.h,
        width: 160.h,
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
                    ? SizedBox(
                        height: 170.h,
                        width: 150.h,
                        child: CachedNetworkImage(
                          imageUrl: imagePath,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
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
