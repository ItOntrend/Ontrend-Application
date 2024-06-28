import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/count_controller.dart';

class AddButton extends StatelessWidget {
  final Function() onIncrement;
  final Function() onDecrement;
  final int count;

  const AddButton({
    Key? key,
    required this.onIncrement,
    required this.onDecrement,
    required this.count,
  }) : super(key: key);

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 10),
      backgroundColor: kGreen,
      content: const Text(
        'Item added',
        style: TextStyle(color: kWhite),
      ),
      action: SnackBarAction(
        label: 'View Cart',
        textColor: kWhite,
        onPressed: () {
          Get.to(const AddToCartPage());
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showSnackBar(context, 'Button Pressed!');
      },
      child: Container(
        height: 32,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kOrange,
        ),
        child: Center(
          child: CountController(
            onIncrement: () {
              onIncrement();
              _showSnackBar(context, 'Incremented!');
            },
            onDecrement: () {
              onDecrement();
              _showSnackBar(context, 'Decremented!');
            },
            count: count,
          ),
        ),
      ),
    );
  }
}
