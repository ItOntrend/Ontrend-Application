import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';

class TrendingCards extends StatelessWidget {
  const TrendingCards({
    super.key,
    required this.image,
    required this.offerLabel,
    required this.brandName,
  });
  final String image;
  final Widget offerLabel;
  final String brandName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176,
      width: 140,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(image),
              offerLabel,
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              brandName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: kBlack,
              ),
            ),
          )
        ],
      ),
    );
  }
}
