import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
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
  final CartController cartController = Get.find<CartController>();
  TabController? _tabController;
  final ScrollController _scrollController = ScrollController();
  late List<String> tagList;
  final Map<String, GlobalKey> _keys = {};
  bool _isTabAnimating = false;
  bool _isScrollAnimating = false;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
    _scrollController.addListener(_onScroll);
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
    final Set<String> tagSet = {};
    for (var category in vendorController.ItemsList) {
      if (category.tag != null) {
        tagSet.add(category.tag!);
      }
    }
    tagList = tagSet.toList();

    if (tagList.isNotEmpty) {
      _tabController = TabController(
        length: tagList.length,
        vsync: this,
        initialIndex: widget.initialTabIndex,
      );

      _tabController!.addListener(() {
        if (_tabController!.indexIsChanging) {
          _isTabAnimating = true;
          scrollToTag(tagList[_tabController!.index]);
        }
      });
    }
  }

  void scrollToTag(String tag) {
    final keyContext = _keys[tag]?.currentContext;
    if (keyContext != null) {
      _isScrollAnimating = true;
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.1,
      ).then((_) {
        _isScrollAnimating = false;
        _isTabAnimating = false;
      });
    }
  }

  void _onScroll() {
    if (_isScrollAnimating || _isTabAnimating) return;

    final offset = _scrollController.offset;
    for (int index = 0; index < tagList.length; index++) {
      final keyContext = _keys[tagList[index]]?.currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox?;
        final pos = box?.localToGlobal(Offset.zero);
        if (pos != null && pos.dy < 200) {
          if (_tabController?.index != index) {
            _tabController?.animateTo(index);
          }
          break;
        }
      }
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        body: Stack(
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
                child: ProfileCard(userId: widget.userId),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Column(
                children: [
                  Obx(
                    () {
                      final Set<String> tagSet = {};
                      for (var category in vendorController.ItemsList) {
                        if (category.tag != null) {
                          tagSet.add(category.tag!);
                        }
                      }
                      tagList = tagSet.toList();

                      return _tabController != null
                          ? TabBar(
                              controller: _tabController,
                              isScrollable: true,
                              tabs: tagList.map((tag) {
                                final displayTag =
                                    lang.currentLanguage.value.languageCode ==
                                            "ar"
                                        ? vendorController.ItemsList.firstWhere(
                                            (item) => item.tag == tag).localTag
                                        : tag;
                                return Tab(text: displayTag);
                              }).toList(),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                  kHiegth25,
                  Expanded(
                    child: Obx(
                      () {
                        if (vendorController.isItemsLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (vendorController.ItemsList.isEmpty) {
                          return Center(child: Text("No items found".tr));
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: vendorController.ItemsList.length,
                          itemBuilder: (context, index) {
                            final item = vendorController.ItemsList[index];
                            final tagKey = item.tag ?? '';
                            _keys.putIfAbsent(tagKey, () => GlobalKey());

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (index == 0 ||
                                    vendorController.ItemsList[index - 1].tag !=
                                        item.tag)
                                  Padding(
                                    key: _keys[tagKey],
                                    padding: const EdgeInsets.only(
                                      top: 16.0,
                                      left: 16.0,
                                      right: 16.0,
                                    bottom:16.0,),
                                    child: Text(
                                      lang.currentLanguage.value.languageCode ==
                                              "ar"
                                          ? item.localTag
                                          : item.tag ?? '',
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => ItemViewPage(item: item));
                                  },
                                  child: FoodItemCard(
                                    name: item.name,
                                    localName: item.localName,
                                    arabicRestaurantName:
                                        item.arabicRestaurantName,
                                    localTag: item.localTag,
                                    image: item.imageUrl,
                                    description: item.description,
                                    price: item.price,
                                    addedBy: item.addedBy,
                                    restaurantName: item.restaurantName,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  kHiegth25,
                ],
              ),
            ),
          ],
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
                    '${"Items in Cart:".tr} ${cartController.getItemCount()}',
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
                    child: Text(
                      'View Cart'.tr,
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
}
