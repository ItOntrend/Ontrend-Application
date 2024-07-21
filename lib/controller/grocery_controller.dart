import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/repository/grocery_repositry.dart';

class GroceryController extends GetxController {
  var imageUrls = <String>[].obs;
  FirebaseStorage storage = FirebaseStorage.instance;
  RxBool isCategoryLoading = RxBool(false);
  RxList<CategoryModel> categoryList = RxList();
  RxBool isProductLoading = RxBool(false);
  RxList<ItemModel> productList = RxList();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchImages();
    getCategories();
    getProducts();

    print("fetching.....................................................");
  }

  void fetchImages() async {
    ListResult result = await storage.ref('Ontrend/banners').listAll();
    for (var ref in result.items) {
      String url = await ref.getDownloadURL();
      print(url);
      imageUrls.add(url);
    }
  }

  Future<void> getCategories() async {
    isCategoryLoading.value = true;
    categoryList.clear();
    categoryList.value = await GroceryRepository.getCategories();
    print("catlist is ......................$categoryList");
    isCategoryLoading.value = false;
  }

  Future<void> getProducts() async {
    isProductLoading.value = true;
    productList.clear();
    productList.value = await GroceryRepository.getProducts();
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

  CategoryModel? getCategoryByName(String categoryName) {
    return categoryList
        .firstWhereOrNull((category) => category.name == categoryName);
  }

////
//search items
}
