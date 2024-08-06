import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/utils/constants/firebase_constants.dart';

abstract class CategoryRepository {
  static Future<List<CategoryModel>> getCategories() async {
    final snapshot = await FirebaseConstants.dbInstance
        .collection(FirebaseConstants.food)
        .doc(FirebaseConstants.items)
        .collection(FirebaseConstants.categories)
        .get();

    final categories = snapshot.docs
        .map((doc) => CategoryModel.fromJson(doc.data()))
        .where((category) => category.isApproved)
        .toList();

    return categories;
  }
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

