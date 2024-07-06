import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/model/order_modal.dart';

class CartController extends GetxController {
  var cartItems = <ItemModel>[].obs;
  var itemTotal = 0.0.obs;
  final deliveryFee = 25.0;
  final platformFee = 15.0;

  void addItemToCart(ItemModel item) {
    cartItems.add(item);
    updateItemTotal();
  }

  void removeItemFromCart(ItemModel item) {
    cartItems.remove(item);
    updateItemTotal();
  }

  double get totalAmount =>
      itemTotal.value == 0 ? 0 : itemTotal.value + deliveryFee + platformFee;

  void updateItemTotal() {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.price;
    }
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

  Future<void> placeOrder(
      String userId, String paymentType, String restaurantName) async {
    try {
      String orderId = generateOrderId();

      OrderModel order = OrderModel(
        addedBy: userId,
        adminEarnings: platformFee,
        discountApplied: 0.0,
        items: cartItems
            .map((item) => Item(
                  addedBy: item.addedBy.toString(),
                  itemName: item.name,
                  itemPrice: double.tryParse(item.price.toString()) ?? 0,
                  itemQuantity: 1, // Adjust quantity as needed
                  total: totalAmount,
                ))
            .toList(),
        promoCode: null,
        status: 'Pending',
        totalPrice: totalAmount,
        userId: userId,
        orderTimestamp: DateTime.now(),
        orderID: orderId,
        paymentType: paymentType,
        restaurantName: restaurantName,
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
