import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/burger_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/notification_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/pizza_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/select_location_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/best_seller_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/offer_label.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/oru_service_big_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/oru_service_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/trending_cards.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/two_text_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/welcome_card_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset("assets/icons/location_icon.png"),
        ),
        title: GestureDetector(
          onTap: () {
            Get.to(
              SelectLocationPage(),
            );
          },
          child: const Column(
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
                    style: TextStyle(
                      color: kBlue,
                      fontSize: 10,
                    ),
                  ),
                  Icon(
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
                      Get.to(
                        const NotificationPage(),
                      );
                    },
                    child: Image.asset("assets/icons/notification_icon.png")),
                kWidth25,
                GestureDetector(
                    onTap: () {
                      Get.to(
                        const AddToCartPage(),
                      );
                    },
                    child: Image.asset("assets/icons/cart_icon.png"))
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const WelcomeCardHome(
                  image: "assets/image/home_trending_image.png",
                ),
                kHiegth25,
                // Our Service
                const OneTextHeading(
                  heading: "Our Service",
                ),
                kHiegth20,
                const OruServiceBigCard(
                  image: "assets/image/home_appliance_image.png",
                  name: "E Shop",
                ),
                kHiegth20,
                const Row(
                  children: [
                    OurServiceCard(
                      name: 'Groceries',
                      image: "assets/image/grocerry_image.png",
                    ),
                    kWidth20,
                    OurServiceCard(
                      name: 'Food',
                      image: "assets/image/service_food_image.png",
                    ),
                  ],
                ),
                kHiegth20,
                // Trending card
                const TwoTextHeading(
                  heading: "Trending on Ontrend",
                ),
                kHiegth20,
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
                        child: const TrendingCards(
                          image: "assets/image/trending_image_1.png",
                          offerLabel: OfferLabel(
                            offerlabel: "50% OFF",
                          ),
                          brandName: "La Pino’z Pizza",
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
                          image: "assets/image/trending_image_2.png",
                          offerLabel: OfferLabel(offerlabel: "40% OFF"),
                          brandName: "Dough & Cream",
                        ),
                      ),
                      kWidth20,
                      const TrendingCards(
                        image: "assets/image/trending_image_3.png",
                        offerLabel: OfferLabel(offerlabel: "10% OFF"),
                        brandName: "Paneer",
                      ),
                      kWidth20,
                    ],
                  ),
                ),

                const OneTextHeading(
                  heading: "Best Seller",
                ),
                kHiegth20,
                SizedBox(
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      BestSellerCard(
                        title: "Up to 40% OFF",
                        description: "On Kitchen Appliances",
                        imagePath: "assets/image/bestseller_image.png",
                      ),
                      kWidth20,
                      BestSellerCard(
                        title: "Up to 70% OFF",
                        description: "On Kitchen Appliances",
                        imagePath: "assets/image/bestseller2_image.png",
                      ),
                      kWidth20,
                      BestSellerCard(
                        title: "Up to 60% OFF",
                        description: "On Kitchen Appliances",
                        imagePath: "assets/image/bestseller_image.png",
                      ),
                      kWidth20,
                      BestSellerCard(
                        title: "Up to 20% OFF",
                        description: "On Kitchen Appliances",
                        imagePath: "assets/image/bestseller2_image.png",
                      ),
                      kWidth20,
                    ],
                  ),
                ),
                kHiegth10,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
