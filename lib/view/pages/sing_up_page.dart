import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/login_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/verification_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/main_text_field.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton.dart';

class SingUpPage extends StatelessWidget {
  const SingUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ).copyWith(top: 28),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              kHiegth20,
              const Text(
                "Just a few things to get started",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kHiegth74,
              const MainTextField(hintText: "First Name*"),
              kHiegth24,
              const MainTextField(hintText: "Last Name*"),
              kHiegth24,
              const MainTextField(hintText: "Email*"),
              kHiegth24,
              const MainTextField(hintText: "First Nashnatity*"),
              kHiegth24,
              const MainTextField(hintText: "+968 *"),
              kHiegth24,
              const MainTextField(hintText: "Password*"),
              kHiegth35,
              GestureDetector(
                onTap: () {
                  Get.to(
                    const VerificationPage(),
                  );
                },
                child: const MainBotton(name: "Create Account"),
              ),
              kHiegth24,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Do you have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(
                      LoginPage(),
                    ),
                    child: const Text(
                      "Login",
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
      ),
    );
  }
}
