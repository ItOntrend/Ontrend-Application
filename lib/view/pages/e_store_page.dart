import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EStorePage extends StatelessWidget {
  const EStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
          "https://lottie.host/172ad539-7a9e-45ac-97cd-8c8a34c8c0f7/dBVnzYixTm.json",
        ),
      ),
    );
  }
}
