import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';

abstract class FoodRepository {
  static Future<List<ProductModel>> getProducts() async {
    List<ProductModel> products = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collectionGroup('details')
          // Search across all 'details' subcollections
          .get();

      for (var doc in snapshot.docs) {
        // Check if the document path starts with '/Grocery'
        if (doc.reference.path.split('/')[0] == 'Food') {
          print('Document ID: ${doc.id}');
          print('Document Data: ${doc.data()}');
          products
              .add(ProductModel.fromJson(doc.data() as Map<String, dynamic>));
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
