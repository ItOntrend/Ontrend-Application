import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/location_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/model/order_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  final userController = Get.find<UserController>();
  final locationController = Get.put(LocationController());
  final vendorController = VendorController.instance;
  var cartItems = {}.obs;
  var itemTotal = 0.0.obs;
  final deliveryFee = 0.0.obs;
  final platformFee = 15.0;
  bool isReturningFromCart = false;
  var isFabVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString('cartItems');
    if (cartString != null) {
      final Map<String, dynamic> cartMap = json.decode(cartString);
      cartItems.value = cartMap.map((key, value) {
        return MapEntry(key, {
          'item': ItemModel.fromJson(value['item']),
          'quantity': (value['quantity'] as num).toInt(),
        });
      });
      calculateDeliveryFee();
      updateItemTotal();
    }
  }

  Future<void> calculateDeliveryFee() async {
    if (cartItems.isNotEmpty) {
      final vendorId = cartItems.values.first['item'].addedBy;
      print('Vendor ID: $vendorId');

      final vendor = await vendorController.getVendorByUId(userId: vendorId);
      print('Vendor Details: ${vendor?.toJson()}');

      if (vendor != null) {
        final distance = vendorController.calculateDistance(vendor.location);
        print('Calculated Distance: $distance');

        double fee;
        if (distance <= 1) {
          fee = 0.190;
        } else if (distance <= 2) {
          fee = 0.290;
        } else if (distance <= 3) {
          fee = 0.390;
        } else if (distance <= 4) {
          fee = 0.490;
        } else if (distance <= 5) {
          fee = 0.590;
        } else if (distance <= 6) {
          fee = 0.860;
        } else if (distance <= 8) {
          fee = 1.040;
        } else {
          fee = 1.400;
        }

        deliveryFee.value = fee;
        // Example fee calculation: $5 base fee + $2 per km
        //deliveryFee.value = 5.0 + (2.0 * distance);
        print('Delivery Fee: ${deliveryFee.value}');
      } else {
        deliveryFee.value = 0.0; // Set default fee if vendor not found
      }
    }
  }

  Future<void> saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = json.encode(cartItems);
    await prefs.setString('cartItems', cartString);
  }

  @override
  void onClose() {
    saveCartItems();
    super.onClose();
  }

  void addItemToCart(ItemModel item) {
    if (cartItems.isNotEmpty) {
      // Check if the item is from a different vendor
      final existingVendorId = cartItems.values.first['item'].addedBy;
      if (existingVendorId != item.addedBy) {
        // Show an alert dialog
        Get.defaultDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          backgroundColor: kWhite,
          title: 'Start a new order?',
          content: Text('You can only order from one vendor at a time.'),
          confirm: ElevatedButton(
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(kWhite)),
            onPressed: () {
              // Clear the cart and add the new item
              cartItems.clear();
              addItemToCartConfirmed(item);
              Get.back(); // Close the dialog
            },
            child: Text(
              'Yes',
              style: TextStyle(color: kDarkOrange),
            ),
          ),
          cancel: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(kDarkOrange)),
            onPressed: () {
              Get.back(); // Close the dialog without adding the item
            },
            child: Text(
              'No',
              style: TextStyle(color: kWhite),
            ),
          ),
        );
        return;
      }
    }
    addItemToCartConfirmed(item);
  }

  void addItemToCartConfirmed(ItemModel item) {
    if (cartItems.containsKey(item.name)) {
      cartItems[item.name]['quantity'] =
          (cartItems[item.name]['quantity'] + 1).toInt();
    } else {
      cartItems[item.name] = {'item': item, 'quantity': 1};
    }
    updateItemTotal();
    cartItems.refresh();
    saveCartItems();
    calculateDeliveryFee();

    // Update isFabVisible to true
    isFabVisible.value = true;

    if (isReturningFromCart) {
      showSnackBar('Item added to cart'.tr);
      isReturningFromCart = false;
    }
  }

  void removeItemFromCart(ItemModel item) {
    if (cartItems.containsKey(item.name) &&
        cartItems[item.name]['quantity'] > 1) {
      cartItems[item.name]['quantity'] =
          (cartItems[item.name]['quantity'] - 1).toInt();
    } else {
      cartItems.remove(item.name);
    }
    updateItemTotal();
    cartItems.refresh();
    saveCartItems();
    calculateDeliveryFee();

    if (isReturningFromCart) {
      showSnackBar('Item removed from cart');
      isReturningFromCart = false; // Reset the flag
    }
  }

  int getItemQuantity(ItemModel item) {
    return cartItems.containsKey(item.name)
        ? cartItems[item.name]['quantity']
        : 0;
  }

  void removeItemEntirely(ItemModel item) {
    cartItems.remove(item.name);
    updateItemTotal();
    cartItems.refresh();
    saveCartItems();
    calculateDeliveryFee();

    if (isReturningFromCart) {
      showSnackBar('Item removed from cart');
      isReturningFromCart = false; // Reset the flag
    }
  }

  int getItemCount() {
    int itemCount = 0;
    cartItems.forEach((key, value) {
      itemCount += value['quantity'] as int;
    });
    return itemCount;
  }

  double get totalAmount => itemTotal.value == 0
      ? 0
      : itemTotal.value + deliveryFee.value + platformFee;

  void updateItemTotal() {
    double total = 0.0;
    cartItems.forEach((key, value) {
      total += (value['item'].price * value['quantity']).toDouble();
    });
    itemTotal.value = total;
  }

  String generateOrderId() {
    DateTime now = DateTime.now();
    String timestamp = now.microsecondsSinceEpoch.toString().substring(0, 8);

    Random random = Random();
    String randomDigits = '';
    for (int i = 0; i < 8; i++) {
      randomDigits += random.nextInt(10).toString();
    }

    return timestamp + randomDigits;
  }

  Future<String> placeOrder(String userId, String paymentType, String userName,
      String userPhone) async {
    String orderId = generateOrderId();
    try {
      final currentLat = locationController.currentPosition.value.latitude;
      final currentLng = locationController.currentPosition.value.longitude;

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
                  itemPrice:
                      double.tryParse(value['item'].price.toString()) ?? 0,
                  itemQuantity: (value['quantity'] as num).toInt(),
                  total: (value['item'].price * value['quantity']).toDouble(),
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
            address: locationController.currentAddress.value,
            apartmentNumber: "apartmentNumber",
            city: locationController.cityName.value,
            houseNumber: "houseNumber",
            lat: currentLat,
            lng: currentLng,
            street: locationController.streetName.value),
        deliveryAccepted: false,
        restaurantLocation: RestaurantLocation(lat: 0.0, lng: 0.0),
        assignedDeliveryPartnerId: "",
      );

      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .set(order.toJson());
      cartItems.clear(); // Clear cart after placing order
      saveCartItems(); // Save the cart items
    } catch (e) {
      print('Error placing order: $e');
    }
    return orderId;
  }

  void setReturningFromCart() {
    isReturningFromCart = true;
  }

  void showSnackBar(String message) {
    Get.snackbar('Cart', message, snackPosition: SnackPosition.BOTTOM);
  }

  Stream<OrderModel> getOrderStream(String orderId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .snapshots()
        .map((snapshot) => OrderModel.fromJson(snapshot.data()!));
  }
}

























// import 'dart:convert';
// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
// import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
// import 'package:ontrend_food_and_e_commerce/model/order_modal.dart';
// import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/select_location_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CartController extends GetxController {
//   final userController = Get.find<UserController>();
//   final locationController = Get.put(LocationController());
//   var cartItems = {}.obs;
//   var itemTotal = 0.0.obs;
//   final deliveryFee = 25.0;
//   final platformFee = 15.0;

//   @override
//   void onInit() {
//     super.onInit();
//     loadCartItems();
//   }

//   Future<void> loadCartItems() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartString = prefs.getString('cartItems');
//     if (cartString != null) {
//       final Map<String, dynamic> cartMap = json.decode(cartString);
//       cartItems.value = cartMap.map((key, value) {
//         return MapEntry(key, {
//           'item': ItemModel.fromJson(value['item']),
//           'quantity': value['quantity'],
//         });
//       });
//       updateItemTotal();
//     }
//   }

//   Future<void> saveCartItems() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartString = json.encode(cartItems);
//     await prefs.setString('cartItems', cartString);
//   }

//   @override
//   void onClose() {
//     saveCartItems();
//     super.onClose();
//   }

//   void addItemToCart(ItemModel item) {
//     if (cartItems.containsKey(item.name)) {
//       cartItems[item.name]['quantity']++;
//     } else {
//       cartItems[item.name] = {'item': item, 'quantity': 1};
//     }
//     updateItemTotal();
//     cartItems.refresh();
//     saveCartItems(); // Save the cart items
//   }

//   void removeItemFromCart(ItemModel item) {
//     if (cartItems.containsKey(item.name) &&
//         cartItems[item.name]['quantity'] > 1) {
//       cartItems[item.name]['quantity']--;
//     } else {
//       cartItems.remove(item.name);
//     }
//     updateItemTotal();
//     cartItems.refresh();
//     saveCartItems(); // Save the cart items
//   }

//   int getItemQuantity(ItemModel item) {
//     return cartItems.containsKey(item.name) ? cartItems[item.name]['quantity'] : 0;
//   }

//   void removeItemEntirely(ItemModel item) { 
//     cartItems.remove(item.name);
//     updateItemTotal();
//     cartItems.refresh();
//     saveCartItems(); // Save the cart items
//   }

//   double get totalAmount =>
//       itemTotal.value == 0 ? 0 : itemTotal.value + deliveryFee + platformFee;

//   void updateItemTotal() {
//     double total = 0.0;
//     cartItems.forEach((key, value) {
//       total += (value['item'].price * value['quantity']).toDouble();
//     });
//     itemTotal.value = total;
//   }

//   String generateOrderId() {
//     DateTime now = DateTime.now();
//     String timestamp = now.microsecondsSinceEpoch.toString().substring(0, 8);

//     Random random = Random();
//     String randomDigits = '';
//     for (int i = 0; i < 8; i++) {
//       randomDigits += random.nextInt(10).toString();
//     }

//     return timestamp + randomDigits;
//   }

//   Future<void> placeOrder(String userId, String paymentType, String userName,
//       String userPhone) async {
//     try {
//       String orderId = generateOrderId();
//       final currentLat = locationController.currentPosition.value.latitude;
//       final currentLng = locationController.currentPosition.value.longitude;

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
//                   itemPrice:
//                       double.tryParse(value['item'].price.toString()) ?? 0,
//                   itemQuantity: value['quantity'],
//                   total: (value['item'].price * value['quantity']).toDouble(),
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
//             address: locationController.currentAddress.value,
//             apartmentNumber: "apartmentNumber",
//             city: locationController.cityName.value,
//             houseNumber: "houseNumber",
//             lat: currentLat,
//             lng: currentLng,
//             street: locationController.streetName.value),
//         deliveryAccepted: false,
//         restaurantLocation: RestaurantLocation(lat: 0.0, lng: 0.0),
//         assignedDeliveryPartnerId: "",
//       );

//       await FirebaseFirestore.instance
//           .collection('orders')
//           .doc(orderId)
//           .set(order.toJson());
//       cartItems.clear(); // Clear cart after placing order
//       saveCartItems(); // Save the cart items
//     } catch (e) {
//       print('Error placing order: $e');
//     }
//   }
// }
