import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';

class AddButton extends StatelessWidget {
  final ItemModel item;

  const AddButton({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    return GestureDetector(
      onTap: () {
        cartController.addItemToCart(item);
        _showSnackBar(context, cartController);
      },
      child: Container(
        height: 32.h,
        width: 150.w,
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

  void _showSnackBar(BuildContext context, CartController cartController) {
    final snackBar = SnackBar(
      duration: const Duration(days: 1), // Snackbar duration is now 1 day
      backgroundColor: kGreen,
      content: Obx(() => Text(
        'Item added (${cartController.getItemCount()} items in cart)',
        style: const TextStyle(color: kWhite),
      )),
      action: SnackBarAction(
        label: 'View Cart',
        textColor: kWhite,
        onPressed: () {
          Get.to(
            const AddToCartPage(
              addedBy: "",
              restaurantName: '',
            ),
          );
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
