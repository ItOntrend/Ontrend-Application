import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/profile_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/search_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';

class CategorysSearchPage extends StatefulWidget {
  const CategorysSearchPage({
    super.key,
    required this.type,
    required this.categoryName,
  });
  final String type;
  final String categoryName;

  @override
  State<CategorysSearchPage> createState() => _CategorysSearchPageState();
}

class _CategorysSearchPageState extends State<CategorysSearchPage> {
  final VendorController vendorController = Get.put(VendorController());

  @override
  void initState() {
    super.initState();
    //vendorController.fetchVendors(widget.type);
    // vendorController.getVendors(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextfieldWithMic(
                  hintText: "Search...",
                  onTap: () {
                    Get.to(const SearchPage());
                  },
                ),
                kHiegth20,
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    Text(
                      widget.categoryName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                kHiegth25,
                FutureBuilder<void>(
                  future: vendorController.fetchVendorsCat(
                      widget.type, widget.categoryName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text("Error fetching vendors"));
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
                                            cat: widget.categoryName,
                                            type:
                                                widget.type == "Food/Restaurant"
                                                    ? "Food"
                                                    : "Grocery",
                                          ));
                                    },
                                  );
                                },
                              ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
