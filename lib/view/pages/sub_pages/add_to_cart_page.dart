import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/location_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/select_location_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/offers_and_benefits_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/add_to_cart_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/adding_more_item_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/bill_details_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/terms_and_condition.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';

class AddToCartPage extends StatefulWidget {
  final String addedBy;
  final String restaurantName;
  const AddToCartPage({
    super.key,
    required this.addedBy,
    required this.restaurantName,
  });

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  final LocationController locationController = Get.put(LocationController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    String addedBy = widget.addedBy;

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Obx(
          () => GestureDetector(
            onTap: () {
              Get.to(const SelectLocationPage());
            },
            child: Row(
              children: [
                Image.asset("assets/icons/location_icon.png"),
                kWidth10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locationController.subLocalityName.value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${locationController.cityName.value},${locationController.countryName.value}",
                          style: const TextStyle(color: kBlue, fontSize: 10),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Obx(() {
            bool hasItems = cartController.cartItems.isNotEmpty;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasItems) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(color: kBorderLiteBlack),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartController.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartController.cartItems.values
                                .toList()[index]['item'];
                            return AddToCartCard(
                              itemName: item.name,
                              localName: item.localName,
                              arabicRestaurantName: item.arabicRestaurantName,
                              localTag: item.localTag,
                              itemPrice: item.itemPrice,
                              image: item.imageUrl,
                              addedBy: item.addedBy.toString(),
                              restaurantName: item.restaurantName,
                            );
                          },
                        ),
                        kHiegth9,
                        AddingMoreItemCard(
                          addedBy: addedBy,
                        ),
                      ],
                    ),
                  ),
                  OneTextHeading(
                    heading: "Offers & Benefits".tr,
                  ),
                  kHiegth15,
                  const OffersAndBenefitsCard(),
                  kHiegth15,
                  OneTextHeading(
                    heading: "Bill Details".tr,
                  ),
                  kHiegth15,
                  BillDetailsCard(
                    
                  ),
                  kHiegth15,
                  const TermsAndCondition(),
                  kHiegth20,
                ] else ...[
                  kHiegth140,
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "No items found in the cart.".tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        kHiegth24,
                        ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(kWhite)),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "Add Items to Cart".tr,
                            style: TextStyle(color: kDarkOrange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            );
          }),
        ),
      ),
    );
  }
}
