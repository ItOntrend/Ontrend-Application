import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';

class TabBarOneCard extends StatelessWidget {
  const TabBarOneCard({
    super.key,
    required this.tabname,
  });

  final String tabname;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 24,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: kGrey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          tabname,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
