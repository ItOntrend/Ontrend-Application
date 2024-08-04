import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';

class ItemViewPage extends StatelessWidget {
  const ItemViewPage({
    super.key,
    required this.item,
  });

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final LanguageController lang = Get.find<LanguageController>();
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 321.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(item.imageUrl),
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 12,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: const BoxDecoration(
                        color: kWhite,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios_outlined),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lang.currentLanguage.value.languageCode == "ar"
                        ? item.localName
                        : item.name,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${"OMR".tr}  ${item.price}.000",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: kOrange,
                        ),
                      ),
                      kWidth20,
                      /* Text(
                        "${"OMR".tr} ${item.price + 50}", // Example original price
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: kGrey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),*/
                    ],
                  ),
                  Text(
                    addNewlines(item.description, 25),
                    style: const TextStyle(fontSize: 12),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     RatingBar.builder(
                  //       itemSize: 15,
                  //       allowHalfRating: true,
                  //       onRatingUpdate: (rating) {
                  //         print(rating);
                  //       },
                  //       itemBuilder: (context, _) => const Icon(
                  //         Icons.star,
                  //         color: kGreen,
                  //       ),
                  //       initialRating: 4.5, // Example rating
                  //     ),
                  //     kWidth20,
                  //   ],
                  // ),
                  kHiegth40,
                  Obx(() {
                    final quantity = cartController.getItemQuantity(item);
                    return quantity > 0
                        ? Center(
                            child: Container(
                              width: 140.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kGreen),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                            child: Center(
                              child: Container(
                                height: 50.h,
                                width: 180.w,
                                decoration: BoxDecoration(
                                  color: kOrange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Add to Cart'.tr,
                                    style: TextStyle(
                                        color: kWhite,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomAppBar(
          color: kTransparent,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: kGreen,
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${"Items in Cart:".tr} ${cartController.getItemCount()}',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: kWhite),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const AddToCartPage(
                          addedBy: '',
                          restaurantName: '',
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: kWhite,
                    backgroundColor: kWhite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  ),
                  child: Text(
                    'View Cart'.tr,
                    style: TextStyle(
                      color: kOrange,
                      decoration: TextDecoration.underline,
                      decorationColor: kOrange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String addNewlines(String text, int maxChars) {
    String result = '';
    for (int i = 0; i < text.length; i += maxChars) {
      if (i + maxChars < text.length) {
        result += text.substring(i, i + maxChars) + '\n';
      } else {
        result += text.substring(i);
      }
    }
    return result;
  }
}
