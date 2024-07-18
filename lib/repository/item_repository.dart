import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/utils/constants/firebase_constants.dart';

class ItemRepository {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<List<ItemModel>> getItems(String userId) async {
    try {
      var snapshot = await _db
          .collection(FirebaseConstants.food)
          .doc(FirebaseConstants.items)
          .collection(FirebaseConstants.categories)
          .doc()
          .collection(FirebaseConstants.details)
          .where("addedBy", isEqualTo: userId)
          .get();

      if (snapshot.docs.isEmpty) {
        log('No items found');
      } else {
        log('Items retrieved: ${snapshot.docs.length}');
      }

      return snapshot.docs
          .map((doc) => ItemModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log('Error fetching items: $e');
      return [];
    }
  }

  static Future<List<ItemModel>> getItemsnew(String userId) async {
    try {
      var snapshot = await _db
          .collection("Grocery")
          .doc(FirebaseConstants.items)
          .collection(FirebaseConstants.categories)
          .doc()
          .collection(FirebaseConstants.details)
          .where("addedBy", isEqualTo: userId)
          .get();

      if (snapshot.docs.isEmpty) {
        log('No items found');
      } else {
        log('Items retrieved: ${snapshot.docs.length}');
      }

      return snapshot.docs
          .map((doc) => ItemModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log('Error fetching items: $e');
      return [];
    }
  }

  static Future<List<ItemModel>> getItemsGrocery(
      String userId, String category, String type) async {
    try {
      var snapshot = await _db
          .collection(type)
          .doc(FirebaseConstants.items)
          .collection("categories")
          .doc(category)
          .collection(FirebaseConstants.details)
          .where("addedBy", isEqualTo: userId)
          .get();

      if (snapshot.docs.isEmpty) {
        log('No items found');
      } else {
        log('Items retrieved: ${snapshot.docs.length}');
      }

      return snapshot.docs
          .map((doc) => ItemModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log('Error fetching items: $e');
      return [];
    }
  }

  static Future<List<ItemModel>> getCategoriesVendor(
      String userId, String type) async {
    try {
      QuerySnapshot snapshot = await FirebaseConstants.dbInstance
          .collectionGroup("details")
          .where('addedBy', isEqualTo: userId) // Apply the filter here
          .get();

      return snapshot.docs
          .map((doc) => ItemModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('Error fetching vendor categories: $e');
      return [];
    }
  }
}
