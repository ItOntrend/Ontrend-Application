import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';

class MainBottonTwo extends StatelessWidget {
  const MainBottonTwo({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kDarkOrange,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
            color: kWhite,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
