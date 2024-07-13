import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/repository/auth_repository.dart';
import 'package:ontrend_food_and_e_commerce/utils/enums/auth_status.dart';
import 'package:ontrend_food_and_e_commerce/utils/exception/auth_exception.dart';
import 'package:ontrend_food_and_e_commerce/utils/utils.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/main_textfield.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final emailController = TextEditingController();
  // final numberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.network(
                  "https://lottie.host/379f16f4-aeaf-4b67-8b50-34851cc10e9b/xGRuPYukSR.json"),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      kHiegth30,
                      Text(
                        "Forgot Password".tr,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      kHiegth25,
                      Text(
                        "You will receive your password on your\nregistered email or phone"
                            .tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19,
                          color: kBlackOpacity6,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kHiegth76,
                      MainTextField(
                        controller: emailController,
                        hintText: "Email ID or Phone No".tr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email'.tr;
                          }
                          if (!GetUtils.isEmail(value)) {
                            return 'Please enter a valid email'.tr;
                          }
                          return null;
                        },
                      ),
                      kHiegth60,
                      GestureDetector(
                        onTap: () => onSubmit(context),
                        child: MainBotton(
                          name: "Send".tr,
                        ),
                      ),
                      // kHiegth35,
                      // const Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       "Go back to Login? ",
                      //       style: TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w400,
                      //       ),
                      //     ),
                      //     Text(
                      //       "Sign In",
                      //       style: TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w400,
                      //         color: kBlue,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final status = await AuthRepository.forgotPassword(
          email: emailController.text.trim());
      if (status == AuthStatus.successful) {
        Utils.instance.showSnackbar(
          context: context,
          message: 'Password reset email sent successfully'.tr,
        );
        Get.back(); // Go back to the previous screen
      } else {
        final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
        Utils.instance.showSnackbar(
          context: context,
          message: errorMsg,
        );
      }
    }
  }
}
