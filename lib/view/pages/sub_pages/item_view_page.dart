import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';

class ItemViewPage extends StatefulWidget {
  ItemViewPage({
    super.key,
    required this.item,
  });

  final ProductModel item;

  @override
  State<ItemViewPage> createState() => _ItemViewPageState();
}

class _ItemViewPageState extends State<ItemViewPage> {
  final RxString selectedVariant = ''.obs;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final LanguageController lang = Get.find<LanguageController>();
    return Scaffold(
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        child: SafeArea(
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
                        image: NetworkImage(widget.item.imageUrl),
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
                          ? widget.item.localName
                          : widget.item.name,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "OMR ${widget.item.price == 0.0 ? widget.item.itemPrice.toStringAsFixed(3) : widget.item.price.toStringAsFixed(3)}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: kOrange,
                          ),
                        ),
                        kWidth20,
                      ],
                    ),
                    Text(
                      widget.item.description,
                      style: const TextStyle(fontSize: 12),
                    ),
                    kHiegth40,
                    ...widget.item.variants.keys.map((key) {
                      return Obx(() {
                        return Row(
                          children: [
                            Text('$key'),
                            Spacer(),
                            Text('(OMR ${widget.item.variants[key]['price']})'),
                            Radio<String>(
                              value: key,
                              groupValue: selectedVariant.value,
                              onChanged: (value) {
                                selectedVariant.value = value!;
                              },
                            ),
                          ],
                        );
                      });
                    }),
                    kHiegth18,
                    Obx(() {
                      final quantity =
                          cartController.getItemQuantity(widget.item);
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
                                        cartController
                                            .removeItemFromCart(widget.item);
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
                                        cartController
                                            .addItemToCart(widget.item);
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
                                cartController.addItemToCart(widget.item);
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
}
