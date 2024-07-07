import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/Model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
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
    required this.addedBy, required this.restaurantName,
  }) : super(key: key);

  final String name;
  final String image;
  final int price;
  final String description;
  final String addedBy;
  final String restaurantName;

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
    final item = ItemModel(
      name: widget.name,
      imageUrl: widget.image,
      price: widget.price,
      description: widget.description,
      addedBy: widget.addedBy,
      restaurantName: widget.restaurantName,
    );
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 10, bottom: 8, top: 12),
      margin: const EdgeInsets.symmetric(horizontal: 18).copyWith(bottom: 20),
      height: 168.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: kBorderLiteBlack,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                  height: 100.h,
                  width: 150.w,
                ),
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
                '${widget.price}.000',
                style: const TextStyle(
                  fontSize: 14,
                  color: kOrange,
                ),
              ),
              Text(
                widget.description,
                style: const TextStyle(fontSize: 12),
              ),
              Spacer(),
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
                        duration: const Duration(seconds: 5),
                        content: const Text('Yay! Added to your cart'),
                        action: SnackBarAction(
                          label: 'View Cart',
                          onPressed: () {
                            Get.to(const AddToCartPage(addedBy: '',restaurantName: '',));
                          },
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: AddButton(
                      item: item,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
