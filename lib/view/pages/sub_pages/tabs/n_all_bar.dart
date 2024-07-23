import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NAllBar extends StatelessWidget {
  const NAllBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Center(
          child: Text("No Notification".tr),
        )
        // ListView(
        //   scrollDirection: Axis.vertical,
        //   children:  const [
        // NotificationCard(
        //   title: "KFC",
        //   image: "assets/image/kfc_image.png",
        // ),
        // kHiegth25,
        // NotificationCard(
        //   title: "GK Store",
        //   image: "assets/image/gk_shop_image.png",
        // ),
        // kHiegth25,
        // NotificationCard(
        //   title: "MY G",
        //   image: "assets/image/my_g_image.png",
        // ),
        // kHiegth25,
        // NotificationCard(
        //   title: "Zoolaa Mall",
        //   image: "assets/image/zoola_mall_image.png",
        // ),
        // kHiegth25,
        // NotificationCard(
        //   title: "Soften Future",
        //   image: "assets/image/soften_future_image.png",
        // ),
        // kHiegth25,
        // ],
        );
  }
}
