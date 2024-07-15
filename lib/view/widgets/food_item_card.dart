import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/item_view_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/add_button.dart';

class FoodItemCard extends StatefulWidget {
  const FoodItemCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.addedBy,
    required this.restaurantName,
  });

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
  final CartController cartController = Get.find<CartController>();

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
      height: 188.h,
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
              onTap: () => Get.to(() => ItemViewPage(item: item)),
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
                  Spacer(),
                  Obx(() {
                    final quantity = cartController.getItemQuantity(item);
                    return quantity > 0
                        ? Container(
                            // height: 34.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kGreen,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      cartController.removeItemFromCart(item);
                                    },
                                    icon: const Icon(Icons.remove),
                                    color: kWhite,
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: kWhite,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      cartController.addItemToCart(item);
                                    },
                                    icon: const Icon(Icons.add),
                                    color: kWhite,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              cartController.addItemToCart(item);
                            },
                            child: AddButton(
                              item: item,
                            ),
                          );
                  }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
