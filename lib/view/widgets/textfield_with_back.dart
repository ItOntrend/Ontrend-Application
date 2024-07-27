import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';

class TextfieldWithBack extends StatelessWidget {
  const TextfieldWithBack({
    super.key,
    required this.hintText,
    this.controller,
    this.onSubmitted,
    this.initialValue,
    this.onChanged,
  });
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      enabled: true,
      decoration: InputDecoration(
        fillColor: kWhite,
        prefixIcon: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: kDarkOrange,
          ),
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.grey.shade400,
              width: 1,
              height: 20,
            ),
            const SizedBox(width: 8),
            Image.asset("assets/icons/mic_icon.png"),
          ],
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
    );
  }
}
