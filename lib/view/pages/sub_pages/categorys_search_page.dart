import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/profile_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/nearby_vendor_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
import 'package:shimmer/shimmer.dart';

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
  RxBool isLoadingfilteredVendors = false.obs;
  final TextEditingController _searchController = TextEditingController();
  //bool isGridView = false;

  @override
  void initState() {
    super.initState();
    fetchVendors();
    vendorController.loadGridViewPreference();
  }

  void fetchVendors() async {
    isLoadingfilteredVendors.value = true;
    await vendorController.fetchVendorsCat(widget.type, widget.category.name);
    filteredVendors.value = vendorController.vCat;
    isLoadingfilteredVendors.value = false;
  }

  void filterVendors(String query) {
    if (query.isEmpty) {
      filteredVendors.value = vendorController.vCat;
    } else {
      filteredVendors.value = vendorController.vCat
          .where((vendor) =>
              (vendor.restaurantName)
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              (vendor.restaurantArabicName)
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    }
  }

  void clearSearchField() {
    _searchController.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      filteredVendors.value = vendorController.vCat;
    });
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        );
      },
    );
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: kDarkOrange,
                          ),
                        ),
                        kWidth10,
                        OneTextHeading(
                          heading: languageController
                                      .currentLanguage.value.languageCode ==
                                  "ar"
                              ? widget.category.localName
                              : widget.category.name,
                        ),
                      ],
                    ),
                    Obx(
                      () => IconButton(
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
                TextfieldWithMic(
                  hintText: "Search...".tr,
                  onChanged: filterVendors,
                  //initialValue:
                  //languageController.currentLanguage.value.languageCode ==
                  //     'ar'
                  //? widget.category.localName
                  //: widget.category.name,
                ),
                kHiegth25,
                Obx(
                  () => isLoadingfilteredVendors.value
                      ? _buildShimmerEffect()
                      : filteredVendors.isEmpty
                          ? Center(child: Text("No Vendor Available".tr))
                          : vendorController.isGridView.value
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: filteredVendors.length,
                                  itemBuilder: (context, index) {
                                    final vendor = filteredVendors[index];
                                    return NearbyRestaurantCard(
                                      isOnline: vendor.isOnline,
                                      longitude: vendor.location.lng,
                                      latitude: vendor.location.lat,
                                      locationCityCountry: '',
                                      distance: vendorController
                                          .calculateDistance(vendor.location),
                                      name: languageController.currentLanguage
                                                  .value.languageCode ==
                                              "ar"
                                          ? vendor.restaurantArabicName
                                          : vendor.restaurantName,
                                      images: vendor.bannerImage,
                                      onTap: () {
                                        Get.to(() => ProfilePage(
                                            userId: vendor.reference.id,
                                            cat: "",
                                            type: widget.type));
                                      },
                                    );
                                  },
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: filteredVendors.length,
                                  itemBuilder: (context, index) {
                                    final vendor = filteredVendors[index];
                                    return ExploreCard(
                                      isOnline: vendor.isOnline,
                                      longitude: vendor.location.lng,
                                      latitude: vendor.location.lat,
                                      locationCityCountry: '',
                                      distance: vendorController
                                          .calculateDistance(vendor.location),
                                      name: languageController.currentLanguage
                                                  .value.languageCode ==
                                              "ar"
                                          ? vendor.restaurantArabicName
                                          : vendor.restaurantName,
                                      images: vendor.bannerImage,
                                      onTap: () {
                                        Get.to(() => ProfilePage(
                                            userId: vendor.reference.id,
                                            cat: "",
                                            type: widget.type));
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
      ),
    );
  }
}
