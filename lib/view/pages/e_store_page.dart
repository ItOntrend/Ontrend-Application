import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';

class EStorePage extends StatelessWidget {
  const EStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Lottie.asset(
        "assets/lottie_animation/coming_soon_lottie.json",
        // fit: BoxFit.cover,
      ),
    );
  }
}
