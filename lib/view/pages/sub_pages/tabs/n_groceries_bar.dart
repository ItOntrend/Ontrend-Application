import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/notification_card.dart';

class NGroceriesBar extends StatelessWidget {
  const NGroceriesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          NotificationCard(
            title: "GK Store",
            image: "assets/image/gk_shop_image.png",
          ),
          kHiegth25,
          NotificationCard(
            title: "Zoolaa Mall",
            image: "assets/image/zoola_mall_image.png",
          ),
          kHiegth25,
        ],
      ),
    );
  }
}
