import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/model/grocery_category_model.dart';
import 'package:ontrend_food_and_e_commerce/model/grocery_product_model.dart';
import 'package:ontrend_food_and_e_commerce/utils/constants/firebase_constants.dart';

abstract class GroceryRepository {
  static Future<List<GroceryCategoryModel>> getCategories() async {
    return FirebaseConstants.dbInstance
        .collection(FirebaseConstants.grocery)
        .doc(FirebaseConstants.items)
        .collection(FirebaseConstants.categories)
        .get()
        .then(
          (snapshot) => snapshot.docs
              .map((doc) => GroceryCategoryModel.fromJson(doc.data()))
              .toList(),
        );
  }

  static Future<List<ProductModel>> getProducts() async {
    List<ProductModel> products = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Grocery/items/categories/Fresh Fruits/details')
          .get();
      for (var doc in snapshot.docs) {
        print(doc.data()); // Print raw data for debugging
        products.add(ProductModel.fromJson(doc.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
    return products;
  }
}
