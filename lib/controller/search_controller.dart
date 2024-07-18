import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/repository/category_repository.dart';
import 'package:ontrend_food_and_e_commerce/repository/search_repository.dart';

class MySearchController extends GetxController {
  RxBool isCategoryLoading = RxBool(false);
  RxList<CategoryModel> categoryList = RxList();

  Future<void> getCategories(String type) async {
    isCategoryLoading.value = true;
    categoryList.clear();

    categoryList.value = await SearchRepository.getCategories(type);
    print('Fetched Categories: ${categoryList.length}');
    for (var category in categoryList) {
      print(
          'Category: ${category.name}, ${category.localName}, ${category.imageUrl}');
    }
    isCategoryLoading.value = false;
  }

  CategoryModel? getCategoryByName(String categoryName) {
    return categoryList
        .firstWhereOrNull((category) => category.name == categoryName);
  }
}
