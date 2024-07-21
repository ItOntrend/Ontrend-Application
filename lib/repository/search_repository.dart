import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/utils/constants/firebase_constants.dart';

abstract class SearchRepository {
  static Future<List<ItemModel>> getProducts() async {
    List<ItemModel> products = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collectionGroup('details')
          // Search across all 'details' subcollections
          .get();

      for (var doc in snapshot.docs) {
        products.add(ItemModel.fromJson(doc.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
    print('Fetched Products: $products');
    return products;
  } //////
}

  
  // static Stream<List<CategoryModel>> getCategories() {
  //   return FirebaseConstants.dbInstance
  //       .collection(FirebaseConstants.food)
  //       .doc(FirebaseConstants.items)
  //       .collection(FirebaseConstants.categories)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //           .map(
  //             (doc) => CategoryModel.fromJson(doc.data()),
  //           )
  //           .toList());
  // } 

