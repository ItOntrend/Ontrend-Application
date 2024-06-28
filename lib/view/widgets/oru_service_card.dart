import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/constant.dart';

class OurServiceCard extends StatelessWidget {
  const OurServiceCard({
    super.key,
    required this.name,
    required this.image,
  });
  final String name;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      height: 224,
      width: 179,
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
            height: 20,
            width: 140,
            decoration: BoxDecoration(
              color: kBlue,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.percent_outlined,
                  size: 14,
                  color: kRed,
                ),
                kWidth10,
                Text(
                  "Up to 40% Off",
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
