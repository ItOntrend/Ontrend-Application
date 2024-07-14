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
    required this.userId,
    required this.categoryName,
  });
  final String userId;
  final String categoryName;

  @override
  State<CategorysSearchPage> createState() => _CategorysSearchPageState();
}

class _CategorysSearchPageState extends State<CategorysSearchPage> {
  final VendorController vendorController = Get.put(VendorController());

  @override
  void initState() {
    super.initState();
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
                                    vendorController.vendorsList[index];
                                log("Vendor Images");
                                log(vendor.bannerImage.toString());
                                return ExploreCard(
                                  locationCityCountry: '',
                                  distance: vendorController
                                      .calculateDistance(vendor.location),
                                  name: vendor.restaurantName,
                                  image: vendor.bannerImage,
                                  latitude: vendor.location.lat,
                                  longitude: vendor.location.lng,
                                  onTap: () {
                                    Get.to(() => ProfilePage(
                                        userId: vendor.reference.id));
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