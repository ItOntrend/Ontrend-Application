import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/repository/search_repository.dart';

class HomeController extends GetxController {
  LanguageController lang = Get.put(LanguageController());
  RxBool isProductLoading = RxBool(false);
  RxList<ProductModel> productList = RxList();
  Future<void> getProducts() async {
    isProductLoading.value = true;
    productList.clear();
    productList.value = await SearchRepository.getProducts();
    isProductLoading.value = false;
    print("products........");
    print("${productList}");
    print("${productList[0].name}");
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    final currentLanguageCode = lang.currentLanguage.value.languageCode;

    final filteredProducts = productList.where((item) {
      final itemName = currentLanguageCode == 'ar' ? item.localName : item.name;
      final restaurantName = currentLanguageCode == 'ar'
          ? item.arabicRestaurantName
          : item.restaurantName;

      return itemName.toLowerCase().contains(query.toLowerCase()) ||
          restaurantName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return filteredProducts;
  } // Method to get unique restaurant names from the filtered products

  List<ProductModel> getUniqueRestaurants(List<ProductModel> products) {
    final Set<String> restaurantNames = {};
    final List<ProductModel> uniqueRestaurants = [];

    for (var product in products) {
      if (restaurantNames.add(product.restaurantName)) {
        uniqueRestaurants.add(product);
      }
    }

    return uniqueRestaurants;
  }
}
