import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';

class Utils {
  Utils._();
  static final Utils instance = Utils._();
  //

  //
  bool isLoading = false;
  void showLoader() {
    isLoading = true;
    Get.dialog(
      barrierDismissible: false,
      barrierColor: Colors.black12.withOpacity(0.3),
      const Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Center(
          child: SpinKitCircle(
            color: kOrange,
          ),
        ),
      ),
    );
  }
  void hideLoader () {
    if (isLoading){
      isLoading = false;
      Get.back();

    }

  }
  void showSnackbar({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.red,
  }) {
    if (ScaffoldMessenger.of(context).mounted) {
      final snackDemo = SnackBar(
        content: Center(child: Text(message)),
        backgroundColor: backgroundColor,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackDemo);
    }
  }
}
