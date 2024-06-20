import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/offers_and_benefits_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/add_to_cart_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/adding_more_item_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/bill_details_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';

class AddToCartPage extends StatefulWidget {
  const AddToCartPage({super.key});

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Row(
          children: [
            Image.asset("assets/icons/location_icon.png"),
            kWidth10,
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Janub Ad Dahariz",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Salala, Oman",
                      style: TextStyle(color: kBlue, fontSize: 10),
                    ),
                    Icon(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 11,
                ),
                height: 341.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kLiteBackground,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  border: Border.all(color: kGrey.shade400),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AddToCartCard(
                      itemName: "Mango Shake",
                      itemPrice: "OMR 120",
                      image: "assets/image/add_to_cart_image.png",
                    ),
                    kHiegth9,
                    AddToCartCard(
                      itemName: "Tomato Pizza",
                      itemPrice: "OMR 100",
                      image: "assets/image/add_to_cart_image_two.png",
                    ),
                    kHiegth9,
                    AddingMoreItemCard(),
                  ],
                ),
              ),
              OneTextHeading(heading: "Offers & Benefits"),
              kHiegth15,
              OffersAndBenefitsCard(),
              kHiegth15,
              OneTextHeading(heading: "Bill Details"),
              kHiegth15,
              BillDetailsCard(),
              kHiegth15,
              Container(
                height: 64.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: kGrey,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              kHiegth20,
            ],
          ),
        ),
      ),
    );
  }
}
