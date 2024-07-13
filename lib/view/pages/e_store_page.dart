import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class EStorePage extends StatelessWidget {
  const EStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
          child: Lottie.network(
        "https://lottie.host/543aeb4f-4ed4-4297-a6c9-5f46d70ac02a/cKVy9TJ0zo.json",
        fit: BoxFit.cover,
      ),),
    );
  }
}
