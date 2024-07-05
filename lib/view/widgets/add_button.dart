import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
// import 'package:ontrend_food_and_e_commerce/view/widgets/count_controller.dart';

class AddButton extends StatelessWidget {
  final ItemModel item;
  // final Function() onIncrement;
  // final Function() onDecrement;
  // final int count;

  const AddButton({
    Key? key,
    required this.item,
    // required this.onIncrement,
    // required this.onDecrement,
    // required this.count,
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
          Get.to(
            const AddToCartPage(),
          );
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    return GestureDetector(
      onTap: () {
        cartController.addItemToCart(item);
        _showSnackBar(context, 'Button Pressed!');
      },
      child: Container(
        height: 32,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kOrange,
        ),
        child: const Center(
          child: Text(
            "Add",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              color: kWhite,
            ),
          ),
        ),
      ),
    );
  }
}




 //   void _addItemToCart(BuildContext context) {
  //   final cart = FlutterCart();
  //   cart.addItemToCart(
  //     productId: productId,
  //     productName: productName,
  //     unitPrice: productPrice,
  //     quantity: 1,
  //   );
  //   _showSnackBar(context, 'Item added to cart');
  // }