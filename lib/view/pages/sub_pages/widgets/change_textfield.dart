import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';

class ChangeTextfield extends StatefulWidget {
  const ChangeTextfield({
    Key? key,
    required this.initialValue,
    required this.hintText,
  }) : super(key: key);

  final String hintText;
  final String initialValue;

  @override
  _ChangeTextfieldState createState() => _ChangeTextfieldState();
}

class _ChangeTextfieldState extends State<ChangeTextfield> {
  bool isEditable = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleEditable() {
    setState(() {
      isEditable = !isEditable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      enabled: isEditable,
      decoration: InputDecoration(
        hintText: widget.hintText,
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
              onPressed: toggleEditable,
              child: Text(
                isEditable ? 'Save'.tr : 'Change'.tr,
                style:const TextStyle(color: kOrange),
              ),
            ),
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
