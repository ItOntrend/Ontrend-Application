import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/repository/category_repository.dart';
import 'package:ontrend_food_and_e_commerce/repository/food_repository.dart';

class FoodController extends GetxController {
  RxBool isCategoryLoading = RxBool(false);
  RxList<CategoryModel> categoryList = RxList();
  RxBool isProductLoading = RxBool(false);
  RxList<ItemModel> productList = RxList();
  @override
  void onInit() {
    super.onInit();
    getCategories();
    print("fetching.....................................................");
  }

  Future<void> getCategories() async {
    isCategoryLoading.value = true;
    categoryList.clear();
    categoryList.value = await CategoryRepository.getCategories();
    print('Fetched Categories: ${categoryList.length}');
    for (var category in categoryList) {
      print(
          'Category: ${category.name}, ${category.localName}, ${category.imageUrl}');
    }
    isCategoryLoading.value = false;
  }

  Future<void> getProducts() async {
    isProductLoading.value = true;
    productList.clear();
    productList.value = await FoodRepository.getProducts();
    isProductLoading.value = false;
    print("products........");
    print("${productList}");
    print("${productList[0].name}");
  }

  Future<List<ItemModel>> searchProducts(String query) async {
    /*return productList.where((item) {
      return item.name.toLowerCase().contains(query.toLowerCase()) ||
          item.restaurantName.toLowerCase().contains(query.toLowerCase());
    }).toList();*/
    // Filter the products based on the query
    final filteredProducts = productList.where((item) {
      return (item.name.toLowerCase().contains(query.toLowerCase())) ||
          (item.restaurantName.toLowerCase().contains(query.toLowerCase()));
    }).toList();

    return filteredProducts;
  } // Method to get unique restaurant names from the filtered products

  List<ItemModel> getUniqueRestaurants(List<ItemModel> products) {
    final Set<String> restaurantNames = {};
    final List<ItemModel> uniqueRestaurants = [];

    for (var product in products) {
      if (restaurantNames.add(product.restaurantName)) {
        uniqueRestaurants.add(product);
      }
    }

    return uniqueRestaurants;
  }

  CategoryModel? getCategoryByName(String categoryName) {
    return categoryList
        .firstWhereOrNull((category) => category.name == categoryName);
  }
}
