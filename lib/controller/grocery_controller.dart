import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/grocery_category_model.dart';
import 'package:ontrend_food_and_e_commerce/model/grocery_product_model.dart';
import 'package:ontrend_food_and_e_commerce/model/store_model.dart';
import 'package:ontrend_food_and_e_commerce/repository/grocery_repositry.dart';

class GroceryController extends GetxController {
  var imageUrls = <String>[].obs;
  FirebaseStorage storage = FirebaseStorage.instance;
  RxBool isCategoryLoading = RxBool(false);
  RxList<grCategoryModel> categoryList = RxList();
  RxBool isProductLoading = RxBool(false);
  RxList<ProductModel> productList = RxList();
  var storeList = <Store>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchImages();
    getCategories();
    getProducts();
    fetchStores();

    print("fetching.....................................................");
  }

  void fetchImages() async {
    ListResult result =
        await storage.ref('dbDs1m9ORGMzcbvhWmaPAI6Sl5i2/banners').listAll();
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

  void fetchStores() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Grocery')
          .doc('Store')
          .collection('Stores')
          .get();
      storeList.value = querySnapshot.docs
          .map((doc) => Store.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      print("Error fetching stores: $e");
    }
  } // Fetch list of vendors from Firebase
}
