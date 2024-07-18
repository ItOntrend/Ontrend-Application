import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/grocery_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/location_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/categorys_search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/notification_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/profile_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/select_location_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/carousal_slider.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/search_result.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/category_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
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
  final CartController cartController = Get.put(CartController());
  List<ItemModel> searchSuggestions = [];

  @override
  void initState() {
    super.initState();
    controller.getProducts();
    vendorController.fetchVendors('Grocery');
    vendorController.getItems('Grocery');
  }

  void _updateSearchSuggestions(String query) async {
    if (query.isNotEmpty) {
      // Fetch suggestions from the controller
      final products = await controller.searchProducts(query);

      setState(() {
        searchSuggestions = products;
      });
    } else {
      setState(() {
        searchSuggestions = [];
      });
    }
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
        title: GestureDetector(
          onTap: () {
            Get.to(SelectLocationPage());
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
              ),
            ],
          ),
        ),
        actions: [
          Obx(
            () => Padding(
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
                  Badge.count(
                    count: cartController.getItemCount(),
                    backgroundColor: kDarkOrange,
                    textColor: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const AddToCartPage(
                          addedBy: "",
                          restaurantName: "",
                        ));
                      },
                      child: Image.asset("assets/icons/cart_icon.png"),
                    ),
                  ),
                ],
              ),
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
                onChanged: _updateSearchSuggestions, // Update suggestions
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    controller.searchProducts(query).then((products) {
                      Get.to(() => SearchResult(
                            products: products,
                            title: "Search Result",
                          ));
                    });
                  }
                },
              ),
              if (searchSuggestions.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchSuggestions.length,
                  itemBuilder: (context, index) {
                    final item = searchSuggestions[index];
                    return ListTile(
                      title: Text(item.name),
                      onTap: () {
                        if (item.name.isNotEmpty) {
                          controller.searchProducts(item.name).then((products) {
                            Get.to(() => SearchResult(
                                products: products, title: 'Grocery'));
                          });
                        }
                      },
                    );
                  },
                ),
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
                        return CategoryCard(
                          categoryImage: category.imageUrl, //category.imageUrl,
                          categoryName: languageController
                                      .currentLanguage.value.languageCode ==
                                  "ar"
                              ? category.localName
                              : category.name,
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
              Obx(
                () => vendorController.isVendorLoading.value
                    ? const CircularProgressIndicator()
                    : vendorController.vendorsListCat.isEmpty
                        ? Center(child: Text("No Vendor Available".tr))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: vendorController.vendorsListCat.length,
                            itemBuilder: (context, index) {
                              final vendor =
                                  vendorController.vendorsListCat[index];
                              //log("Vendor Images");

                              //log(vendor.bannerImage.toString());
                              return ExploreCard(
                                latitude: vendor.location.lat,
                                longitude: vendor.location.lng,
                                locationCityCountry: "",
                                distance: vendorController
                                    .calculateDistance(vendor.location),
                                name: vendor.restaurantName,
                                image: vendor.bannerImage,
                                onTap: () {
                                  //log(vendor.reference.id);
                                  Get.to(
                                    () => ProfilePage(
                                      userId: vendor.reference.id,
                                      type: 'Grocery',
                                      cat: "",
                                    ),
                                  );
                                },
                              );
                            },
                          ),
              ),
              kHiegth30,
            ],
          ),
        ),
      ),
    );
  }
}
