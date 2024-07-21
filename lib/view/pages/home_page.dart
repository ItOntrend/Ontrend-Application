import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/home_controller.dart';
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
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/select_location_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/carousal_slider.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/home_search_result.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/oru_service_big_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/oru_service_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
import 'package:persistent_bottom_nav_bar_plus/persistent_bottom_nav_bar_plus.dart';

class HomePage extends StatefulWidget {
  final NavigationController? controller;

  HomePage({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final BestSellerController bestSellerController =
  //     Get.put(BestSellerController());
  final UserController userController = Get.put(UserController());
  final LocationController locationController = Get.put(LocationController());
  final CartController cartController = Get.put(CartController());
  final VendorController vendorController = Get.put(VendorController());
  List<ItemModel> searchSuggestions = [];
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // bestSellerController.getBestSeller();
      vendorController.fetchVendors('Food/Restaurant');
      homeController.getProducts();
    });
  }

  void _updateSearchSuggestions(String query) async {
    if (query.isNotEmpty) {
      // Fetch suggestions from the controller
      final products = await homeController.searchProducts(query);

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
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset("assets/icons/location_icon.png"),
          ),
        ),
        title: Obx(() {
          if (locationController.isLoading.value) {
            return const CircularProgressIndicator();
          } else {
            return GestureDetector(
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
              Obx(
                () => Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 10),
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kDarkOrange,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rewards: ",
                        style: GoogleFonts.aDLaMDisplay(
                            color: kWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${userController.rewardPoints.value.toInt()} pts",
                        style: GoogleFonts.abhayaLibre(
                            color: kWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              TextfieldWithMic(
                hintText: "Vegetables, fruits...".tr,
                onChanged: _updateSearchSuggestions, // Update suggestions
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    homeController.searchProducts(query).then((products) {
                      Get.to(() => SearchResultHome(
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
                          homeController
                              .searchProducts(item.name)
                              .then((products) {
                            Get.to(() => SearchResultHome(
                                  products: products,
                                  title: 'Search Result',
                                ));
                          });
                        }
                      },
                    );
                  },
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
                  SizedBox(width: 20),
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
              SizedBox(height: 20),
              OneTextHeading(
                heading: "Nearby Restaurant".tr,
              ),
              SizedBox(height: 20),
              Obx(
                () => vendorController.isVendorLoading.value
                    ? const CircularProgressIndicator()
                    : vendorController.vendorsListCat.isEmpty
                        ? const Center(child: Text("No Vendor Available"))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: vendorController.vendorsListCat.length,
                            itemBuilder: (context, index) {
                              final vendor =
                                  vendorController.vendorsListCat[index];
                              log("Vendor Images");

                              log(vendor.bannerImage.toString());
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
}
