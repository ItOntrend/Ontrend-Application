import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/auth_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/login_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/country_selection_field.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/main_textfield.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/main_textfield_password.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton.dart';

class SingUpPage extends StatelessWidget {
  SingUpPage({super.key});
  final authController = Get.put(AuthController());
  // final userController = Get.find<UserController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ).copyWith(top: 28),
          child: Form(
            key: _formKey,
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
                MainTextField(
                  hintText: "First Name*",
                  controller: authController.firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                kHiegth24,
                MainTextField(
                  hintText: "Last Name*",
                  controller: authController.lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                kHiegth24,
                MainTextField(
                  numberOrName: TextInputType.emailAddress,
                  hintText: "Email*",
                  controller: authController.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                kHiegth24,
                CountrySelectionField(
                  controller: authController.nationalityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your Nationality';
                    }
                    return null;
                  },
                  onCountrySelected: (String country) {
                    authController.nationalityController.text = country;
                    // userController.nationality.value = country;
                  },
                ),
                kHiegth24,
                MainTextField(
                  numberOrName: TextInputType.number,
                  hintText: "Mobile Number*",
                  controller: authController.numberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your number';
                    }
                    return null;
                  },
                ),
                kHiegth24,
                MainTextFieldPassword(
                  hintText: "Password*",
                  controller: authController.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                kHiegth35,
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // userController.setUserData(
                      //   firstName: authController.firstNameController.text,
                      //   lastName: authController.lastNameController.text,
                      //   email: authController.emailController.text,
                      //   nationality: authController.nationalityController.text,
                      //   number: authController.numberController.text,
                      // );
                      authController.onSignUp(context);
                    }
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
                kHiegth25,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
