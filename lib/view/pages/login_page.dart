import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 271.h,
                width: double.infinity,
                child: Lottie.asset(
                  "assets/lottie_animation/login_lottie.json",
                  fit: BoxFit.cover,
                ),
                // Image.asset(
                //   "assets/lottie_animation/login_animation.gif",
                //   fit: BoxFit.cover,
                // )
              ),
              kHiegth70,
              Text(
                "Welcome back!".tr,
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
                        hintText: "Email ID".tr,
                        controller: authController.emailController,
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return "Email is required".tr;
                          } else if (email.length < 6) {
                            return "Email must be 6 Letter".tr;
                          }
                          return null;
                        },
                      ),
                      kHiegth20,
                      MainTextFieldPassword(
                        hintText: "Password".tr,
                        controller: authController.passwordController,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Password is required".tr;
                          } else if (password.length < 8) {
                            return "Password must be 8 Letter".tr;
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
                            child: Text(
                              "Forgot Password?".tr,
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
                onTap: () => Get.offAll(
                  const NavigationManu(),
                ),
                child: GestureDetector(
                    onTap: () async {
                      if (authController.formKey.currentState!.validate()) {
                        authController.onLogin(context);
                      }
                    },
                    child: MainBotton(name: "Login".tr)),
              ),
              kHiegth35,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account?".tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(
                      SingUpPage(),
                    ),
                    child: Text(
                      "Sign Up".tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: kBlue,
                      ),
                    ),
                  ),
                ],
              ),
              // kHiegth25,
            ],
          ),
        ),
      ),
    );
  }
}
