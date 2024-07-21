import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/repository/auth_repository.dart';
import 'package:ontrend_food_and_e_commerce/utils/constants/firebase_constants.dart';
import 'package:ontrend_food_and_e_commerce/utils/enums/auth_status.dart';
import 'package:ontrend_food_and_e_commerce/utils/exception/auth_exception.dart';
import 'package:ontrend_food_and_e_commerce/utils/utils.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/navigation_manu.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final nationalityController = TextEditingController();
  final numberController = TextEditingController();
  final rewardPointsController = TextEditingController(); // Add this
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = RxBool(false);

  Future<void> onLogin(BuildContext context) async {
    Utils.instance.showLoader();

    final status = await AuthRepository.login(
      email: emailController.text.trim(),
      pass: passwordController.text.trim(),
    );
    Utils.instance.hideLoader();
    if (status == AuthStatus.successful) {
      Get.offAll(const NavigationManu());
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      Utils.instance.showSnackbar(context: context, message: errorMsg);
    }
  }

  Future<void> onSignUp(BuildContext context) async {
    Utils.instance.showLoader();

    final status = await AuthRepository.signUp(
      email: emailController.text.trim(),
      pass: passwordController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      nationality: nationalityController.text.trim(),
      number: numberController.text.trim(),
      role: 'User',
      timeStamp: DateTime.now(),
      rewardPoints: 0.0,
    );

    Utils.instance.hideLoader();

    if (status == AuthStatus.successful) {
      // Show Snackbar that email has been sent
      Utils.instance.showSnackbar(
        context: context,
        message: 'Verification email has been sent. Please check your email.',
      );

      // Wait for user to verify email with circular loading indicator
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing the dialog
        builder: (BuildContext context) => const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Waiting for email verification...'),
            ],
          ),
        ),
      );

      // Check email verification status periodically
      Timer.periodic(const Duration(seconds: 5), (timer) async {
        final user = FirebaseConstants.authInstance.currentUser;
        await user?.reload();
        if (user?.emailVerified ?? false) {
          timer.cancel(); // Stop checking once email is verified
          Navigator.of(context).pop(); // Dismiss the waiting dialog
          Get.offAll(const NavigationManu()); // Navigate to main menu
        }
      });
    } else {
      String errorMsg;
      switch (status) {
        case AuthStatus.invalidPhoneNumber:
          errorMsg =
              'Invalid phone number. Please enter a valid 8-digit phone number.';
          break;
        case AuthStatus.invalidPassword:
          errorMsg =
              'Invalid password. Password must contain at least one special character, one digit, one lowercase letter, one uppercase letter, and be at least 8 characters long.';
          break;
        default:
          errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      }
      Utils.instance.showSnackbar(context: context, message: errorMsg);
    }
  }

  // Future<void> onSignUp(BuildContext context) async {
  //   Utils.instance.showLoader();

  //   final status = await AuthRepository.signUp(
  //     email: emailController.text.trim(),
  //     pass: passwordController.text.trim(),
  //     firstName: firstNameController.text.trim(),
  //     lastName: lastNameController.text.trim(),
  //     nationality: nationalityController.text.trim(),
  //     number: numberController.text.trim(),
  //     role: 'User',
  //     timeStamp: DateTime.now(),
  //   );
  //   Utils.instance.hideLoader();
  //   if (status == AuthStatus.successful) {
  //     Get.offAll(const NavigationManu());
  //   } else {
  //     String errorMsg;
  //     switch (status) {
  //       case AuthStatus.invalidPhoneNumber:
  //         errorMsg =
  //             'Invalid phone number. Please enter a valid 8-digit phone number.';
  //         break;
  //       case AuthStatus.invalidPassword:
  //         errorMsg =
  //             'Invalid password. Password must contain at least one special character, one digit, one lowercase letter, one uppercase letter, and be at least 8 characters long.';
  //         break;
  //       default:
  //         errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
  //     }
  //     Utils.instance.showSnackbar(context: context, message: errorMsg);
  //   }
  // }

  Future<void> onForgotPassword(BuildContext context) async {
    Utils.instance.showLoader();

    final status = await AuthRepository.forgotPassword(
      email: forgotController.text.trim(),
    );
    Utils.instance.hideLoader();
    if (status == AuthStatus.successful) {
      Utils.instance.showSnackbar(
          context: context, message: 'Password reset email has been sent!');
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      Utils.instance.showSnackbar(context: context, message: errorMsg);
    }
  }

  Future<void> onLogOut() async {
    await AuthRepository.onLogOut();
  }
}
