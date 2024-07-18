import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/model/grocery_category_model.dart';
import 'package:ontrend_food_and_e_commerce/model/grocery_product_model.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/utils/constants/firebase_constants.dart';

abstract class GroceryRepository {
  static Future<List<CategoryModel>> getCategories() async {
    return FirebaseConstants.dbInstance
        .collection(FirebaseConstants.grocery)
        .doc(FirebaseConstants.items)
        .collection(FirebaseConstants.categories)
        .get()
        .then(
          (snapshot) => snapshot.docs
              .map((doc) => CategoryModel.fromJson(doc.data()))
              .toList(),
        );
  }

  static Future<List<ItemModel>> getProducts() async {
    List<ItemModel> products = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collectionGroup('details')
          // Search across all 'details' subcollections
          .get();

      for (var doc in snapshot.docs) {
        // Check if the document path starts with '/Grocery'
        if (doc.reference.path.split('/')[0] == 'Grocery') {
          print('Document ID: ${doc.id}');
          print('Document Data: ${doc.data()}');
          products.add(ItemModel.fromJson(doc.data() as Map<String, dynamic>));
        }
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
    print('Fetched Products: $products');
    return products;
  } //////

  static Future<List<CategoryModel>> searchProducts(
      String query, String type) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(type)
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .get();
      return querySnapshot.docs
          .map((doc) => CategoryModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
