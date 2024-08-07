import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ontrend_food_and_e_commerce/model/vendor_model.dart';

class VendorRepository {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<List<VendorModel>> getVendors(String userId) async {
    var snapshot =
        await _db.collection('users').where('role', isEqualTo: 'Vendor').get();

    log("$snapshot,");
    if (snapshot.docs.isEmpty) {
      log('No vendors found.');
      return [];
    }

    log('Vendors found: ${snapshot.docs.length}');
    return snapshot.docs
        .map((doc) => VendorModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  static Future<VendorModel?> getVendorById({required String userId}) async {
    try {
      log(userId);
      log("++++++");
      var doc = await _db.collection('users').doc(userId).get();

      if (doc.exists) {
        log('Vendor data: ${doc.data()}');
        return VendorModel.fromJson(doc.data()!, doc.id);
      } else {
        log('Vendor with userId $userId does not exist.');
      }

      return null;
    } catch (e) {
      log('Error fetching vendor by ID: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getVendorNameByid(String uid) async {
    try {
      var doc = await _db.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.data(); // Return the entire document data
      }
      return null;
    } catch (e) {
      log('Error fetching user name: $e');
      return null;
    }
  }
}
