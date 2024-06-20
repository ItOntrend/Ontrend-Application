import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/navigation_manu.dart';

class AfterOrderPage extends StatelessWidget {
  const AfterOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Stack(
                children: [
                  Image.asset("assets/image/delivery_map_image.png"),
                  IconButton(
                    onPressed: () {
                      Get.to(const NavigationManu());
                    },
                    icon: const CircleAvatar(
                        backgroundColor: kWhite,
                        radius: 24,
                        child: Icon(Icons.arrow_back_ios_new_outlined)),
                  )
                ],
              ),
            ),
            Image.asset(
              "assets/image/deliver_proccess.png",
            ),
          ],
        ),
      ),
    );
  }
}
