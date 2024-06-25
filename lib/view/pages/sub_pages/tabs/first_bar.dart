import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/item_food_card.dart';

class FirstBar extends StatefulWidget {
  const FirstBar({super.key});

  @override
  State<FirstBar> createState() => _FirstBarState();
}

class _FirstBarState extends State<FirstBar> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        kHiegth30,
        const FoodItemCard(
          name: "Cheese Burger",
          image: "assets/image/cheese_burger_image.png",
        ),
        kHiegth20,
        const FoodItemCard(
          name: "Juicy Burger",
          image: "assets/image/juicy_burger_image.png",
        ),
        kHiegth20,
        const FoodItemCard(
          name: "Beef Burger",
          image: "assets/image/beef_burger_image.png",
        ),
        kHiegth20,
        const FoodItemCard(
          name: "Tomato Burger",
          image: "assets/image/tomato_burger_image.png",
        ),
        kHiegth25,
      ],
    );
  }
}
