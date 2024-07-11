import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/best_seller_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/food_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/categorys_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/notification_page.dart';
// import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/pizza_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/profile_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/select_location_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/best_seller_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/category_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
// import 'package:ontrend_food_and_e_commerce/view/widgets/offer_label.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
// import 'package:ontrend_food_and_e_commerce/view/widgets/trending_cards.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/two_text_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/welcome_card_food.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({
    super.key,
    required this.userId,
  });
  final String userId;

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final foodController = Get.find<FoodController>();
  final BestSellerController bestSellerController =
      Get.put(BestSellerController());
  final VendorController vendorController = Get.put(VendorController());
  final LocationController locationController = Get.put(LocationController());

  @override
  void initState() {
    super.initState();
    foodController.getCategories();
    bestSellerController.getBestSeller();
    vendorController.getVendors(widget.userId);
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
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset(
              "assets/icons/location_icon.png",
            ),
          ),
        ),
        title: GestureDetector(
          onTap: () {
            Get.to(() => const SelectLocationPage());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locationController.streetName.value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${locationController.cityName.value}, ${locationController.countryName.value}",
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
                    Get.to(() => const AddToCartPage(
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
                hintText: "Biryani, Burger, Ice Cream...",
                onTap: () {
                  Get.to(const SearchPage());
                },
              ),
              kHiegth15,
              // Welcome card
              const WelcomeCardFood(
                image: "assets/image/offer_image.png",
                // Colors.orange.shade100,
              ),
              kHiegth25,

              // Trending card
              // const TwoTextHeading(heading: "Trending on Ontrend"),
              // kHiegth25,
              // SizedBox(
              //   height: 260,
              //   child: ListView(
              //     // This next line does the trick.
              //     scrollDirection: Axis.horizontal,
              //     children: <Widget>[
              //       GestureDetector(
              //         onTap: () {
              //           Get.to(
              //             const PizzaSearchPage(),
              //           );
              //         },
              //         child: GestureDetector(
              //           onTap: () {
              //             Get.to(
              //               const PizzaSearchPage(),
              //             );
              //           },
              //           child: const TrendingCards(
              //             image: "assets/image/trending_image_1.png",
              //             offerLabel: OfferLabel(offerlabel: "50% OFF"),
              //             brandName: "Pizza Hut",
              //           ),
              //         ),
              //       ),
              //       kWidth20,
              //       GestureDetector(
              //         onTap: () {
              //           Get.to(
              //             const BurgerSearchPage(),
              //           );
              //         },
              //         child: const TrendingCards(
              //           image: "assets/image/trending_image_2.png",
              //           offerLabel: OfferLabel(offerlabel: "40% OFF"),
              //           brandName: "Dough & Cream",
              //         ),
              //       ),
              //       kWidth20,
              //       GestureDetector(
              //         onTap: () {
              //           Get.to(
              //             const BurgerSearchPage(),
              //           );
              //         },
              //         child: const TrendingCards(
              //           image: "assets/image/trending_image_3.png",
              //           offerLabel: OfferLabel(offerlabel: "10% OFF"),
              //           brandName: "Paneer",
              //         ),
              //       ),
              //       kWidth20,
              //     ],
              //   ),
              // ),

              // Categories card
              const TwoTextHeading(heading: "Categories"),
              kHiegth20,
              Obx(
                () => foodController.isCategoryLoading.value
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        height: 100, // Adjust the height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: foodController.categoryList.length,
                          itemBuilder: (context, index) {
                            final category = foodController.categoryList[index];
                            log(category.image.toString());
                            return CategoryCard(
                              onTap: () {
                                Get.to(() => CategorysSearchPage(
                                      userId: widget.userId,
                                      categoryName: category.name,
                                    ));
                              },
                              categoryName: category.name,
                              categoryImage: category.image,
                            );
                          },
                        ),
                      ),
              ),
              kHiegth20,
              const OneTextHeading(
                heading: "Best Sellers",
              ),
              kHiegth20,
              Obx(
                () => bestSellerController.isBestSellerLoading.value
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: bestSellerController.bestSellerList.length,
                          itemBuilder: (context, index) {
                            final bestSeller =
                                bestSellerController.bestSellerList[index];
                            log(bestSeller.image.toString());
                            log("Best Seller Image is calling");
                            return BestSellerCard(
                              onTap: () {
                                Get.to(() => ProfilePage(
                                      userId: bestSeller.addedBy,
                                    ));
                              },
                              name: bestSeller.name,
                              imagePath: bestSeller.image,
                              price: bestSeller.price,
                              vendor: bestSeller.restaurantName,
                            );
                          },
                        ),
                      ),
              ),
              kHiegth20,
              const OneTextHeading(
                heading: "Restaurants to explore",
              ),
              kHiegth20,
              Obx(
                () => vendorController.isVendorLoading.value
                    ? const CircularProgressIndicator()
                    : vendorController.vendorsList.isEmpty
                        ? const Center(child: Text("No Vendor Available"))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: vendorController.vendorsList.length,
                            itemBuilder: (context, index) {
                              final vendor =
                                  vendorController.vendorsList[index];
                              log("Vendor Images");

                              log(vendor.bannerImage.toString());
                              return ExploreCard(
                                name: vendor.restaurantName,
                                image: vendor.bannerImage,
                                onTap: () {
                                  log(vendor.reference.id);
                                  Get.to(
                                    () => ProfilePage(
                                        userId: vendor.reference.id),
                                  );
                                },
                              );
                            },
                          ),
              ),
              kHiegth140,
            ],
          ),
        ),
      ),
    );
  }
}
