import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/shimmer_skelton.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/food_item_card.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/profile_card.dart';
import 'item_view_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    this.initialTabIndex = 0,
    required this.userId,
    required this.type,
    required this.cat,
  });
  final int initialTabIndex;
  final String userId;
  final String type;
  final String cat;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final VendorController vendorController = Get.put(VendorController());
  final LanguageController lang = Get.put(LanguageController());
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  void fetchInitialData() async {
    if (widget.cat == "") {
      await vendorController.getCatVendorNew(widget.userId, widget.type);
    } else {
      await vendorController.getItemsGr(widget.userId, widget.cat, widget.type);
    }
    await vendorController.getVendors(widget.userId);
    await vendorController.calculateDeliveryFee(widget.userId);
    await vendorController.getItemsVendor(widget.userId, widget.type);

    setState(() {
      initializeTabController();
    });
  }

  void initializeTabController() {
    // Create a Set to store unique tags
    final Set<String> tagSet = {};

    // Add tags from CatList to the Set
    for (var category in vendorController.ItemsList) {
      if (category.tag != null) {
        tagSet.add(category.tag!);
      }
    }

    // Convert the Set to a List
    List<String> tagList = tagSet.toList();

    // Initialize the TabController with the length of the tag list
    if (tagList.isNotEmpty) {
      _tabController = TabController(
        length: tagList.length,
        vsync: this,
      );
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Obx(
                () => SizedBox(
                  height: 200.h,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl:
                        vendorController.vendorDetail.value?.bannerImage ?? "",
                    fit: BoxFit.cover,
                    errorWidget: (context, error, stackTrace) {
                      return CachedNetworkImage(
                        imageUrl:
                            'https://service.sarawak.gov.my/web/web/web/web/res/no_image.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 20,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 38.h,
                    width: 38.w,
                    decoration: const BoxDecoration(
                      color: kWhite,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 30,
                right: 30,
                child: Center(
                  child: ProfileCard(
                    userId: widget.userId,
                  ),
                ),
              ),
              kHiegth20,
              Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Column(
                  children: [
                    Obx(
                      () {
                        // Create a Set to store unique tags
                        final Set<String> tagSet = {};

                        // Add tags from CatList to the Set
                        for (var category in vendorController.ItemsList) {
                          if (category.tag != null) {
                            tagSet.add(category.tag!);
                          }
                        }

                        // Convert the Set to a List
                        List<String> tagList = tagSet.toList();

                        return _tabController != null
                            ? TabBar(
                                controller: _tabController,
                                isScrollable: true,
                                tabs: tagList.map((tag) {
                                  final displayTag = lang.currentLanguage.value
                                              .languageCode ==
                                          "ar"
                                      ? vendorController.ItemsList.firstWhere(
                                          (item) => item.tag == tag).localTag
                                      : tag;
                                  return Tab(
                                      text:
                                          displayTag); // Use localTag if available, else use tag
                                }).toList(),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                    kHiegth25,
                    Obx(
                      () {
                        if (vendorController.isItemsLoading.value) {
                          log("Loading items...");
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (vendorController.itemsList.isEmpty) {
                          return const Center(child: Text("No items found"));
                        }

                        // Create a Set to store unique tags
                        final Set<String> tagSet = {};

                        // Add tags from CatList to the Set
                        for (var category in vendorController.ItemsList) {
                          if (category.tag != null) {
                            tagSet.add(category.tag!);
                          }
                        }

                        // Convert the Set to a List
                        List<String> tagList = tagSet.toList();

                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 450.h,
                          child: _tabController != null
                              ? TabBarView(
                                  controller: _tabController,
                                  children: tagList.map((tag) {
                                    return buildItemListView(
                                        tag); // Pass the tag to the item list builder
                                  }).toList(),
                                )
                              : const SizedBox.shrink(),
                        );
                      },
                    ),
                    kHiegth25,
                  ],
                ),
              ),
            ],
          ),
        ),
        
      ),
    );
  }

  Widget buildItemListView(String tag) {
    final items = vendorController.ItemsList.where(
            (item) => item.tag == tag) // Filter by tag
        .toList();
    print("Items for tag '$tag': ${items.length}");
    log("Items for tag '$tag': ${items.length}"); // Debug log
    return vendorController.isItemsLoading.value
        ? const ShimmerFoodItem()
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => ItemViewPage(item: item));
                },
                child: FoodItemCard(
                  name: item.name,
                  localName: item.localName,
                  localTag: item.localTag,
                  image: item.imageUrl,
                  description: item.description,
                  price: item.price,
                  addedBy: item.addedBy,
                  restaurantName: item.restaurantName,
                ),
              );
            },
          );
  }
}

class ShimmerFoodItem extends StatelessWidget {
  const ShimmerFoodItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            children: [
              Skelton(
                width: 120.w,
                height: 20.h,
              ),
              kHiegth10,
              Skelton(
                width: 50.w,
                height: 15.h,
              ),
              kHiegth10,
              Skelton(
                width: 200.w,
                height: double.infinity,
              ),
            ],
          ),
          Column(
            children: [
              Skelton(
                width: 150.w,
                height: 100.h,
              ),
              kHiegth10,
              Skelton(
                width: 150.w,
                height: 50.h,
              )
            ],
          )
        ],
      ),
    );
  }
}
