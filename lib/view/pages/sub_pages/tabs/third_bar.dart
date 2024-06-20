import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/item_food_card.dart';

class ThirdBar extends StatelessWidget {
  const ThirdBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children:  [
        kHiegth30,
        const FoodItemCard(
          name: "Straberry Mojito",
          image: "assets/image/mojito_1_image.png",
        ),
        kHiegth20,
        const FoodItemCard(
          name: "Grape Mojito",
          image: "assets/image/mojito_2_image.png",
        ),
        kHiegth20,
        const FoodItemCard(
          name: "Apple Mojito",
          image: "assets/image/mojito_3_image.png",
        ),
        kHiegth20,
        const FoodItemCard(
          name: "Orange Mojito",
          image: "assets/image/mojito_4_image.png",
        ),
        kHiegth25,
      ],
    );
  }
}
