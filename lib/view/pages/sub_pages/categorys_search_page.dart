import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
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
    required this.category,
  });
  final String type;
  final CategoryModel category;

  @override
  State<CategorysSearchPage> createState() => _CategorysSearchPageState();
}

class _CategorysSearchPageState extends State<CategorysSearchPage> {
  final VendorController vendorController = Get.put(VendorController());
  final LanguageController languageController = Get.find();
  RxList filteredVendors = [].obs;
  final TextEditingController _searchController = TextEditingController();
  //RxList searchSuggestions = [].obs;

  @override
  void initState() {
    super.initState();
    fetchVendors();
  }

  void fetchVendors() async {
    await vendorController.fetchVendorsCat(widget.type, widget.category.name);
    filteredVendors.value = vendorController.vCat;
    //searchSuggestions.value = vendorController.vCat;
  }

  void filterVendors(String query) {
    if (query.isEmpty) {
      filteredVendors.value = vendorController.vCat;
    } else {
      filteredVendors.value = vendorController.vCat
          .where((vendor) =>
              (vendor.restaurantName ?? '')
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              (vendor.restaurantArabicName ?? '')
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    }
  }

  /*void updateSearchSuggestions(String query) {
    if (query.isEmpty) {
      searchSuggestions.value = [];
    } else {
      searchSuggestions.value = vendorController.vCat
          .where((vendor) =>
              (vendor.restaurantName ?? '')
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              (vendor.restaurantArabicName ?? '')
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    }
  }*/

  void clearSearchField() {
    _searchController.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      filteredVendors.value = vendorController.vCat;
      //searchSuggestions.value = [];
    });
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
                  hintText: "Search...".tr,
                  controller: _searchController,
                  onChanged: (query) {
                    filterVendors(query);
                    //updateSearchSuggestions(query);
                  },
                  onTap: () {},
                ),
                /* Obx(() {
                  if (searchSuggestions.isNotEmpty &&
                      _searchController.text.isNotEmpty) {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchSuggestions.length,
                          itemBuilder: (context, index) {
                            final vendor = searchSuggestions[index];
                            return ListTile(
                              title: Text(languageController
                                          .currentLanguage.value.languageCode ==
                                      "ar"
                                  ? vendor.restaurantArabicName
                                  : vendor.restaurantName),
                              onTap: () {
                                _searchController.text = languageController
                                            .currentLanguage
                                            .value
                                            .languageCode ==
                                        "ar"
                                    ? vendor.restaurantArabicName
                                    : vendor.restaurantName;
                                filterVendors(_searchController.text);
                                clearSearchField();
                              },
                            );
                          },
                        ),
                        const Divider(),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),*/
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
                      languageController.currentLanguage.value.languageCode ==
                              'ar'
                          ? widget.category.localName
                          : widget.category.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                kHiegth25,
                Obx(
                  () => filteredVendors.isEmpty
                      ? Center(child: Text("No Vendor Available".tr))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: filteredVendors.length,
                          itemBuilder: (context, index) {
                            final vendor = filteredVendors[index];
                            return ExploreCard(
                              longitude: vendor.location.lng,
                              latitude: vendor.location.lat,
                              locationCityCountry: '',
                              distance: vendorController
                                  .calculateDistance(vendor.location),
                              name: languageController
                                          .currentLanguage.value.languageCode ==
                                      "ar"
                                  ? vendor.restaurantArabicName
                                  : vendor.restaurantName,
                              image: vendor.bannerImage,
                              onTap: () {
                                Get.to(() => ProfilePage(
                                    userId: vendor.reference.id,
                                    cat: widget.category.name,
                                    type: widget.type));
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
