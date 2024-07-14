import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/notification_card.dart';

class NFoodBar extends StatelessWidget {
  const NFoodBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ListView(
        scrollDirection: Axis.vertical,
        children:  [
          NotificationCard(
            title: "KFC",
            image: "assets/image/kfc_image.png",
          ),
          kHiegth25,
        ],
      ),
    );
  }
}
