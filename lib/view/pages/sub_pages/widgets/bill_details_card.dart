import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/order_complete_splash_page.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/payment_option_page.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton.dart';

class BillDetailsCard extends StatefulWidget {
  const BillDetailsCard(
      {super.key, required this.addedBy, required this.restaurantName});
  final String addedBy;
  final String restaurantName;

  @override
  State<BillDetailsCard> createState() => _BillDetailsCardState();
}

class _BillDetailsCardState extends State<BillDetailsCard> {
  final CartController cartController = Get.find();
  final UserController userController = Get.find();

  @override
  void initState() {
    userController.fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16)
          .copyWith(bottom: 8, top: 16),
      height: 280.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHiegth6,
            BillDetailsRow(
              title: 'Item total',
              amount: cartController.itemTotal.value,
            ),
            kHiegth6,
            BillDetailsRow(
              title: 'Delivery fee',
              amount: cartController.deliveryFee,
            ),
            kHiegth6,
            BillDetailsRow(
              title: 'Platform fee',
              amount: cartController.platformFee,
            ),
            kHiegth6,
            BillDetailsRow(
              title: 'Total amount',
              amount: cartController.totalAmount,
              isBold: true,
            ),
            kHiegth10,
            GestureDetector(
              onTap: () {
                Get.to(
                  const PaymentOptionPage(),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 29.h,
                    width: 49.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(
                        color: kGrey,
                      ),
                    ),
                    child: Image.asset(
                      "assets/icons/cash_on_delivery.png",
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Change".tr,
                    style: TextStyle(
                      color: kGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  kWidth10,
                  Container(
                    height: 18.h,
                    width: 18.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: kOrange,
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    ),
                  ),
                ],
              ),
            ),
            kHiegth18,
            const Spacer(),
            MainBotton(
              onTap: () async {
                log("Place Order".tr);
                String userId = await LocalStorage.instance
                    .DataFromPrefs(key: HiveKeys.userData);

                if (cartController.totalAmount > 0) {
                  String orderId = await cartController.placeOrder(
                    userId,
                    'Cash on Delivery',
                    userController.firstName.value,
                    userController.number.value,
                  );

                  Get.to(() => OrderCompleteSplashPage(orderId: orderId));
                }
              },
              name: "Place Order",
            ),
          ],
        );
      }),
    );
  }
}

class BillDetailsRow extends StatelessWidget {
  const BillDetailsRow({
    super.key,
    required this.title,
    required this.amount,
    this.isBold = false,
  });

  final String title;
  final double amount;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        Text(
          'OMR ${amount.toStringAsFixed(3)}',
          style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}



























// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
// import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
// import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
// import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
// import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';
// import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/order_complete_page.dart';
// import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/payment_option_page.dart';

// class BillDetailsCard extends StatefulWidget {
//   const BillDetailsCard(
//       {super.key, required this.addedBy, required this.restaurantName});
//   final String addedBy;
//   final String restaurantName;

//   @override
//   State<BillDetailsCard> createState() => _BillDetailsCardState();
// }

// class _BillDetailsCardState extends State<BillDetailsCard> {
//   @override
//   final CartController cartController = Get.find();
//   final UserController userController = Get.find();

//   void initState() {
//     userController.fetchUserData();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // margin: const EdgeInsets.symmetric(
//       //   horizontal: 24,
//       //   vertical: 10,
//       // ),
//       padding: const EdgeInsets.symmetric(
//         horizontal: 12,
//         vertical: 8,
//       ),
//       height: 230.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(
//           10,
//         ),
//         color: Colors.blueGrey.withOpacity(0.1),
//         border: Border.all(
//           color: kBorderLiteBlack,
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Obx(
//             () => Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Item Total",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 Text(
//                   "OMR ${cartController.itemTotal.value}00",
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           kHiegth10,
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Delivery Partner fee",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               Text(
//                 "OMR 25.000",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//           kHiegth10,
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Platform fee",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               Text(
//                 "OMR 15.000",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//           kHiegth10,
//           GestureDetector(
//             onTap: () {
//               Get.to(
//                 const PaymentOptionPage(),
//               );
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   height: 29.h,
//                   width: 49.w,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(
//                       10,
//                     ),
//                     border: Border.all(
//                       color: kGrey,
//                     ),
//                   ),
//                   child: Image.asset(
//                     "assets/icons/cash_on_delivery.png",
//                   ),
//                 ),
//                 const Spacer(),
//                 const Text(
//                   "Change",
//                   style: TextStyle(
//                     color: kGreen,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 kWidth10,
//                 Container(
//                   height: 18.h,
//                   width: 18.w,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: kOrange,
//                     ),
//                   ),
//                   child: const Icon(
//                     Icons.arrow_forward_ios,
//                     size: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           kHiegth10,
//           GestureDetector(
//             onTap: () async {
//               String userId = await LocalStorage.instance
//                   .DataFromPrefs(key: HiveKeys.userData);

//               if (cartController.totalAmount > 0) {
//                 cartController.placeOrder(
//                   userId,
//                   'Cash on Delivery',
//                   userController.firstName.value,
//                   userController.number.value,
//                 );
//               }
//               if (cartController.totalAmount > 0) {
//                 Get.to(const OrderCompletePage());
//               }
//             },
//             child: Obx(
//               () => Container(
//                 height: 48.h,
//                 width: 308.w,
//                 decoration: BoxDecoration(
//                   color: kOrange,
//                   borderRadius: BorderRadius.circular(
//                     50,
//                   ),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Pay ${cartController.totalAmount > 0 ? cartController.totalAmount : 0}",
//                     style: const TextStyle(
//                       color: kWhite,
//                       fontSize: 23,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           kHiegth6,
//         ],
//       ),
//     );
//   }
// }
