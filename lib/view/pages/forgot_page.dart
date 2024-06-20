import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/main_text_field.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Lottie.network(
                "https://lottie.host/379f16f4-aeaf-4b67-8b50-34851cc10e9b/xGRuPYukSR.json"),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
              ),
              child: Column(
                children: [
                  kHiegth30,
                  const Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  kHiegth25,
                  Text(
                    "You will receive your password on your\nregistered email or phone",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      color: kBlackOpacity6,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  kHiegth76,
                  const MainTextField(
                    hintText: "Email ID or Phone No",
                  ),
                  kHiegth60,
                  const MainBotton(
                    name: "Send",
                  ),
                  kHiegth35,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Go back to Login? ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: kBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
