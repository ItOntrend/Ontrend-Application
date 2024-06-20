import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/item_food_card.dart';

class SecondBar extends StatelessWidget {
  const SecondBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.vertical,
        children:  [
          kHiegth30,
          const FoodItemCard(
            name: "Chicken Burger",
            image: "assets/image/chicken_burger_image.png",
          ),
          kHiegth20,
          const FoodItemCard(
            name: "Mango Shake",
            image: "assets/image/mango_shake_image.png",
          ),
          kHiegth20,
          const FoodItemCard(
            name: "Classic Pizza",
            image: "assets/image/classic_pizza_image.png",
          ),
          kHiegth20,
          const FoodItemCard(
            name: "Papaya Juice",
            image: "assets/image/papaya_juice_image.png",
          ),
          kHiegth25,
        ],
      ),
    );
  }
}
