import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/food_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/location_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/estore/widgets/product_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/categorys_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/notification_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/profile_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/select_location_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/carousal_slider.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/home_search_result.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/shimmer_cetegory.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/shimmer_export.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/category_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/nearby_vendor_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/two_text_heading.dart';

final List<Map<String, String>> demoCategoryList = [
  {
    "name": "Laptop",
    "localName": "الفواكه",
    "imageUrl": "https://example.com/images/fruits.jpg",
  },
  {
    "name": "Air Conditioner",
    "localName": "الخضروات",
    "imageUrl": "https://example.com/images/vegetables.jpg",
  },
  {
    "name": "Mixi/Grinder",
    "localName": "منتجات الألبان",
    "imageUrl": "https://example.com/images/dairy.jpg",
  },
  {
    "name": "Printer",
    "localName": "اللحوم",
    "imageUrl": "https://example.com/images/meat.jpg",
  },
  {
    "name": "Smart Watch",
    "localName": "مخبز",
    "imageUrl": "https://example.com/images/bakery.jpg",
  },
  {
    "name": "Computer",
    "localName": "المشروبات",
    "imageUrl": "https://example.com/images/beverages.jpg",
  }
];

class EstorePage extends StatefulWidget {
  const EstorePage({
    super.key,
  });

  @override
  State<EstorePage> createState() => _EstorePageState();
}

class _EstorePageState extends State<EstorePage> {
  final LocationController locationController = Get.put(LocationController());
  final lang = Get.put(LanguageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            Get.to(
              const SelectLocationPage(),
            );
          },
          child: Padding(
            padding: (lang.currentLanguage.value.languageCode == 'ar')
                ? const EdgeInsets.only(right: 20)
                : const EdgeInsets.only(left: 20),
            child: Image.asset(
              "assets/icons/location_icon.png",
              width: 30,
              height: 30,
            ),
          ),
        ),
        title: GestureDetector(
          onTap: () {
            Get.to(
              const SelectLocationPage(),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                    locationController.subLocalityName.value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${locationController.cityName},${locationController.countryName.value}",
                      style: const TextStyle(
                        color: kBlue,
                        fontSize: 10,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const NotificationPage());
                  },
                  child: Image.asset("assets/icons/notification_icon.png"),
                ),
                kWidth25,
                GestureDetector(
                  onTap: () {
                    Get.to(const AddToCartPage(
                      addedBy: "",
                      restaurantName: "",
                    ));
                  },
                  child: Image.asset("assets/icons/cart_icon.png"),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar

              TextfieldWithMic(
                hintText: "Biryani, Burger, Ice Cream...".tr,
                //onChanged: , // Update suggestions
                //controller: _searchController,
                //onSubmitted: (query) {

                //},
              ),

              kHiegth15,
              // Welcome card
              SPromoSliderWidget(),
              kHiegth25,
              TwoTextHeading(
                  heading: lang.currentLanguage.value.languageCode == "ar"
                      ? "اصناف الطعام"
                      : "Categories"),
              kHiegth20,
              SizedBox(
                height: 300.h, // Make sure this height is appropriate
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: demoCategoryList.length,
                  itemBuilder: (context, index) {
                    final category = demoCategoryList[index];
                    return CategoryCard(
                      onTap: () {
                        Get.to(
                          () => ProductPage(),
                        );
                      },
                      categoryName:
                          lang.currentLanguage.value.languageCode == "ar"
                              ? category['localName']!
                              : category['name']!,
                      categoryImage: category['imageUrl']!,
                    );
                  },
                ),
              ),
              kHiegth25,
              TwoTextHeading(
                heading: "Trending".tr,
              ),
              kHiegth20,
              kHiegth40,
            ],
          ),
        ),
      ),
    );
  }
}
