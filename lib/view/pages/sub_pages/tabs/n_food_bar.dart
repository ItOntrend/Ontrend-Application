import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NFoodBar extends StatelessWidget {
  const NFoodBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Center(
        child: Text("No Notification".tr),
      ),
      // ListView(
      //   scrollDirection: Axis.vertical,
      //   children:  [
      //     NotificationCard(
      //       title: "KFC",
      //       image: "assets/image/kfc_image.png",
      //     ),
      //     kHiegth25,
      //   ],
      // ),
    );
  }
}
