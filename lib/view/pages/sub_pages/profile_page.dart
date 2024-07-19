import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/add_to_cart_page.dart';
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
    vendorController.getVendors(widget.userId);
    vendorController.getCatVendor(widget.userId, widget.type);

    // Initialize the TabController based on initial data load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (vendorController.CatList.isNotEmpty) {
        initializeTabController();
      }
    });
  }

  void initializeTabController() {
    final Set<String> tagSet = {};
    for (var category in vendorController.CatList) {
      if (category.tag != null) {
        tagSet.add(category.tag!);
      }
    }
    List<String> tagList = tagSet.toList();
    _tabController = TabController(
      length: tagList.length,
      vsync: this,
    );
    setState(() {}); // Trigger rebuild to update UI
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
                  child: Image.network(
                    vendorController.vendorDetail.value?.bannerImage ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
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
                        final Set<String> tagSet = {};
                        for (var category in vendorController.CatList) {
                          if (category.tag != null) {
                            tagSet.add(category.tag!);
                          }
                        }
                        List<String> tagList = tagSet.toList();
                        if (_tabController == null && tagList.isNotEmpty) {
                          _tabController = TabController(
                            length: tagList.length,
                            vsync: this,
                          );
                        }
                        return _tabController != null
                            ? TabBar(
                                controller: _tabController,
                                isScrollable: true,
                                tabs: tagList.map((tag) {
                                  return Tab(text: tag);
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
                        final Set<String> tagSet = {};
                        for (var category in vendorController.CatList) {
                          if (category.tag != null) {
                            tagSet.add(category.tag!);
                          }
                        }
                        List<String> tagList = tagSet.toList();
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 450.h,
                          child: _tabController != null
                              ? TabBarView(
                                  controller: _tabController,
                                  children: tagList.map((tag) {
                                    return buildItemListView(tag);
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
        bottomNavigationBar: Obx(() {
          return BottomAppBar(
            color: kTransparent,
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: kGreen,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Items in Cart: ${cartController.getItemCount()}',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: kWhite),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => const AddToCartPage(
                            addedBy: '',
                            restaurantName: '',
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: kWhite,
                      backgroundColor: kWhite,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                    ),
                    child: const Text(
                      'View Cart',
                      style: TextStyle(
                        color: kOrange,
                        decoration: TextDecoration.underline,
                        decorationColor: kOrange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildItemListView(String tag) {
    final items =
        vendorController.itemsList.where((item) => item.tag == tag).toList();
    print("Items for tag '$tag': ${items.length}");
    log("Items for tag '$tag': ${items.length}");
    return ListView.builder(
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
