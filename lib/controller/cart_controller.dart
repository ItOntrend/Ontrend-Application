import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';

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
}
