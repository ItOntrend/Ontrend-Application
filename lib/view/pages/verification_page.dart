import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/navigation_manu.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerificationPage extends StatelessWidget {
  final ConfirmationResult confirmationResult;
  final TextEditingController otpController = TextEditingController();

  VerificationPage({super.key, required this.confirmationResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: LottieBuilder.network(
                "https://lottie.host/a0dcc709-9820-471d-a4c6-4f24fcba3f96/mVtARx1xKM.json",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Verify Your Number".tr,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  kHiegth40,
                  Text(
                    "You will receive a 4 digit OTP\nto your phone number.".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: kBlack.withOpacity(
                        0.6,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  kHiegth50,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _otpInputField(),
                      _otpInputField(),
                      _otpInputField(),
                      _otpInputField(),
                    ],
                  ),
                  kHiegth24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Didn't receive code? ".tr),
                      Text(
                        "Resend".tr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: kBlue,
                        ),
                      ),
                    ],
                  ),
                  kHiegth24,
                  GestureDetector(
                    onTap: () => _verifyOTP(context),
                    child: MainBotton(name: "Verify".tr),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpInputField() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(1, 4),
          ),
        ],
      ),
      child: TextField(
        controller: otpController,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  Future<void> _verifyOTP(BuildContext context) async {
    final otp = otpController.text.trim();
    try {
      final userCredential = await confirmationResult.confirm(otp);
      if (userCredential.additionalUserInfo!.isNewUser) {
        Get.to(() => const NavigationManu());
      } else {
        Get.snackbar('Error'.tr, 'User already exists.'.tr);
      }
    } catch (e) {
      Get.snackbar('Error'.tr, 'Invalid OTP.');
    }
  }
}
