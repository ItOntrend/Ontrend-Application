import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';

class PizzaSearchPage extends StatelessWidget {
  const PizzaSearchPage({super.key});

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
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Image.asset("assets/icons/search_icon.png"),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.grey.shade400,
                        width: 1,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      Image.asset("assets/icons/mic_icon.png"),
                    ],
                  ),
                  hintText: "Pizza...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
              ),
              kHiegth20,
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Pizza",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              kHiegth25,
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    ExploreCard(image: "assets/image/explore_image.png"),
                    kHiegth20,
                    ExploreCard(image: "assets/image/explore_image.png"),
                    kHiegth20,
                    ExploreCard(image: "assets/image/explore_image.png"),
                    kHiegth20,
                    ExploreCard(image: "assets/image/explore_image.png"),
                    kHiegth20,
                    ExploreCard(image: "assets/image/explore_image.png"),
                    kHiegth20,
                    ExploreCard(image: "assets/image/explore_image.png"),
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
