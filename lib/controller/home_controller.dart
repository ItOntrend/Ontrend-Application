import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/repository/search_repository.dart';

class HomeController extends GetxController {
  RxBool isProductLoading = RxBool(false);
  RxList<ItemModel> productList = RxList();
  Future<void> getProducts() async {
    isProductLoading.value = true;
    productList.clear();
    productList.value = await SearchRepository.getProducts();
    isProductLoading.value = false;
    print("products........");
    print("${productList.value}");
    print("${productList[0].name}");
  }

  Future<List<ItemModel>> searchProducts(String query) async {
    return productList.where((item) {
      return item.name.toLowerCase().contains(query.toLowerCase()) ||
          item.localName.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
