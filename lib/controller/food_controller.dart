import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/repository/category_repository.dart';

class FoodController extends GetxController {
  RxBool isCategoryLoading = RxBool(false);
  RxList<CategoryModel> categoryList = RxList();
  Future<void> getCategories() async {
    isCategoryLoading.value = true;
    categoryList.clear();
    categoryList.value = await CategoryRepository.getCategories();
    isCategoryLoading.value = false;
  }
}
