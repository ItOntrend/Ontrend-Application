import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/food_controller.dart';
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
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/select_location_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/carousal_slider.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/home_search_result.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/shimmer_cetegory.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/shimmer_export.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/category_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/two_text_heading.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({
    super.key,
  });

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final FoodController foodController = Get.put(FoodController());
  // final BestSellerController bestSellerController =
  //     Get.put(BestSellerController());
  final VendorController vendorController = Get.put(VendorController());
  final LocationController locationController = Get.put(LocationController());
  final CartController cartController = Get.put(CartController());

  final lang = Get.put(LanguageController());
  List<ItemModel> searchSuggestions = [];
  List<ItemModel> itemSearchSuggestions = [];
  List<ItemModel> restaurantSearchSuggestions = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    foodController.getProducts();
    foodController.getCategories();
    // bestSellerController.getBestSeller();
    vendorController.fetchVendorsf();
  }

  void _updateSearchSuggestions(String query) async {
    if (query.isNotEmpty) {
      final searchResults = await foodController.searchProducts(query);

      // Use a Set to filter out duplicate restaurant names
      final uniqueRestaurantNames = <String>{};
      final uniqueRestaurantSuggestions = <ItemModel>[];

      for (var item in searchResults) {
        final currentLanguageCode = lang.currentLanguage.value.languageCode;
        final itemName =
            currentLanguageCode == 'ar' ? item.localName : item.name;
        final restaurantName = currentLanguageCode == 'ar'
            ? item.arabicRestaurantName
            : item.restaurantName;

        if (restaurantName.toLowerCase().contains(query.toLowerCase())) {
          if (uniqueRestaurantNames.add(restaurantName)) {
            uniqueRestaurantSuggestions.add(item);
          }
        }
      }

      setState(() {
        itemSearchSuggestions = searchResults
            .where((item) => (lang.currentLanguage.value.languageCode == 'ar'
                ? item.localName.toLowerCase().contains(query.toLowerCase())
                : item.name.toLowerCase().contains(query.toLowerCase())))
            .toList();
        restaurantSearchSuggestions = uniqueRestaurantSuggestions;
      });
    } else {
      setState(() {
        itemSearchSuggestions = [];
        restaurantSearchSuggestions = [];
      });
    }
  }

  void _clearSearchField() {
    _searchController.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      itemSearchSuggestions = [];
      restaurantSearchSuggestions = [];
    });
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
                    locationController.streetName.value,
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
                  cartController.getItemCount() > 0
                      ? Badge.count(
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
                        )
                      : GestureDetector(
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
          )
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
                onChanged: _updateSearchSuggestions, // Update suggestions
                controller: _searchController,
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    foodController.searchProducts(query).then((products) {
                      Get.to(() => SearchResultHome(
                            items: itemSearchSuggestions,
                            restaurants: restaurantSearchSuggestions,
                            title: "Search Result".tr,
                          ));
                      _clearSearchField();
                    });
                  }
                },
              ),
              if (itemSearchSuggestions.isNotEmpty ||
                  restaurantSearchSuggestions.isNotEmpty)
                Column(
                  children: [
                    if (itemSearchSuggestions.isNotEmpty) ...[
                      // Text('Items:',
                      // style: Theme.of(context).textTheme.headlineMedium),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: itemSearchSuggestions.length,
                        itemBuilder: (context, index) {
                          final item = itemSearchSuggestions[index];
                          final itemName =
                              lang.currentLanguage.value.languageCode == 'ar'
                                  ? item.localName
                                  : item.name;
                          return ListTile(
                            title: Text(itemName),
                            onTap: () {
                              final type = item.reference!.path.split('/')[0];
                              Get.to(() => ProfilePage(
                                    userId: item.addedBy,
                                    cat: "",
                                    type: type,
                                  ));
                              _clearSearchField();
                            },
                          );
                        },
                      ),
                    ],
                    if (restaurantSearchSuggestions.isNotEmpty) ...[
                      // Text('Restaurants:',
                      //  style: Theme.of(context).textTheme.headlineMedium),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: restaurantSearchSuggestions.length,
                        itemBuilder: (context, index) {
                          final item = restaurantSearchSuggestions[index];
                          final restaurantName =
                              lang.currentLanguage.value.languageCode == 'ar'
                                  ? item.arabicRestaurantName
                                  : item.name;
                          return ListTile(
                            title: Text(restaurantName),
                            onTap: () {
                              final typeo = item.reference!.path.split('/')[0];
                              Get.to(() => ProfilePage(
                                    userId: item.addedBy,
                                    cat: "",
                                    type: typeo,
                                  ));
                              _clearSearchField();
                            },
                          );
                        },
                      ),
                    ],
                  ],
                ),
              kHiegth15,
              // Welcome card
              SPromoSliderWidget(),
              kHiegth25,

              // Categories card
              TwoTextHeading(heading: "Categories".tr),
              kHiegth20,
              SizedBox(
                height: 300.h,
                child: Obx(
                  () => foodController.isCategoryLoading.value
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) =>
                              const ShimmerCetegory(),
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: foodController.categoryList.length,
                          itemBuilder: (context, index) {
                            print("Category List");
                            final category = foodController.categoryList[index];
                            log(category.imageUrl.toString());
                            return CategoryCard(
                              onTap: () {
                                Get.to(
                                  () => CategorysSearchPage(
                                    type: 'Food',
                                    category: category,
                                  ),
                                );
                              },
                              categoryName:
                                  lang.currentLanguage.value.languageCode ==
                                          "ar"
                                      ? category.localName
                                      : category.name,
                              categoryImage: category.imageUrl,
                            );
                          },
                        ),
                ),
              ),
              // kHiegth20,
              // OneTextHeading(
              //   heading: "Best Sellers".tr,
              // ),
              // kHiegth20,
              // Obx(
              //   () => bestSellerController.isBestSellerLoading.value
              //       ? const CircularProgressIndicator()
              //       : SizedBox(
              //           height: 300,
              //           child: ListView.builder(
              //             scrollDirection: Axis.horizontal,
              //             itemCount: bestSellerController.bestSellerList.length,
              //             itemBuilder: (context, index) {
              //               final bestSeller =
              //                   bestSellerController.bestSellerList[index];
              //               log(bestSeller.image.toString());
              //               log("Best Seller Image is calling");
              //               return BestSellerCard(
              //                 onTap: () {
              //                   Get.to(() => ProfilePage(
              //                         userId: bestSeller.addedBy,
              //                         type: "Food",
              //                         cat: "Best Seller",
              //                       ));
              //                 },
              //                 name: bestSeller.name,
              //                 imagePath: bestSeller.image,
              //                 price: bestSeller.price,
              //                 vendor: bestSeller.restaurantName,
              //               );
              //             },
              //           ),
              //         ),
              // ),
              kHiegth20,
              OneTextHeading(
                heading: "Nearby Restaurants".tr,
              ),
              kHiegth20,
              Obx(
                () => vendorController.isVendorLoading.value
                    ? ListView.separated(
                        itemBuilder: (context, index) => const ShimmerExport(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 18),
                        itemCount: 3,
                      )
                    : vendorController.vendorsListf.isEmpty
                        ? Center(child: Text("No Nearby Restaurants".tr))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: vendorController.vendorsListf.length,
                            itemBuilder: (context, index) {
                              final vendor =
                                  vendorController.vendorsListf[index];
                              log("Vendor Images");

                              log(vendor.bannerImage.toString());
                              return ExploreCard(
                                isOnline: vendor.isOnline,
                                longitude: vendor.location.lng,
                                latitude: vendor.location.lat,
                                locationCityCountry: '',
                                distance: vendorController
                                    .calculateDistance(vendor.location),
                                name: lang.currentLanguage.value.languageCode ==
                                        "ar"
                                    ? vendor.restaurantArabicName
                                    : vendor.restaurantName,
                                image: vendor.bannerImage,
                                onTap: () {
                                  Get.to(() => ProfilePage(
                                        userId: vendor.reference.id,
                                        cat: "",
                                        type: "Food",
                                      ));
                                },
                              );
                            },
                          ),
              ),
              kHiegth40,
            ],
          ),
        ),
      ),
    );
  }
}
