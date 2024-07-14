import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/notification_card.dart';

class NEcartBar extends StatelessWidget {
  const NEcartBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ListView(
        scrollDirection: Axis.vertical,
        children:  [
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
