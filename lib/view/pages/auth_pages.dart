import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/utils/constants/firebase_constants.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/login_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/navigation_manu.dart';

class AuthPages extends StatelessWidget {
  const AuthPages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseConstants.authInstance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitCircle(
              color: kOrange,
            );
          } else if (snapshot.hasError) {
            return const Text("Something went wrong");
          } else if (snapshot.hasData) {
            return const NavigationManu();
          } else {
            return LoginPage();
          }
        });
  }
}
