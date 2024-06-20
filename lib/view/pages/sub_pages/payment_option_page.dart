import 'package:flutter/material.dart';

class PaymentOptionPage extends StatelessWidget {
  const PaymentOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          "Payment Options",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 22,
          ),
          child: Column(
            children: [
              
            ],
          ),
        ),

      ),
    );
  }
}
