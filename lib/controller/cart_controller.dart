import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/location_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/user_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/model/order_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  final userController = Get.find<UserController>();
  final locationController = Get.put(LocationController());
  var cartItems = {}.obs;
  var itemTotal = 0.0.obs;
  final deliveryFee = 25.0;
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
      updateItemTotal();
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
    if (cartItems.containsKey(item.name)) {
      cartItems[item.name]['quantity'] =
          (cartItems[item.name]['quantity'] + 1).toInt();
    } else {
      cartItems[item.name] = {'item': item, 'quantity': 1};
    }
    updateItemTotal();
    cartItems.refresh();
    saveCartItems();

    // Update isFabVisible to true
    isFabVisible.value = true;

    if (isReturningFromCart) {
      showSnackBar('Item added to cart');
      isReturningFromCart = false;
    }
  }

  void hideFab() {
    isFabVisible.value = false;
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

  double get totalAmount =>
      itemTotal.value == 0 ? 0 : itemTotal.value + deliveryFee + platformFee;

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
      cartItems.clear();
      itemTotal.value = 0.0; // Clear cart after placing order
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
