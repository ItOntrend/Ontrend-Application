import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/delivery_tracking_page.dart';

class OrderCompleteSplashPage extends StatelessWidget {
  final String orderId;

  const OrderCompleteSplashPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      backgroundColor: kWhite,
      splashScreenBody: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Order Has Been Placed Successfully".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: kGreen,
                    ),
                  ),
                  kHiegth24,
                  Container(
                    padding: const EdgeInsets.all(14),
                    height: 100.h,
                    width: 100.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kDarkOrange,
                    ),
                    child: Image.asset(
                      "assets/icons/tick_icon_image.png",
                      height: 60,
                      width: 80,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 3),
      nextScreen: DeliveryTrackingPage(orderId: orderId),
    );
  }
}
