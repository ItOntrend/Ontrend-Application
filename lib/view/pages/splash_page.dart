import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/auth_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/auth_pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      duration: const Duration(milliseconds: 3000),
      backgroundColor: kWhite,
      splashScreenBody: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 351.h,
          ),
          Center(
            child: Image.asset(
              "assets/image/splash_screen_image.png",
            ),
          ),
          const Spacer(),
          const Text(
            "100% SAFE & SECURE",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
            ),
          ),
          kHiegth50,
        ],
      ),
      nextScreen: AuthPages(),
    );
  }
}
