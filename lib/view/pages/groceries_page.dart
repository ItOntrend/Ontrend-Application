import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/burger_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/notification_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/pizza_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/profile_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/category_card.dart';
// import 'package:ontrend_food_and_e_commerce/view/widgets/category_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/offer_label.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/trending_cards.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/two_text_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/welcome_card_groceries.dart';

class GroceriesPage extends StatelessWidget {
  const GroceriesPage({super.key});

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
                hintText: "Vegetables, fruits...",
              ),
              kHiegth15,
              // Welcome card
              const WelcomeCardGroceries(
                image: "assets/image/groceries_card_image.png",
                // Colors.orange.shade100,
              ),
              kHiegth25,

              // Trending card
              const TwoTextHeading(heading: "Trending on Ontrend"),
              kHiegth25,
              SizedBox(
                height: 260,
                child: ListView(
                  // This next line does the trick.
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          const PizzaSearchPage(),
                        );
                      },
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            const BurgerSearchPage(),
                          );
                        },
                        child: const TrendingCards(
                          image: "assets/image/potato_image.png",
                          offerLabel: OfferLabel(offerlabel: "40% OFF"),
                          brandName: "Potato",
                        ),
                      ),
                    ),
                    kWidth20,
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          const PizzaSearchPage(),
                        );
                      },
                      child: const TrendingCards(
                        image: "assets/image/apple_image.png",
                        offerLabel: OfferLabel(offerlabel: "40% OFF"),
                        brandName: "Apple",
                      ),
                    ),
                    kWidth20,
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          const BurgerSearchPage(),
                        );
                      },
                      child: const TrendingCards(
                        image: "assets/image/potato_image.png",
                        offerLabel: OfferLabel(offerlabel: "10% OFF"),
                        brandName: "Potato",
                      ),
                    ),
                    kWidth20,
                  ],
                ),
              ),

              // Categories card
              const TwoTextHeading(heading: "Categories"),
              kHiegth20,
              SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          const BurgerSearchPage(),
                        );
                      },
                      child: SizedBox(
                        height: 180,
                        width: 120,
                        child: CategoryCard(
                          onTap: () {},
                          categoryImage: "assets/image/vagetables_image.png",
                          categoryName: "Fresh Vegetables",
                        ),
                      ),
                    ),
                    kWidth35,
                    SizedBox(
                      height: 180,
                      width: 120,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            const PizzaSearchPage(),
                          );
                        },
                        child: CategoryCard(
                          onTap: () {},
                          categoryImage: "assets/image/fruits_image.png",
                          categoryName: "Fresh Fruits",
                        ),
                      ),
                    ),
                    kWidth35,
                    SizedBox(
                      height: 180,
                      width: 120,
                      child: CategoryCard(
                        onTap: () {},
                        categoryImage: "assets/image/bread_image.png",
                        categoryName: "Bread and Milk",
                      ),
                    ),
                    kWidth35,
                    SizedBox(
                      height: 180,
                      width: 120,
                      child: CategoryCard(
                        onTap: () {},
                        categoryImage: "assets/image/vagetables_image.png",
                        categoryName: "Fresh Vagetables",
                      ),
                    ),
                    kWidth35,
                    SizedBox(
                      height: 180,
                      width: 120,
                      child: CategoryCard(
                        onTap: () {},
                        categoryImage: "assets/image/fruits_image.png",
                        categoryName: "Fresh Fruits",
                      ),
                    ),
                    kWidth35,
                    SizedBox(
                      height: 180,
                      width: 120,
                      child: CategoryCard(
                        onTap: () {},
                        categoryImage: "assets/image/bread_image.png",
                        categoryName: "Bread and Milk",
                      ),
                    ),
                  ],
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
                  image: "assets/image/bazar_market_image.png",
                  tabIndex: 3,
                ),
              ),
              kHiegth20,
              const ExploreCard(
                image: "assets/image/Ramco_market_image.png",
                tabIndex: 3,
              ),
              kHiegth20,
              const ExploreCard(
                image: "assets/image/pk_store_image.png",
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
