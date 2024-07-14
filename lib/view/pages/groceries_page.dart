import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/grocery_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/location_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/notification_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/select_location_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/vegetable_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/carousal_slider.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/category_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/offer_label.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/trending_cards.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/two_text_heading.dart';

class GroceriesPage extends StatefulWidget {
  const GroceriesPage({super.key});

  @override
  State<GroceriesPage> createState() => _GroceriesPageState();
}

class _GroceriesPageState extends State<GroceriesPage> {
  @override
  Widget build(BuildContext context) {
    final GroceryController controller = Get.put(GroceryController());
    final VendorController vendorController = Get.put(VendorController());
    final LocationController locationController = Get.put(LocationController());

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
              onTap: () {
                Get.to(
                  const SelectLocationPage(),
                );
              },
              child: Image.asset("assets/icons/location_icon.png")),
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
                    locationController.streetName.value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        locationController.countryName.value,
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
                  )),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.to(() => const NotificationPage());
                    },
                    child: Image.asset("assets/icons/notification_icon.png")),
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search bar
              TextfieldWithMic(
                hintText: "Vegetables, fruits...".tr,
                onTap: () {
                  Get.to(SearchPage());
                },
              ),

              kHiegth20,
              // Welcome card
              SPromoSliderWidget(),
              kHiegth20,

              // Trending card
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TwoTextHeading(heading: "Trending on Ontrend".tr),
                  // GestureDetector(onTap: () {}, child: Text('View All'))
                ],
              ),
              kHiegth25,
              SizedBox(
                height: 240.h,
                child: Obx(() {
                  if (controller.isProductLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (controller.productList.isEmpty) {
                    return Center(
                        child: Text('No trending products available.'));
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.productList.length,
                      itemBuilder: (context, index) {
                        final product = controller.productList[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to product details
                          },
                          child: TrendingCards(
                            imagePath: product.imageUrl,
                            name: product.name,
                            onTap: () {},
                            itemPrice: OfferLabel(
                              offerlabel:
                                  '${product.vID}% OFF', // Modify as per your needs
                              brandName:
                                  'Upto OMR ${product.price}', // Modify as per your needs
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),

              // Categories card
              TwoTextHeading(heading: "Categories".tr),
              kHiegth20,
              Padding(
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  height: 250, // Adjust the height based on your needs
                  child: Obx(
                    () => GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of rows
                        crossAxisSpacing: 10,
                        childAspectRatio:
                            0.75, // Adjust the aspect ratio based on your design
                      ),
                      itemCount: controller.categoryList
                          .length, //homeController.categories.length,
                      itemBuilder: (_, index) {
                        final category = controller.categoryList[index];
                        return CategoryCard(
                          categoryName: category.name,
                          categoryImage: category.image,
                          onTap: () => Get.to(
                            () => const Vegetable(
                              userId: "",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              kHiegth20,
              OneTextHeading(
                heading: "Store to explore".tr,
              ),
              kHiegth20,
              SizedBox(
                height: 300,
                child: Obx(() {
                  if (controller.storeList.isEmpty) {
                    log("stor to explore");
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.storeList.length,
                      itemBuilder: (context, index) {
                        final vendor = vendorController.vendorsListCat[index];
                        final store = controller.storeList[index];
                        return GestureDetector(
                          onTap: () {
                            // Handle tap on the store card ProfilePage()
                          },
                          child: ExploreCard(
                            image: store.image, // Placeholder image path
                            name: store.name,
                            onTap: () {},
                            locationCityCountry: '',
                            distance: vendorController
                                .calculateDistance(vendor.location),
                            latitude: vendor.location.lat,
                            longitude: vendor.location.lng,
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
