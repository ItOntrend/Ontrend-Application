import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/grocery_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/location_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/categorys_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/notification_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/profile_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/select_location_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/carousal_slider.dart';

import 'package:ontrend_food_and_e_commerce/view/pages/widgets/vertical_image_text.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/best_seller_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/offer_label.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/trending_cards.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/two_text_heading.dart';

class GroceriesPage extends StatefulWidget {
  GroceriesPage({Key? key}) : super(key: key);

  @override
  State<GroceriesPage> createState() => _GroceriesPageState();
}

class _GroceriesPageState extends State<GroceriesPage> {
  final VendorController vendorController = Get.put(VendorController());
  final GroceryController controller = Get.put(GroceryController());
  final LanguageController languageController = Get.put(LanguageController());
  @override
  void initState() {
    super.initState();
    vendorController.fetchVendors('Grocery');
  }

  @override
  Widget build(BuildContext context) {
    final LocationController locationController = Get.put(LocationController());

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            Get.to(() => SelectLocationPage());
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset("assets/icons/location_icon.png"),
          ),
        ),
        title: Column(
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search bar
              TextfieldWithMic(
                  hintText: "Vegetables, fruits...".tr,
                  onTap: () => () => Get.to(() => SearchPage())),
              kHiegth20,
              // Welcome card
              SPromoSliderWidget(),
              kHiegth20,
              // Trending card

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
                        return SVerticalImageTextWidget(
                          image: category.imageUrl, //category.imageUrl,
                          categoryType: category.name,
                          onTap: () => Get.to(() => CategorysSearchPage(
                                category: category,
                                type: 'Grocery',
                              )),
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
              FutureBuilder<void>(
                future:
                    vendorController.fetchVendorsCat("Grocery", "Fresh Fruits"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error fetching vendors"));
                  } else {
                    return Obx(
                      () => vendorController.vCat.isEmpty
                          ? const Center(child: Text("No Vendor Available"))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: vendorController.vCat.length,
                              itemBuilder: (context, index) {
                                final vendor = vendorController.vCat[index];
                                return ExploreCard(
                                  longitude: vendor.location.lng,
                                  latitude: vendor.location.lat,
                                  locationCityCountry: '',
                                  distance: vendorController
                                      .calculateDistance(vendor.location),
                                  name: vendor.restaurantName,
                                  image: vendor.bannerImage,
                                  onTap: () {
                                    Get.to(() => ProfilePage(
                                          userId: vendor.reference.id,
                                          cat: "Fresh Fruits",
                                          type: "Grocery",
                                        ));
                                  },
                                );
                              },
                            ),
                    );
                  }
                },
              ),
              kWidth140
            ],
          ),
        ),
      ),
    );
  }
}
