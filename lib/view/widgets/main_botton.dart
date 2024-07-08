import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';

class MainBotton extends StatelessWidget {
  const MainBotton({
    super.key,
    required this.name,
    this.onTap,
  });
  final String name;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58.h,
        width: 344.w,
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
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
