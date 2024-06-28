import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/food_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/burger_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/notification_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/pizza_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/profile_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/category_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/offer_label.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/trending_cards.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/two_text_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/welcome_card_food.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final foodController = Get.find<FoodController>();
  @override
  void initState() {
    super.initState();
    foodController.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset("assets/icons/location_icon.png"),
        ),
        title: const Column(
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.to(const NotificationPage());
                    },
                    child: Image.asset("assets/icons/notification_icon.png")),
                kWidth25,
                GestureDetector(
                  onTap: () {
                    Get.to(const AddToCartPage());
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
            children: [
              // Search bar
              const TextfieldWithMic(
                hintText: "Biryani, Burger, Ice Cream...",
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
                                Get.to(const BurgerSearchPage());
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
                heading: "Restaurants to explore",
              ),
              kHiegth20,
              GestureDetector(
                onTap: () {
                  Get.to(
                    const ProfilePage(),
                  );
                },
                child: const ExploreCard(
                  image: "assets/image/Dominos_card_image.png",
                  tabIndex: 3,
                ),
              ),
              kHiegth20,
              const ExploreCard(
                image: "assets/image/explore_image.png",
                tabIndex: 3,
              ),
              kHiegth20,
              const ExploreCard(
                image: "assets/image/explore_image_two.png",
                tabIndex: 3,
              ),
              kHiegth20,
            ],
          ),
        ),
      ),
    );
  }
}

// : ListView(
                    //     scrollDirection: Axis.horizontal,
                    //     children: <Widget>[
                    //       GestureDetector(
                    //         onTap: () {
                    //           Get.to(
                    //             const BurgerSearchPage(),
                    //           );
                    //         },
                    //         child: const SizedBox(
                    //           height: 180,
                    //           width: 120,
                    //           child: CategoryCard(
                    //             categoryImage:
                    //                 "assets/image/burger_image.png",
                    //             categoryName: "Burger",
                    //             categoryName1: "Puttu",
                    //             categoryImage1:
                    //                 "assets/image/puttu_image.png",
                    //           ),
                    //         ),
                    //       ),
                    //       kWidth35,
                    //       SizedBox(
                    //         height: 180,
                    //         width: 120,
                    //         child: GestureDetector(
                    //           onTap: () {
                    //             Get.to(
                    //               const PizzaSearchPage(),
                    //             );
                    //           },
                    //           child: const CategoryCard(
                    //             categoryImage: "assets/image/pizza_image.png",
                    //             categoryName: "Pizza",
                    //             categoryName1: "Idli",
                    //             categoryImage1: "assets/image/idli_image.png",
                    //           ),
                    //         ),
                    //       ),
                    //       kWidth35,
                    //       const SizedBox(
                    //         height: 180,
                    //         width: 120,
                    //         child: CategoryCard(
                    //           categoryImage: "assets/image/cake_image.png",
                    //           categoryName: "Cake",
                    //           categoryName1: "Chinese",
                    //           categoryImage1:
                    //               "assets/image/chinese_image.png",
                    //         ),
                    //       ),
                    //       kWidth35,
                    //       const SizedBox(
                    //         height: 180,
                    //         width: 120,
                    //         child: CategoryCard(
                    //           categoryImage: "assets/image/burger_image.png",
                    //           categoryName: "Burger",
                    //           categoryName1: "Puttu",
                    //           categoryImage1: "assets/image/puttu_image.png",
                    //         ),
                    //       ),
                    //       kWidth35,
                    //       const SizedBox(
                    //         height: 180,
                    //         width: 120,
                    //         child: CategoryCard(
                    //           categoryImage: "assets/image/cake_image.png",
                    //           categoryName: "Cake",
                    //           categoryName1: "Chinese",
                    //           categoryImage1:
                    //               "assets/image/chinese_image.png",
                    //         ),
                    //       ),
                    //       kWidth35,
                    //       const SizedBox(
                    //         height: 180,
                    //         width: 120,
                    //         child: CategoryCard(
                    //           categoryImage: "assets/image/pizza_image.png",
                    //           categoryName: "Pizza",
                    //           categoryName1: "Idli",
                    //           categoryImage1: "assets/image/idli_image.png",
                    //         ),
                    //       ),
                    //     ],
                    //   ),
