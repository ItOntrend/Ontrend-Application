import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/constant.dart';

class OngoingMyOrder extends StatelessWidget {
  const OngoingMyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          kHiegth25,
        ],
      ),
    );
  }
}
