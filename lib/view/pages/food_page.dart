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
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/offer_label.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/trending_cards.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/two_text_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/welcome_card_food.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // Search bar
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Image.asset("assets/icons/search_icon.png"),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.grey.shade400,
                        width: 1,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      Image.asset("assets/icons/mic_icon.png"),
                    ],
                  ),
                  hintText: "Biryani, Burger, Ice Cream.........",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
              ),
              kHiegth15,
              // Welcome card
              const WelcomeCardFood(
                image: "assets/image/offer_image.png",
                // Colors.orange.shade100,
              ),
              kHiegth25,

              // Trending card
              const TwoTextHeading(heading: "Trending on Ontrend"),
              kHiegth25,
              SizedBox(
                height: 260,
                child: Expanded(
                  child: ListView(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    children: const <Widget>[
                      TrendingCards(
                        image: "assets/image/trending_image_1.png",
                        offerLabel: OfferLabel(offerlabel: "50% OFF"),
                        brandName: "La Pino’z Pizza",
                      ),
                      kWidth20,
                      TrendingCards(
                        image: "assets/image/trending_image_2.png",
                        offerLabel: OfferLabel(offerlabel: "40% OFF"),
                        brandName: "Dough & Cream",
                      ),
                      kWidth20,
                      TrendingCards(
                        image: "assets/image/trending_image_3.png",
                        offerLabel: OfferLabel(offerlabel: "10% OFF"),
                        brandName: "Paneer",
                      ),
                      kWidth20,
                    ],
                  ),
                ),
              ),

              // Categories card
              const TwoTextHeading(heading: "Categories"),
              kHiegth20,
              SizedBox(
                height: 250,
                child: Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            const BurgerSearchPage(),
                          );
                        },
                        child: const SizedBox(
                          height: 180,
                          width: 120,
                          child: CategoryCard(
                            categoryImage: "assets/image/burger_image.png",
                            categoryName: "Burger",
                            categoryName1: "Puttu",
                            categoryImage1: "assets/image/puttu_image.png",
                          ),
                        ),
                      ),
                      kWidth35,
                      const SizedBox(
                        height: 180,
                        width: 120,
                        child: CategoryCard(
                          categoryImage: "assets/image/cake_image.png",
                          categoryName: "Cake",
                          categoryName1: "Chinese",
                          categoryImage1: "assets/image/chinese_image.png",
                        ),
                      ),
                      kWidth35,
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            const PizzaSearchPage(),
                          );
                        },
                        child: const SizedBox(
                          height: 180,
                          width: 120,
                          child: CategoryCard(
                            categoryImage: "assets/image/pizza_image.png",
                            categoryName: "Pizza",
                            categoryName1: "Idli",
                            categoryImage1: "assets/image/idli_image.png",
                          ),
                        ),
                      ),
                      kWidth35,
                      const SizedBox(
                        height: 180,
                        width: 120,
                        child: CategoryCard(
                          categoryImage: "assets/image/burger_image.png",
                          categoryName: "Burger",
                          categoryName1: "Puttu",
                          categoryImage1: "assets/image/puttu_image.png",
                        ),
                      ),
                      kWidth35,
                      const SizedBox(
                        height: 180,
                        width: 120,
                        child: CategoryCard(
                          categoryImage: "assets/image/cake_image.png",
                          categoryName: "Cake",
                          categoryName1: "Chinese",
                          categoryImage1: "assets/image/chinese_image.png",
                        ),
                      ),
                      kWidth35,
                      const SizedBox(
                        height: 180,
                        width: 120,
                        child: CategoryCard(
                          categoryImage: "assets/image/pizza_image.png",
                          categoryName: "Pizza",
                          categoryName1: "Idli",
                          categoryImage1: "assets/image/idli_image.png",
                        ),
                      ),
                    ],
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                child: const ExploreCard(
                  image: "assets/image/Dominos_card_image.png",
                ),
              ),
              kHiegth20,
              const ExploreCard(
                image: "assets/image/explore_image.png",
              ),
              kHiegth20,
              const ExploreCard(
                image: "assets/image/explore_image_two.png",
              ),
              kHiegth20,
            ],
          ),
        ),
      ),
    );
  }
}
