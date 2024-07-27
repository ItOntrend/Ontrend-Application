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
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_back.dart';
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

  @override
  void initState() {
    super.initState();
    fetchVendors();
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
      final currentLanguageCode =
          languageController.currentLanguage.value.languageCode;
      filteredVendors.value = vendorController.vCat.where((vendor) {
        final nameToSearch = currentLanguageCode == 'ar'
            ? vendor.restaurantArabicName
            : vendor.restaurantName;
        return nameToSearch.toLowerCase().contains(query.toLowerCase());
      }).toList();
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
                TextfieldWithBack(
                  hintText: "Search...".tr,
                  onChanged: filterVendors,
                ),
                kHiegth25,
                Obx(
                  () => isLoadingfilteredVendors.value
                      ? _buildShimmerEffect()
                      : filteredVendors.isEmpty
                          ? Center(child: Text("No Vendor Available".tr))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: filteredVendors.length,
                              itemBuilder: (context, index) {
                                final vendorsListf =
                                    vendorController.vendorsListf[index];
                                final vendor = filteredVendors[index];
                                return ExploreCard(
                                  isOnline: vendorsListf.isOnline,
                                  longitude: vendor.location.lng,
                                  latitude: vendor.location.lat,
                                  locationCityCountry: '',
                                  distance: vendorController
                                      .calculateDistance(vendor.location),
                                  name: languageController.currentLanguage.value
                                              .languageCode ==
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
