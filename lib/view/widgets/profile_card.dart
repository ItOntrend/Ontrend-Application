import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/constant.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, top: 130),
      padding: const EdgeInsets.all(12),
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 65,
                width: 84,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kGreen,
                ),
              ),
              kWidth20,
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dominos Pizza",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Pizza, Pastas, Desserts",
                    style: TextStyle(fontSize: 14, color: kGrey),
                  ),
                ],
              )
            ],
          ),
          kHiegth10,
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Delivery fee",
                    style: TextStyle(
                      fontSize: 14,
                      color: kGrey,
                    ),
                  ),
                  Text(
                    "OMR 0.380",
                    style: TextStyle(
                      fontSize: 12,
                      color: kBlack,
                    ),
                  ),
                ],
              ),
              VerticalDivider(
                thickness: 10,
                color: kBlue,
              ),
              Column(
                children: [
                  Text(
                    "Delivery time",
                    style: TextStyle(
                      fontSize: 14,
                      color: kGrey,
                    ),
                  ),
                  Text(
                    "18 min",
                    style: TextStyle(
                      fontSize: 12,
                      color: kBlack,
                    ),
                  ),
                ],
              ),
              VerticalDivider(
                thickness: 10,
                color: kBlue,
              ),
              Column(
                children: [
                  Text(
                    "Delivery by",
                    style: TextStyle(
                      fontSize: 14,
                      color: kGrey,
                    ),
                  ),
                  Text(
                    "Roofaas",
                    style: TextStyle(
                      fontSize: 12,
                      color: kOrange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
