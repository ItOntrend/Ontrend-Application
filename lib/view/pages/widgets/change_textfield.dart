import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';

class ChangeTextfield extends StatelessWidget {
  const ChangeTextfield({
    super.key,
    required this.initialValue,
    required this.hintText,
  });
  final String hintText;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      enabled: true,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.grey.shade400,
              width: 1,
              height: 20,
            ),
            kWidth6,
            TextButton(
              onPressed: () {
                // Add your change logic here
              },
              child: const Text(
                'Change',
                style: TextStyle(color: kOrange),
              ),
            ),
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
    );
  }
}
