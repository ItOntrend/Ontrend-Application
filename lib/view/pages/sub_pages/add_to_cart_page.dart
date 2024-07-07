import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/offers_and_benefits_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/add_to_cart_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/adding_more_item_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/bill_details_card.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/terms_and_condition.dart';
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
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    String addedBy = widget.addedBy;
    String restaurantName = widget.restaurantName;

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
        title: Row(
          children: [
            Image.asset("assets/icons/location_icon.png"),
            kWidth10,
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Janub Ad Dahariz",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Salala, Oman",
                      style: TextStyle(color: kBlue, fontSize: 10),
                    ),
                    Icon(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 11,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  border: Border.all(color: kBorderLiteBlack),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return ListView.builder(
                        shrinkWrap: true, // Wrap content to avoid overflow
                        itemCount: cartController.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartController.cartItems.values
                              .toList()[index]['item'];
                          return AddToCartCard(
                            itemName: item.name,
                            itemPrice: item.price.toString(),
                            image: item.imageUrl,
                            addedBy: item.addedBy.toString(),
                            restaurantName: item.restaurantName,
                          );
                        },
                      );
                    }),
                    kHiegth9,
                    const AddingMoreItemCard(),
                  ],
                ),
              ),
              const OneTextHeading(heading: "Offers & Benefits"),
              kHiegth15,
              const OffersAndBenefitsCard(),
              kHiegth15,
              const OneTextHeading(heading: "Bill Details"),
              kHiegth15,
              BillDetailsCard(
                restaurantName: restaurantName,
                addedBy: addedBy,
              ),
              kHiegth15,
              const TermsAndCondition(),
              kHiegth20,
            ],
          ),
        ),
      ),
    );
  }
}

























// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
// import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
// import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
// import 'package:ontrend_food_and_e_commerce/view/pages/widgets/offers_and_benefits_card.dart';
// import 'package:ontrend_food_and_e_commerce/view/pages/widgets/add_to_cart_card.dart';
// import 'package:ontrend_food_and_e_commerce/view/pages/widgets/adding_more_item_card.dart';
// import 'package:ontrend_food_and_e_commerce/view/pages/widgets/bill_details_card.dart';
// import 'package:ontrend_food_and_e_commerce/view/pages/widgets/terms_and_condition.dart';
// import 'package:ontrend_food_and_e_commerce/view/widgets/onetext_heading.dart';

// class AddToCartPage extends StatefulWidget {
//   final String addedBy;
//   final String restaurantName;
//   const AddToCartPage({super.key, required this.addedBy, required this.restaurantName,});

//   @override
//   State<AddToCartPage> createState() => _AddToCartPageState();
// }

// class _AddToCartPageState extends State<AddToCartPage> {
//   List<Map<String, dynamic>> cartItems = [];
//   @override
//   Widget build(BuildContext context) {
//     final CartController cartController = Get.put(CartController());
//      String addedBy = widget.addedBy;
//      String restaurantName = widget.restaurantName;
//     return Scaffold(
//       backgroundColor: kWhite,
//       appBar: AppBar(
//         backgroundColor: kWhite,
//         centerTitle: false,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_new,
//           ),
//         ),
//         title: Row(
//           children: [
//             Image.asset("assets/icons/location_icon.png"),
//             kWidth10,
//             const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Janub Ad Dahariz",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Salala, Oman",
//                       style: TextStyle(color: kBlue, fontSize: 10),
//                     ),
//                     Icon(
//                       Icons.keyboard_arrow_down,
//                       size: 16,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 margin: const EdgeInsets.symmetric(
//                   vertical: 20,
//                   horizontal: 11,
//                 ),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.blueGrey.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(
//                     10,
//                   ),
//                   border: Border.all(color: kBorderLiteBlack),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Obx(() {
//                       return ListView.builder(
//                         shrinkWrap: true, // Wrap content to avoid overflow
//                         itemCount: cartController.cartItems.length,
//                         itemBuilder: (context, index) {
//                           final item = cartController.cartItems[index];
//                           return AddToCartCard(
//                             itemName: item.name,
//                             itemPrice: item.price.toString(),
//                             image: item.imageUrl,
//                             addedBy: item.addedBy.toString(),
//                             restaurantName: item.restaurantName,
//                           );
//                         },
//                       );
//                     }),
//                     kHiegth9,
//                     const AddingMoreItemCard(),
//                   ],
//                 ),
//               ),
//               const OneTextHeading(heading: "Offers & Benefits"),
//               kHiegth15,
//               const OffersAndBenefitsCard(),
//               kHiegth15,
//               const OneTextHeading(heading: "Bill Details"),
//               kHiegth15,
//               BillDetailsCard(
//                 restaurantName: restaurantName,
//                 addedBy: addedBy,

//               ),
//               kHiegth15,
//               const TermsAndCondition(),
//               kHiegth20,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
