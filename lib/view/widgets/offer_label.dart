import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';

class OfferLabel extends StatelessWidget {
  const OfferLabel({
    super.key,
    required this.offerlabel,
  });

  final String offerlabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, bottom: 10, top: 4),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            offerlabel,
            style: const TextStyle(
                color: kWhite, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const Text(
            "Upto OMR 50",
            style: TextStyle(
              color: kWhite,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
