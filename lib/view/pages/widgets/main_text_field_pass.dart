import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';

class MainTextFieldPass extends StatefulWidget {
  const MainTextFieldPass({
    super.key,
    required this.hintText,
  });
  final String hintText;

  @override
  State<MainTextFieldPass> createState() => _MainTextFieldPassState();
}

class _MainTextFieldPassState extends State<MainTextFieldPass> {
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
        child: TextField(
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
