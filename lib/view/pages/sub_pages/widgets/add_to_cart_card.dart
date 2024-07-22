import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';

class AddToCartCard extends StatefulWidget {
  const AddToCartCard({
    super.key,
    required this.itemName,
    required this.localName,
    required this.localTag,
    required this.itemPrice,
    required this.image,
    required this.addedBy,
    required this.restaurantName,
  });

  final String itemName;
  final String localName;
  final String localTag;
  final String itemPrice;
  final String image;
  final String addedBy;
  final String restaurantName;

  @override
  State<AddToCartCard> createState() => _AddToCartCardState();
}

class _AddToCartCardState extends State<AddToCartCard> {
  final CartController cartController = Get.find();
  final LanguageController langontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    ItemModel item = ItemModel(
      name: widget.itemName,
      localName: widget.localName,
      localTag: widget.localTag,
      price: int.parse(widget.itemPrice),
      imageUrl: widget.image,
      description: "",
      addedBy: widget.addedBy,
      restaurantName: widget.restaurantName,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 7).copyWith(
        left: 13,
        right: 7,
      ),
      height: 101.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                langontroller.currentLanguage.value.languageCode == "ar"
                    ? widget.localName
                    : widget.itemName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              kHiegth6,
              Text(
                " ${"OMR".tr} ${widget.itemPrice}",
                style: const TextStyle(
                  color: kOrange,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              kHiegth6,
              Obx(() {
                final cartItem = cartController.cartItems[item.name];
                if (cartItem == null) {
                  return Text(
                    "Item not in cart".tr,
                    style: const TextStyle(
                      color: kRed,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }
                int quantity = cartItem['quantity'] ?? 1;
                return Container(
                  height: 22.h,
                  // width: 124.w,
                  decoration: BoxDecoration(
                    color: kGreen,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.only(bottom: 1),
                        onPressed: () {
                          cartController.removeItemFromCart(item);
                        },
                        icon: const Icon(
                          Icons.remove,
                          size: 14,
                        ),
                        color: kWhite,
                      ),
                      Text(
                        "$quantity",
                        style: const TextStyle(
                          color: kWhite,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.only(bottom: 1),
                        onPressed: () {
                          cartController.addItemToCart(item);
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 14,
                        ),
                        color: kWhite,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Stack(
              children: [
                Align(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: widget.image.isNotEmpty
                        ? Image.network(widget.image)
                        : Container(
                            height: 88.h,
                            width: 117.w,
                            decoration: BoxDecoration(
                              color: kLiteBackground,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "No Image Available".tr,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}






























// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
// import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
// import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
// import 'package:ontrend_food_and_e_commerce/model/item_model.dart';

// class AddToCartCard extends StatefulWidget {
//   const AddToCartCard({
//     super.key,
//     required this.itemName,
//     required this.itemPrice,
//     required this.image,
//     required this.addedBy,
//     required this.restaurantName,
//   });

//   final String itemName;
//   final String itemPrice;
//   final String image;
//   final String addedBy;
//   final String restaurantName;

//   @override
//   State<AddToCartCard> createState() => _AddToCartCardState();
// }

// class _AddToCartCardState extends State<AddToCartCard> {
//   final CartController cartController = Get.find();
//   int _itemCount = 1;

//   void _incrementCount() {
//     setState(() {
//       _itemCount++;
//     });
//   }

//   void _decrementCount() {
//     if (_itemCount == 1) {
//       _showRemoveItemDialog();
//     } else if (_itemCount > 0) {
//       setState(() {
//         _itemCount--;
//       });
//     }
//   }

//   void _showRemoveItemDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Remove Item'),
//           content: const Text('Do you want to remove this item from the cart?'),
//           actions: [
//             TextButton(
//               child: const Text('No'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('Yes'),
//               onPressed: () {
//                 setState(() {
//                   _itemCount = 0;
//                 });

//                 cartController.removeItemFromCart(
//                   ItemModel(
//                     name: widget.itemName,
//                     price: int.parse(widget.itemPrice),
//                     imageUrl: widget.image,
//                     description: "",
//                     addedBy: widget.addedBy,
//                     restaurantName: widget.restaurantName,
//                   ),
//                 );
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       padding: const EdgeInsets.symmetric(vertical: 7).copyWith(
//         left: 13,
//         right: 7,
//       ),
//       height: 101.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: kWhite,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             children: [
//               Text(
//                 widget.itemName,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               kHiegth6,
//               Text(
//                 widget.itemPrice,
//                 style: const TextStyle(
//                   color: kOrange,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               kHiegth6,
//               Container(
//                 height: 22.h,
//                 width: 108.w,
//                 decoration: BoxDecoration(
//                   color: kGreen,
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     IconButton(
//                       padding: const EdgeInsets.only(bottom: 1),
//                       onPressed: _decrementCount,
//                       icon: const Icon(
//                         Icons.remove,
//                         size: 14,
//                       ),
//                       color: kWhite,
//                     ),
//                     Text(
//                       "$_itemCount",
//                       style: const TextStyle(
//                         color: kWhite,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     IconButton(
//                       padding: const EdgeInsets.only(bottom: 1),
//                       onPressed: _incrementCount,
//                       icon: const Icon(
//                         Icons.add,
//                         size: 14,
//                       ),
//                       color: kWhite,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Align(
//             alignment: Alignment.topRight,
//             child: Stack(
//               children: [
//                 Align(
//                   child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.network(widget.image)),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
