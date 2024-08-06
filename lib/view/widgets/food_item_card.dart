import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/model/order_modal.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/item_view_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/add_button.dart';

class FoodItemCard extends StatefulWidget {
  const FoodItemCard({
    super.key,
    required this.item,
  });

  final ProductModel item;

  @override
  _FoodItemCardState createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  final CartController cartController = Get.find<CartController>();
  final LanguageController languageController = Get.find<LanguageController>();

  // Function to add newline characters after every 30 characters
  String addNewlines(String text, int maxChars) {
    String result = '';
    int start = 0;

    while (start < text.length) {
      int end = start + maxChars;

      // Ensure we don't go out of bounds
      if (end >= text.length) {
        result += text.substring(start);
        break;
      }

      // If there is a space before the maxChars limit, break at the space
      int spaceIndex = text.lastIndexOf(' ', end);
      if (spaceIndex > start) {
        result += text.substring(start, spaceIndex) + '\n';
        start = spaceIndex + 1;
      } else {
        // If no space is found, break at maxChars limit
        result += text.substring(start, end) + '\n';
        start = end;
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

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
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Obx(() {
            final isEnglish =
                languageController.currentLanguage.value.languageCode == 'en';
            return Align(
              alignment: isEnglish ? Alignment.topRight : Alignment.topLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onTap: () => Get.to(() => ItemViewPage(item: item)),
                  child: Stack(
                    children: [
                      item.imageUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: item.imageUrl,
                              fit: BoxFit.cover,
                              height: 100.h,
                              width: 150.w,
                            )
                          : Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              height: 100.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  color: kLiteBackground,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  "No image available",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 210.w,
                    child: Text(
                      languageController.currentLanguage.value.languageCode ==
                              "ar"
                          ? item.localName
                          : item.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Text(
                item.price.toStringAsFixed(3),
                style: const TextStyle(
                  fontSize: 14,
                  color: kOrange,
                ),
              ),
              SizedBox(
                height: 61.h,
                child: Text(
                  addNewlines(item.description, 25),
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
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
