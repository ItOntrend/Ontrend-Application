import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';

class MainTextFieldPassword extends StatefulWidget {
  const MainTextFieldPassword({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
  });
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<MainTextFieldPassword> createState() => _MainTextFieldPassSPassword();
}

class _MainTextFieldPassSPassword extends State<MainTextFieldPassword> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
          controller: widget.controller,
          validator: widget.validator,
          obscureText: _obscureText,
          enabled: true,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: Visibility(
              child: IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.remove_red_eye_rounded
                      : Icons.remove_red_eye_outlined,
                ),
                onPressed: _toggleVisibility,
              ),
            ),
          ),
        ));
  }
}
