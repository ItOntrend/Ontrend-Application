import 'dart:developer';

import 'package:ontrend_food_and_e_commerce/model/best_seller_model.dart';
import 'package:ontrend_food_and_e_commerce/utils/constants/firebase_constants.dart';

abstract class BestSellerRepository {
  static Future<List<BestSellerModel>> getBestSeller() async {
    return FirebaseConstants.dbInstance
        .collection(FirebaseConstants.food)
        .doc(FirebaseConstants.items)
        .collection(FirebaseConstants.categories)
        .doc(FirebaseConstants.bestSeller)
        .collection(FirebaseConstants.details)
        .get()
        .then((snapshot) {
          print("Snap Shot for BestSeller");
      log(snapshot.toString());
      return snapshot.docs
          .map((doc) {
            var value = doc.data();
            print(value);
            return BestSellerModel.fromJson(doc.data());
          }).toList();
    });
  }
}


// static Stream<List<BestSellerModel>> getCategories() {
  //   return FirebaseConstants.dbInstance
  //       .collection(FirebaseConstants.food)
  //       .doc(FirebaseConstants.items)
  //       .collection(FirebaseConstants.categories)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //           .map(
  //             (doc) => BestSellerModel.fromJson(doc.data()),
  //           )
  //           .toList());
  // }