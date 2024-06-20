import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/notification_card.dart';

class NAllBar extends StatelessWidget {
  const NAllBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ListView(
        scrollDirection: Axis.vertical,
        children:  const [
          NotificationCard(
            title: "KFC",
            image: "assets/image/kfc_image.png",
          ),
          kHiegth25,
          NotificationCard(
            title: "GK Store",
            image: "assets/image/gk_shop_image.png",
          ),
          kHiegth25,
          NotificationCard(
            title: "MY G",
            image: "assets/image/my_g_image.png",
          ),
          kHiegth25,
          NotificationCard(
            title: "Zoolaa Mall",
            image: "assets/image/zoola_mall_image.png",
          ),
          kHiegth25,
          NotificationCard(
            title: "Soften Future",
            image: "assets/image/soften_future_image.png",
          ),
          kHiegth25,
        ],
      ),
    );
  }
}
