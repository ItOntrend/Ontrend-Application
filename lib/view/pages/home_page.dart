import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/home_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/location_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/navigation_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/groceries_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/notification_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/profile_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/select_location_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/carousal_slider.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/home_search_result.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/shimmer_export.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/nearby_vendor_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/oru_service_big_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/oru_service_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
import 'package:persistent_bottom_nav_bar_plus/persistent_bottom_nav_bar_plus.dart';

class HomePage extends StatefulWidget {
  final NavigationController? controller;

  const HomePage({
    super.key,
    this.controller,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserController userController = Get.put(UserController());
  final LocationController locationController = Get.put(LocationController());
  final CartController cartController = Get.put(CartController());
  final VendorController vendorController = Get.put(VendorController());
  List<ItemModel> itemSearchSuggestions = [];
  List<ItemModel> restaurantSearchSuggestions = [];
  final NavigationController navigationController =
      Get.put(NavigationController());
  final HomeController homeController = Get.put(HomeController());
  final LanguageController lang = Get.put(LanguageController());
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //locationController.loadLocationFromPreferences();
      vendorController.fetchVendorsf();
      homeController.getProducts();
      await vendorController.loadGridViewPreference();
    });
  }

  void _updateSearchSuggestions(String query) async {
    if (query.isNotEmpty) {
      final searchResults = await homeController.searchProducts(query);

      // Use a Set to filter out duplicate restaurant names
      final uniqueRestaurantNames = <String>{};
      final uniqueRestaurantSuggestions = <ItemModel>[];

      for (var item in searchResults) {
        final currentLanguageCode = lang.currentLanguage.value.languageCode;
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
        final currentLanguageCode = lang.currentLanguage.value.languageCode;
        itemSearchSuggestions = searchResults
            .where((item) => (currentLanguageCode == 'ar'
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
            Get.to(() => const SelectLocationPage());
          },
          child: Padding(
            padding: (lang.currentLanguage.value.languageCode == 'ar')
                ? const EdgeInsets.only(right: 20)
                : const EdgeInsets.only(left: 20),
            child: Image.asset(
              "assets/icons/location_icon.png",
              width: 30, // Set the desired width
              height: 30,
            ),
          ),
        ),
        title: Obx(() {
          if (locationController.isLoading.value) {
            return const CircularProgressIndicator();
          } else {
            return GestureDetector(
              onTap: () {
                Get.to(
                  () => const SelectLocationPage(),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locationController.subLocalityName.value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
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
                ],
              ),
            );
          }
        }),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kDarkOrange,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Points".tr,
                      style: GoogleFonts.aDLaMDisplay(
                          color: kWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    Obx(
                      () => Text(
                        "${userController.rewardPoints.value.toInt()}",
                        style: GoogleFonts.abhayaLibre(
                            color: kWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              TextfieldWithMic(
                hintText: "Vegetables, fruits...".tr,
                controller: _searchController,
                onChanged: _updateSearchSuggestions,
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    homeController.searchProducts(query).then((products) {
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
                                  : item.restaurantName;
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
              kHiegth20,
              SPromoSliderWidget(),
              OneTextHeading(
                heading: "Our Services".tr,
              ),
              kHiegth20,
              GestureDetector(
                onTap: () {
                  Get.find<NavigationController>().changeTabIndex(2);
                },
                child: OruServiceBigCard(
                  image: "assets/image/home_appliance_image.png",
                  name: "E-Store".tr,
                ),
              ),
              kHiegth20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: GroceriesPage(),
                        withNavBar: true,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: OurServiceCard(
                      name: 'Groceries'.tr,
                      image: "assets/image/grocerry_image.png",
                    ),
                  ),
                  kWidth20,
                  GestureDetector(
                    onTap: () {
                      Get.find<NavigationController>().changeTabIndex(1);
                    },
                    child: OurServiceCard(
                      name: 'Food'.tr,
                      image: "assets/image/service_food_image.png",
                    ),
                  ),
                ],
              ),
              kHiegth20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OneTextHeading(
                    heading: "Nearby Restaurants".tr,
                  ),
                  Obx(
                    ()=>IconButton(
                      icon: Icon(vendorController.isGridView.value
                          ? Icons.list
                          : Icons.grid_view),
                      onPressed: () {
                        vendorController.saveGridViewPreference(
                            !vendorController.isGridView.value);
                      },
                    ),
                  ),
                ],
              ),
              kHiegth20,
              Obx(
                () => vendorController.isItemsLoading.value
                    ? ListView.separated(
                        itemBuilder: (context, index) => const ShimmerExport(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 18),
                        itemCount: 3,
                      )
                    : vendorController.vendorsListf.isEmpty
                        ? const Center(child: Text("No Vendor Available"))
                        : vendorController.isGridView.value
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: vendorController.vendorsListf.length,
                                itemBuilder: (context, index) {
                                  final vendor =
                                      vendorController.vendorsListf[index];
                                  return NearbyRestaurantCard(
                                    isOnline: vendor.isOnline,
                                    latitude: vendor.location.lat,
                                    longitude: vendor.location.lng,
                                    locationCityCountry: "",
                                    distance: vendorController
                                        .calculateDistance(vendor.location),
                                    name: lang.currentLanguage.value
                                                .languageCode ==
                                            "ar"
                                        ? vendor.restaurantArabicName
                                        : vendor.restaurantName,
                                    images: vendor.bannerImage,
                                    onTap: () {
                                      Get.to(() => ProfilePage(
                                            userId: vendor.reference.id,
                                            cat: "",
                                            type: "Grocery",
                                          ));
                                    },
                                  );
                                },
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: vendorController.vendorsListf.length,
                                itemBuilder: (context, index) {
                                  final vendor =
                                      vendorController.vendorsListf[index];
                                  return ExploreCard(
                                    isOnline: vendor.isOnline,
                                    longitude: vendor.location.lng,
                                    latitude: vendor.location.lat,
                                    locationCityCountry: '',
                                    distance: vendorController
                                        .calculateDistance(vendor.location),
                                    name: lang.currentLanguage.value
                                                .languageCode ==
                                            "ar"
                                        ? vendor.restaurantArabicName
                                        : vendor.restaurantName,
                                    images: vendor.bannerImage,
                                    onTap: () {
                                      Get.to(() => ProfilePage(
                                            userId: vendor.reference.id,
                                            cat: "",
                                            type: "Food/Restaurent",
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

  String removeFirstPart(String input) {
    List<String> parts = input.split(' ');
    if (parts.length > 1) {
      return parts.sublist(1).join(' ');
    } else {
      return input; // If there is only one part, return it as is.
    }
  }
}
