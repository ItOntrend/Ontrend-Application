import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/profile_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/shimmer_export.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/explore_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_back.dart';

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
  @override
  void initState() {
    super.initState();
    //if (widget.category) vendorController.fetchVendors(widget.type);
    // vendorController.getVendors(widget.userId);
    //vendorController.fetchVendors(widget.type);
  }

  /* void fetchVendors() async {
    await vendorController.fetchVendorsCat(widget.type, widget.category.name);
    filteredVendors.value = vendorController.vCat;
  }

  void filterVendors(String query) {
    if (query.isEmpty) {
      filteredVendors.value = vendorController.vCat;
    } else {
      filteredVendors.value = vendorController.vCat
          .where((vendor) =>
              vendor.restaurantName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }*/

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
                  initialValue:
                      languageController.currentLanguage.value.languageCode ==
                              'ar'
                          ? widget.category.localName
                          : widget.category.name,
                ),
                kHiegth25,
                FutureBuilder<void>(
                  future: vendorController.fetchVendorsCat(
                      widget.type, widget.category.name),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.separated(
                        itemBuilder: (context, index) => const ShimmerExport(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 18),
                        itemCount: 3,
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text("Error fetching vendors"));
                    } else {
                      return Obx(
                        () => vendorController.vCat.isEmpty
                            ? Center(child: Text("No Vendor Available".tr))
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
                                    name: languageController.currentLanguage
                                                .value.languageCode ==
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



