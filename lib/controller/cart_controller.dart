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
import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  final userController = Get.find<UserController>();
  final locationController = Get.put(LocationController());
  final vendorController = VendorController.instance;
  var cartItems = {}.obs;
  var itemTotal = 0.0.obs;
  final deliveryFee = 0.0.obs;
  final platformFeePercentage = 0.025;
  bool isReturningFromCart = false;
  var isFabVisible = false.obs;
  var rewardPoints = 0.0.obs;
  var serviceFee = 0.0.obs;
  var deliveryCharge = 0.0.obs;
  var commisionrate = 20.00.obs;

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
    loadRewardPoints();
  }

  Future<void> loadRewardPoints() async {
    final prefs = await SharedPreferences.getInstance();
    rewardPoints.value = prefs.getDouble('rewardPoints') ?? 0.0;
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

  Future<void> calculateDeliveryCharge() async {
    if (cartItems.isNotEmpty) {
      final vendorId = cartItems.values.first['item'].addedBy;
      print('Vendor ID: $vendorId');

      final vendor = await vendorController.getVendorByUId(userId: vendorId);
      print('Vendor Details: ${vendor?.toJson()}');

      if (vendor != null) {
        final distance = vendorController.calculateDistance(vendor.location);
        print('Calculated Distance: $distance');
        final commision = vendor.commmisionRate;
        double charge;
        if (distance <= 6) {
          charge = 0.600;
        } else if (distance <= 10) {
          charge = 0.800;
        } else if (distance <= 12) {
          charge = 0.900;
        } else {
          charge = 1.040;
        }

        deliveryCharge.value = charge;
        commisionrate.value = (commision / 100);
        print("........commision rate is......${commisionrate.value}");
        // Example fee calculation: $5 base fee + $2 per km
        //deliveryFee.value = 5.0 + (2.0 * distance);
        print('Delivery Charge: ${deliveryCharge.value}');
      } else {
        deliveryCharge.value = 0.0; // Set default fee if vendor not found
      }
    }
  }

  Future<void> saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = json.encode(cartItems);
    await prefs.setString('cartItems', cartString);
  }

  Future<void> saveRewardPoints() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('rewardPoints', rewardPoints.value);
  }

  Future<void> updateRewardPoints(String userId, double rewardPoints) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'rewardPoints': rewardPoints,
      });
      print('Reward points updated successfully');
    } catch (e) {
      print('Error updating reward points: $e');
    }
  }

  @override
  void onClose() {
    saveCartItems();
    saveRewardPoints();
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
          content: const Text('You can only order from one vendor at a time.'),
          confirm: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(kWhite)),
            onPressed: () {
              // Clear the cart and add the new item
              cartItems.clear();
              addItemToCartConfirmed(item);
              Get.back(); // Close the dialog
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: kDarkOrange),
            ),
          ),
          cancel: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(kDarkOrange)),
            onPressed: () {
              Get.back(); // Close the dialog without adding the item
            },
            child: const Text(
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
    calculateDeliveryCharge();
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
    calculateDeliveryCharge();
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
      : itemTotal.value + deliveryFee.value + serviceFee.value;

  void updateItemTotal() {
    double total = 0.0;
    cartItems.forEach((key, value) {
      total += (value['item'].price * value['quantity']).toDouble();
    });
    itemTotal.value = total;
    serviceFee.value = total * platformFeePercentage; // Update service fee
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> orderNotes = prefs.getStringList('requests') ?? [];

    try {
      final currentLat = locationController.currentPosition.value.latitude;
      final currentLng = locationController.currentPosition.value.longitude;
      double adminEarnings = itemTotal.value * commisionrate.value;
      print("Admin Earnings...$adminEarnings"); // 2% of item total
      double adminTotalEarnings =
          adminEarnings + serviceFee.value + deliveryFee.value;

      // If there's an assigned delivery person, subtract the delivery fee from the total earnings

      // Adjust this if you have a different fee for delivery persons
      adminTotalEarnings -= deliveryCharge.value;

      OrderModel order = OrderModel(
        userName: userName,
        deliveryAcceptedBy:
            DeliveryAcceptedBy(name: "", phoneNumber: "", id: ""),
        userPhone: userPhone,
        addedBy: cartItems.values.first['item'].addedBy,
        adminEarnings: adminTotalEarnings,
        servicFee: serviceFee.value,
        deliveryFee: deliveryFee.value,
        deliveryCharge: deliveryCharge.value,
        discountApplied: 0.0,
        items: cartItems.values
            .map((value) => Item(
                  addedBy: value['item'].addedBy.toString(),
                  itemName: value['item'].name,
                  localName: value['item'].localName,
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
        assignedDeliveryPartnerId: '',
        deliveryAccepted: false,
        restaurantLocation: RestaurantLocation(lat: 0.0, lng: 0.0),
        orderNotes: orderNotes,
      );

      // Ensure the orderId is not empty
      if (orderId.isEmpty) {
        throw Exception('Order ID is empty');
      }

      // Save order to Firestore
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .set(order.toJson());

      // Fetch user document and update reward points
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (!userDoc.exists) {
        throw Exception('User document does not exist');
      }

      double rewardPoints = 0.0;
      try {
        rewardPoints = (userDoc['rewardPoints'] as num).toDouble();
      } catch (e) {
        print('Error parsing reward points: $e');
      }
      rewardPoints += itemTotal.value * 62;

      // Update reward points in Firebase and Local Storage
      await updateRewardPoints(userId, rewardPoints);

      await LocalStorage.instance.writeDataToPrefs(
        key: 'rewardPoints',
        value: rewardPoints,
      );
      // Update admin earnings in superAdmin document
      DocumentSnapshot superAdminDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc('dbDs1m9ORGMzcbvhWmaPAI6Sl5i2')
          .get();
      if (superAdminDoc.exists) {
        // Ensure the field is treated as a double
        double currentAdminEarnings =
            (superAdminDoc['adminEarnings'] as num).toDouble();
        double newAdminEarnings = currentAdminEarnings + adminTotalEarnings;
        await FirebaseFirestore.instance
            .collection('users')
            .doc('dbDs1m9ORGMzcbvhWmaPAI6Sl5i2')
            .update({
          'adminEarnings': newAdminEarnings,
        });
        print('Admin earnings updated successfully');
      } else {
        throw Exception('Super admin document does not exist');
      }

      // Clean up
      cartItems.clear();
      itemTotal.value = 0.0;
      serviceFee.value = 0.0;
      deliveryFee.value = 0.0;
      isFabVisible.value = false;
      prefs.remove('requests');
      await saveRewardPoints();
      saveCartItems();

      Get.snackbar('Order', 'Order has been placed successfully');
      return orderId;
    } catch (e) {
      print('Error placing order: $e');
      Get.snackbar('Error', 'Failed to place the order');
      return '';
    }
  }

  void showSnackBar(String message) {
    Get.snackbar('Cart', message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: kWhite,
        colorText: kDarkOrange);
  }
}
