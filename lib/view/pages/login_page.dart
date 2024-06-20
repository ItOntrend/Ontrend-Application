import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/forgot_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/navigation_manu.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sing_up_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/main_text_field.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/main_text_field_pass.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Lottie.network(
                "https://lottie.host/70646229-eaba-423c-9627-40ccd7e521eb/t7ganPjNoQ.json",
                fit: BoxFit.cover),
            kHiegth70,
            const Text(
              "Welcome back!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            kHiegth30,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  const MainTextField(hintText: "Email ID"),
                  kHiegth20,
                  const MainTextFieldPass(hintText: "Password"),
                  kHiegth20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(
                          const ForgotPassword(),
                        ),
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: kBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            kHiegth90,
            GestureDetector(
              onTap: () => Get.to(
                const NavigationManu(),
              ),
              child: const MainBotton(name: "Login"),
            ),
            kHiegth35,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don’t have an account? ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(
                    SingUpPage(),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: kBlue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
