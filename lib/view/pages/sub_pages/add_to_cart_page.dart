import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/location_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/order_complete_splash_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/select_location_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/offers_and_benefits_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/add_to_cart_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/adding_more_item_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/bill_details_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/terms_and_condition.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';

class AddToCartPage extends StatefulWidget {
  final String addedBy;
  final String selectedVariant;
  final double price;
  final String restaurantName;
  const AddToCartPage({
    super.key,
    required this.addedBy,
    required this.restaurantName,
    required this.selectedVariant,
    required this.price,
  });

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  final LocationController locationController = Get.put(LocationController());
  final CartController cartController = Get.put(CartController());
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    String addedBy = widget.addedBy;

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Obx(
          () => GestureDetector(
            onTap: () {
              Get.to(const SelectLocationPage());
            },
            child: Row(
              children: [
                Image.asset("assets/icons/location_icon.png"),
                kWidth10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locationController.subLocalityName.value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${locationController.cityName.value},${locationController.countryName.value}",
                          style: const TextStyle(color: kBlue, fontSize: 10),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Obx(() {
            bool hasItems = cartController.cartItems.isNotEmpty;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasItems) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kBorderLiteBlack),
                    ),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartController.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartController.cartItems.values
                                .toList()[index]['item'];
                            return AddToCartCard(
                              item: item,
                              price: widget.price,
                              selectedVariant: widget.selectedVariant,
                            );
                          },
                        ),
                        kHiegth9,
                        AddingMoreItemCard(
                          addedBy: addedBy,
                        ),
                      ],
                    ),
                  ),
                  OneTextHeading(
                    heading: "Offers & Benefits".tr,
                  ),
                  kHiegth15,
                  const OffersAndBenefitsCard(),
                  kHiegth15,
                  OneTextHeading(
                    heading: "Bill Details".tr,
                  ),
                  kHiegth15,
                  BillDetailsCard(),
                  kHiegth15,
                  const TermsAndCondition(),
                  kHiegth20,
                ] else ...[
                  kHiegth140,
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "No items found in the cart.".tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        kHiegth24,
                        ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(kWhite)),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "Add Items to Cart".tr,
                            style: TextStyle(color: kDarkOrange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: cartController.cartItems.isEmpty
          ? SizedBox()
          : Container(
              height: 86.h,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Obx(() {
                    double minOrderAmount = 2.0;
                    double itemTotal = cartController.itemTotal.toDouble();
                    double balance = minOrderAmount - itemTotal;

                    if (balance > 0) {
                      return Text(
                        "${balance.toStringAsFixed(3)} OMR to place order",
                        style: TextStyle(fontSize: 14.sp, color: kGrey),
                      );
                    } else {
                      return SizedBox(height: 14.sp);
                    }
                  }),
                  MainBotton(
                    onTap: () async {
                      log("Place Order".tr);
                      String userId = await LocalStorage.instance
                          .dataFromPrefs(key: HiveKeys.userData);
                      log(userId);
                      double itemTotal = cartController.itemTotal.toDouble();

                      if (locationController.currentAddress.value.isEmpty ||
                          locationController.streetName.value.isEmpty ||
                          locationController.cityName.value.isEmpty ||
                          locationController.countryName.value.isEmpty) {
                        Get.snackbar(
                          "Location Required".tr,
                          "You haven't selected your location".tr,
                          backgroundColor: kDarkOrange,
                          colorText: Colors.white,
                          mainButton: TextButton(
                            onPressed: () {
                              Get.to(const SelectLocationPage());
                            },
                            child: Text(
                              "Select Location",
                              style: GoogleFonts.aDLaMDisplay(
                                  fontSize: 14, color: kWhite),
                            ),
                          ),
                        );
                        return;
                      }

                      if (itemTotal > 2) {
                        String orderId = await cartController.placeOrder(
                          userId,
                          'Cash on Delivery',
                          userController.firstName.value,
                          userController.number.value,
                        );

                        Get.to(() => OrderCompleteSplashPage(orderId: orderId));
                        log("Order placed");
                      } else {
                        Get.snackbar(
                          "Minimum Order Amount".tr,
                          "The item total must be at least 2 OMR".tr,
                          backgroundColor: kDarkOrange,
                          colorText: Colors.white,
                        );
                        return;
                      }
                    },
                    name: "Place Order".tr,
                  ),
                ],
              ),
            ),
    );
  }
}
