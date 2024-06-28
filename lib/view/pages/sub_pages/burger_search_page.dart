import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';

class BurgerSearchPage extends StatelessWidget {
  const BurgerSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              const TextfieldWithMic(
                hintText: "Burger...",
              ),
              kHiegth20,
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Text(
                    "Burger",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              kHiegth25,
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const ExploreCard(
                      image: "assets/image/explore_burger_one.png",
                      tabIndex: 0,
                    ),
                    kHiegth20,
                    const ExploreCard(
                      image: "assets/image/explore_burger_two.png",
                      tabIndex: 1,
                    ),
                    kHiegth20,
                    const ExploreCard(
                      image: "assets/image/explore_burger_one.png",
                      tabIndex: 0,
                    ),
                    kHiegth20,
                    const ExploreCard(
                      image: "assets/image/explore_burger_two.png",
                      tabIndex: 1,
                    ),
                    kHiegth20,
                    const ExploreCard(
                      image: "assets/image/explore_burger_one.png",
                      tabIndex: 0,
                    ),
                    kHiegth20,
                    const ExploreCard(
                      image: "assets/image/explore_burger_two.png",
                      tabIndex: 1,
                    ),
                    kHiegth20,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
