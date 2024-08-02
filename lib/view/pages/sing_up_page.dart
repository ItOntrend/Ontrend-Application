import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/auth_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/login_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/country_selection_field.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/main_textfield.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/main_textfield_password.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton.dart';

/*
class SingUpPage extends StatelessWidget {
  SingUpPage({super.key});
  final authController = Get.put(AuthController());
  // final userController = Get.find<UserController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ).copyWith(top: 28),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Register".tr,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                kHiegth20,
                Text(
                  "Just a few things to get started".tr,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kHiegth74,
                MainTextField(
                  hintText: "First Name*".tr,
                  controller: authController.firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name'.tr;
                    }
                    return null;
                  },
                ),
                kHiegth24,
                MainTextField(
                  hintText: "Last Name*".tr,
                  controller: authController.lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name'.tr;
                    }
                    return null;
                  },
                ),
                kHiegth24,
                MainTextField(
                  numberOrName: TextInputType.emailAddress,
                  hintText: "Email*".tr,
                  controller: authController.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email'.tr;
                    } else if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email'.tr;
                    }
                    return null;
                  },
                ),
                kHiegth24,
                CountrySelectionField(
                  controller: authController.nationalityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your Nationality'.tr;
                    }
                    return null;
                  },
                  onCountrySelected: (String country) {
                    authController.nationalityController.text = country;
                    // userController.nationality.value = country;
                  },
                ),
                kHiegth24,
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "+968",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: MainTextField(
                        numberOrName: TextInputType.number,
                        hintText: "Mobile Number*".tr,
                        controller: authController.numberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your number'.tr;
                          } else if (!RegExp(r'^\d{8}$').hasMatch(value)) {
                            return 'Please enter a valid Omani mobile number'
                                .tr;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                kHiegth24,
                MainTextFieldPassword(
                  hintText: "Password*".tr,
                  controller: authController.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password'.tr;
                    }
                    return null;
                  },
                ),
                kHiegth24,
                MainTextFieldPassword(
                  hintText: "Password*".tr,
                  controller: authController.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password'.tr;
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
                  child: MainBotton(name: "Create Account".tr),
                ),
                kHiegth24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do you have an account?".tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(
                        () => LoginPage(),
                      ),
                      child: Text(
                        "Login".tr,
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
*/
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Directionality(
        textDirection: TextDirection.ltr, // Set text direction explicitly
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
            ).copyWith(top: 28),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Register".tr,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  kHiegth20,
                  Text(
                    "Just a few things to get started".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  kHiegth74,
                  MainTextField(
                    hintText: "First Name*".tr,
                    controller: authController.firstNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name'.tr;
                      }
                      return null;
                    },
                  ),
                  kHiegth24,
                  MainTextField(
                    hintText: "Last Name*".tr,
                    controller: authController.lastNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name'.tr;
                      }
                      return null;
                    },
                  ),
                  kHiegth24,
                  MainTextField(
                    numberOrName: TextInputType.emailAddress,
                    hintText: "Email*".tr,
                    controller: authController.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email'.tr;
                      } else if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email'.tr;
                      }
                      return null;
                    },
                  ),
                  kHiegth24,
                  CountrySelectionField(
                    controller: authController.nationalityController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your Nationality'.tr;
                      }
                      return null;
                    },
                    onCountrySelected: (String country) {
                      authController.nationalityController.text = country;
                    },
                  ),
                  kHiegth24,
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "+968",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: MainTextField(
                          numberOrName: TextInputType.number,
                          hintText: "Mobile Number*".tr,
                          controller: authController.numberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your number'.tr;
                            } else if (!RegExp(r'^\d{8}$').hasMatch(value)) {
                              return 'Please enter a valid Omani mobile number'
                                  .tr;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  kHiegth24,
                  MainTextFieldPassword(
                    hintText: "Password*".tr,
                    controller: authController.passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password'.tr;
                      }
                      return null;
                    },
                  ),
                  kHiegth24,
                  MainTextFieldPassword(
                    hintText: "Confirm Password*".tr,
                    controller: authController.passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password'.tr;
                      }
                      return null;
                    },
                  ),
                  kHiegth35,
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        authController.onSignUp(context);
                      }
                    },
                    child: MainBotton(name: "Create Account".tr),
                  ),
                  kHiegth24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do you have an account?".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(
                          () => LoginPage(),
                        ),
                        child: Text(
                          "Login".tr,
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
      ),
    );
  }
}
