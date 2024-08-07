import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/constant.dart';

class MainTile extends StatelessWidget {
  const MainTile({
    super.key,
    required this.name,
    required this.icon,
    this.onTap
  });

  final String name;
  final String icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 52,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kOrange),),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kWidth10,
              CircleAvatar(
                radius: 18,
                backgroundColor: kBlack.withOpacity(0.2),
                child: Image.asset(
                  icon,
                ),
              ),
              kWidth20,
              Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              )
            ],
          )),
    );
  }
}
