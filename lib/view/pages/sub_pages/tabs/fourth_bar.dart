import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/item_food_card.dart';

class FourthBar extends StatelessWidget {
  const FourthBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
          scrollDirection: Axis.vertical,
          children: [
    kHiegth25,
    const FoodItemCard(
      name: "Italian Piza",
      image: "assets/image/pizza_1_image.png",
    ),
    kHiegth20,
    const FoodItemCard(
      name: "Italian Piza",
      image: "assets/image/pizza_2_image.png",
    ),
    kHiegth20,
    const FoodItemCard(
      name: "Italian Piza",
      image: "assets/image/pizza_3_image.png",
    ),
    kHiegth20,
    const FoodItemCard(
      name: "Italian Piza",
      image: "assets/image/pizza_4_image.png",
    ),
    kHiegth20,
          ],
        );
  }
}
