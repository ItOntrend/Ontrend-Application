import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/item_view_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/add_button.dart';

class FoodItemCard extends StatefulWidget {
  const FoodItemCard({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  }) : super(key: key);

  final String name;
  final String image;
  final int price;
  final String description;

  @override
  _FoodItemCardState createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  // int itemCount = 0;

  // void incrementCount() {
  //   setState(() {
  //     itemCount++;
  //   });
  // }

  // void decrementCount() {
  //   setState(() {
  //     if (itemCount > 0) {
  //       itemCount--;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 18),
        height: 168.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kGrey),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Get.to(
                  const ItemViewPage(),
                ),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                  height: 100.h,
                  width: 150.w,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                // const Text(
                //   "OMR120",
                //   style: TextStyle(decoration: TextDecoration.lineThrough),
                // ),
                Text(
                  '${widget.price}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: kOrange,
                  ),
                ),
                Text(
                  widget.description,
                  style: const TextStyle(fontSize: 12),
                ),
                kHiegth15,
                Row(
                  children: [
                    const Text(
                      "FREE DELIVERY",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                       color: kOrange,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        final snackBar = SnackBar(
                          content: const Text('Yay! Added to your cart'),
                          action: SnackBarAction(
                            label: 'View Cart',
                            onPressed: () {
                              Get.to(const AddToCartPage());
                            },
                          ),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: const AddButton(),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
