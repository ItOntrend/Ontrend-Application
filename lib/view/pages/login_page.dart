import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/controller/auth_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/forgot_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/navigation_manu.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sing_up_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/main_textfield.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/main_textfield_password.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.network(
                "https://lottie.host/70646229-eaba-423c-9627-40ccd7e521eb/t7ganPjNoQ.json",
                fit: BoxFit.cover,
              ),
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
                child: Form(
                  key: authController.formKey,
                  child: Column(
                    children: [
                      MainTextField(
                        hintText: "Email ID",
                        controller: authController.emailController,
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return "Email is required";
                          } else if (email.length < 6) {
                            return "Email must be 6 Letter";
                          }
                          return null;
                        },
                      ),
                      kHiegth20,
                      MainTextFieldPassword(
                        hintText: "Password",
                        controller: authController.passwordController,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Password is required";
                          } else if (password.length < 8) {
                            return "Password must be 8 Letter";
                          }
                          return null;
                        },
                      ),
                      kHiegth20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(ForgotPassword());
                            },
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
              ),
              kHiegth90,
              GestureDetector(
                onTap: () => Get.to(
                  const NavigationManu(),
                ),
                child: GestureDetector(
                    onTap: () {
                      if (authController.formKey.currentState!.validate()) {
                        authController.onLogin(context);
                      }
                    },
                    child: const MainBotton(name: "Login")),
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
              kHiegth25,
            ],
          ),
        ),
      ),
    );
  }
}
