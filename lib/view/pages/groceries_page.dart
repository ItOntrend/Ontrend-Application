import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/controller/grocery_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/notification_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/vegetable_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/carousal_slider.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/vertical_image_text.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/category_card.dart';
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
    final GroceryController controller = Get.put(GroceryController());
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
                    //Get.to(AddToCartPage(addedBy: ,));
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
              const TextfieldWithMic(
                hintText: "Vegetables, fruits...",
              ),

              kHiegth20,
              // Welcome card
              /* const WelcomeCardGroceries(
                image: "assets/image/groceries_card_image.png",
                // Colors.orange.shade100,
              ),*/
              SPromoSliderWidget(),
              kHiegth20,

              // Trending card
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TwoTextHeading(heading: "Trending on Ontrend"),
                  GestureDetector(onTap: () {}, child: Text('View All'))
                ],
              ),
              kHiegth25,
              Obx(() {
                if (controller.isProductLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.productList.isEmpty) {
                  return Center(child: Text('No trending products available.'));
                } else {
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
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
                    ),
                  );
                }
              }),

              // Categories card
              const TwoTextHeading(heading: "Categories"),
              kHiegth20,
              Padding(
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  height: 250, // Adjust the height based on your needs
                  child: Obx(
                    () => GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of rows
                        crossAxisSpacing: 10,
                        childAspectRatio:
                            0.75, // Adjust the aspect ratio based on your design
                      ),
                      itemCount: controller.categoryList
                          .length, //homeController.categories.length,
                      itemBuilder: (_, index) {
                        final category = controller.categoryList[index];
                        return SVerticalImageTextWidget(
                          image: category.image, //category.imageUrl,
                          categoryType: category.name,
                          onTap: () => Get.to(() => Vegetable()),
                        );
                      },
                    ),
                  ),
                ),
              ),
              kHiegth20,
              const OneTextHeading(
                heading: "Store to explore",
              ),
              kHiegth20,
              SizedBox(
                height: 300,
                child: Obx(() {
                  if (controller.storeList.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.storeList.length,
                      itemBuilder: (context, index) {
                        final store = controller.storeList[index];
                        return GestureDetector(
                          onTap: () {
                            // Handle tap on the store card ProfilePage()
                          },
                          child: ExploreCard(
                            image: store.image, // Placeholder image path
                            name: store.name,
                            onTap: () {},
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
