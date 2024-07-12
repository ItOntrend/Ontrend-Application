import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';

class OfferLabel extends StatelessWidget {
  const OfferLabel({
    super.key,
    required this.offerlabel,
    required this.brandName,
  });

  final String offerlabel;
  final String brandName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 0, left: 0),
      height: 63,
      width: 138,
      padding: const EdgeInsets.only(left: 10, bottom: 10, top: 4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(2, 4), // Adjusts the shadow to the bottom
          ),
        ],
        color: Colors.black.withOpacity(0.4),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              offerlabel,
              style: const TextStyle(
                color: kWhite,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              brandName,
              style: const TextStyle(
                color: kWhite,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
