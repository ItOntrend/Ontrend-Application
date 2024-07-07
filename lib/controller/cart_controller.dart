import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/model/order_modal.dart';

class CartController extends GetxController {
  final userController = Get.find<UserController>();
  var cartItems = {}.obs; // Using a map to store items with quantities
  var itemTotal = 0.0.obs;
  final deliveryFee = 25.0;
  final platformFee = 15.0;

  void addItemToCart(ItemModel item) {
    if (cartItems.containsKey(item.name)) {
      cartItems[item.name]!['quantity']++;
    } else {
      cartItems[item.name] = {'item': item, 'quantity': 1};
    }
    updateItemTotal();
    cartItems.refresh();
  }

  void removeItemFromCart(ItemModel item) {
    if (cartItems.containsKey(item.name) && cartItems[item.name]!['quantity'] > 1) {
      cartItems[item.name]!['quantity']--;
    } else {
      cartItems.remove(item.name);
    }
    updateItemTotal();
    cartItems.refresh();
  }
  void removeItemEntirely(ItemModel item) {
    cartItems.remove(item);
  }

  double get totalAmount =>
      itemTotal.value == 0 ? 0 : itemTotal.value + deliveryFee + platformFee;

  void updateItemTotal() {
    double total = 0.0;
    cartItems.forEach((key, value) {
      total += value['item'].price * value['quantity'];
    });
    itemTotal.value = total;
  }

  String generateOrderId() {
    DateTime now = DateTime.now();
    String timestamp = now.microsecondsSinceEpoch
        .toString()
        .substring(0, 8); // Get first 8 digits of microseconds since epoch

    Random random = Random();
    String randomDigits = '';
    for (int i = 0; i < 8; i++) {
      randomDigits += random.nextInt(10).toString();
    }

    return timestamp + randomDigits;
  }

  Future<void> placeOrder(String userId, String paymentType, String userName, String userPhone) async {
    try {
      String orderId = generateOrderId();

      OrderModel order = OrderModel(
        userName: userName,
        deliveryAcceptedBy:
            DeliveryAcceptedBy(name: "", phoneNumber: "", id: ""),
        userPhone: userPhone,
        addedBy: cartItems.values.first['item'].addedBy,
        adminEarnings: platformFee,
        discountApplied: 0.0,
        items: cartItems.values
            .map((value) => Item(
                  addedBy: value['item'].addedBy.toString(),
                  itemName: value['item'].name,
                  itemPrice: double.tryParse(value['item'].price.toString()) ?? 0,
                  itemQuantity: value['quantity'],
                  total: value['item'].price * value['quantity'],
                ))
            .toList(),
        promoCode: null,
        status: 'Pending',
        totalPrice: totalAmount,
        userId: userId,
        orderTimestamp: DateTime.now(),
        orderID: orderId,
        paymentType: paymentType,
        restaurantName: cartItems.values.first['item'].restaurantName,
        deliveryLocation: DeliveryLocation(
            address: "address",
            apartmentNumber: "apartmentNumber",
            city: "city",
            houseNumber: "houseNumber",
            lat: 7775664665,
            lng: 97867678567,
            street: "street"),
        deliveryAccepted: false,
      );

      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .set(order.toJson());
      cartItems.clear(); // Clear cart after placing order
    } catch (e) {
      print('Error placing order: $e');
    }
  }
}























// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
// import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
// import 'package:ontrend_food_and_e_commerce/model/order_modal.dart';

// class CartController extends GetxController {
//   final userController = Get.find<UserController>();
//   // var cartItems = <ItemModel>[].obs;
//   var cartItems = {}.obs;
//   var itemTotal = 0.0.obs;
//   final deliveryFee = 25.0;
//   final platformFee = 15.0;

//   void addItemToCart(ItemModel item) {
//     if (cartItems.containsKey(item.name)) {
//       cartItems[item.name]['quantity']++;
//     } else {
//       cartItems[item.name] = {'item': item, 'quantity': 1};
//     }
//     updateItemTotal();
//   }

//   void removeItemFromCart(ItemModel item) {
//     if (cartItems.containsKey(item.name) && cartItems[item.name]['quantity'] > 1) {
//       cartItems[item.name]['quantity']--;
//     } else {
//       cartItems.remove(item.name);
//     }
//     updateItemTotal();
//   }

//   double get totalAmount =>
//       itemTotal.value == 0 ? 0 : itemTotal.value + deliveryFee + platformFee;

//   void updateItemTotal() {
//     double total = 0.0;
//     cartItems.forEach((key, value) {
//       total += value['item'].price * value['quantity'];
//     });
//     itemTotal.value = total;
//   }
  

//   String generateOrderId() {
//     DateTime now = DateTime.now();
//     String timestamp = now.microsecondsSinceEpoch
//         .toString()
//         .substring(0, 8); // Get first 8 digits of microseconds since epoch

//     Random random = Random();
//     String randomDigits = '';
//     for (int i = 0; i < 8; i++) {
//       randomDigits += random.nextInt(10).toString();
//     }

//     return timestamp + randomDigits;
//   }

//   Future<void> placeOrder(String userId,
//       String paymentType,String userName, String userPhone,) async {
//     try {
//       String orderId = generateOrderId();

//       OrderModel order = OrderModel(
//         userName: userName,
//         deliveryAcceptedBy:
//             DeliveryAcceptedBy(name: "", phoneNumber: "", id: ""),
//         userPhone: userPhone,
//         addedBy: cartItems.values.first['item'].addedBy,
//         adminEarnings: platformFee,
//         discountApplied: 0.0,
//         items: cartItems.values
//             .map((value) => Item(
//                   addedBy: value['item'].addedBy.toString(),
//                   itemName: value['item'].name,
//                   itemPrice: double.tryParse(value['item'].price.toString()) ?? 0,
//                   itemQuantity: value['quantity'],
//                   total: value['item'].price * value['quantity'],
//                 ))
//             .toList(),
//         promoCode: null,
//         status: 'Pending',
//         totalPrice: totalAmount,
//         userId: userId,
//         orderTimestamp: DateTime.now(),
//         orderID: orderId,
//         paymentType: paymentType,
//         restaurantName: cartItems.values.first['item'].restaurantName,
//         deliveryLocation: DeliveryLocation(
//             address: "address",
//             apartmentNumber: "apartmentNumber",
//             city: "city",
//             houseNumber: "houseNumber",
//             lat: 7775664665,
//             lng: 97867678567,
//             street: "street"),
//         deliveryAccepted: false,
//       );

//       await FirebaseFirestore.instance
//           .collection('orders')
//           .doc(orderId)
//           .set(order.toJson());
//       cartItems.clear(); // Clear cart after placing order
//     } catch (e) {
//       print('Error placing order: $e');
//     }
//   }
// }
