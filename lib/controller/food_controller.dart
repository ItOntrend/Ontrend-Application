import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/repository/category_repository.dart';
import 'package:ontrend_food_and_e_commerce/repository/food_repository.dart';

class FoodController extends GetxController {
  LanguageController lang = Get.put(LanguageController());
  RxBool isCategoryLoading = RxBool(false);
  RxList<CategoryModel> categoryList = RxList();
  RxBool isProductLoading = RxBool(false);
  RxList<ProductModel> productList = RxList();
  @override
  void onInit() {
    super.onInit();
    getCategories();
    print("fetching.....................................................");
  }

  Future<void> getCategories() async {
    try {
      isCategoryLoading.value = true;
      categoryList.clear();
      categoryList.value = await CategoryRepository.getCategories();
      print('Fetched Categories: ${categoryList.length}');
      for (var category in categoryList) {
        print(
            'Category: ${category.name}, ${category.localName}, ${category.imageUrl}');
      }
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isCategoryLoading.value = false;
    }
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

  CategoryModel? getCategoryByName(String categoryName) {
    return categoryList
        .firstWhereOrNull((category) => category.name == categoryName);
  }
}
