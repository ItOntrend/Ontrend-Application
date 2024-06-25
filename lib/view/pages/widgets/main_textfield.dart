import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator, this.numberOrName,
  });
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? numberOrName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          10,
        ),
        border: Border.all(
          color: kGrey,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(
              0.5,
            ),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        keyboardType: numberOrName,
        controller: controller,
        validator: validator,
        enabled: true,
        decoration: InputDecoration(
          
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
