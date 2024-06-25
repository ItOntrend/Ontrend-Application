import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/after_order_page.dart';

class OrderCompletePage extends StatelessWidget {
  const OrderCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      backgroundColor: kWhite,
      splashScreenBody: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/image/order_successfull_image.png",
            ),
          ),
        ],
      ),
      duration: const Duration(
        seconds: 3,
      ),
      nextScreen: const AfterOrderPage(),
    );
  }
}
