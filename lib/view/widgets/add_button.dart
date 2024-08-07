import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';

class AddButton extends StatelessWidget {
  final ProductModel item;
  final double mainPrice;
  final String selectedVariant;
  const AddButton({
    super.key,
    required this.item, required this.mainPrice, required this.selectedVariant,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    return GestureDetector(
      onTap: () {
        cartController.addItemToCart(item,mainPrice,selectedVariant);
      },
      child: Container(
        height: 46.h,
        width: 150.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kOrange,
        ),
        child: Center(
          child: Text(
            "Add".tr,
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
