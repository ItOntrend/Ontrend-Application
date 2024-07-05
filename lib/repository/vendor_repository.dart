import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ontrend_food_and_e_commerce/model/vendor_model.dart';

class VendorRepository {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<List<Vendor>> getVendors(String userId) async {
    var snapshot =
        await _db.collection('users').where('role', isEqualTo: 'Vendor').get();

    log("$snapshot,");
    if (snapshot.docs.isEmpty) {
      log('No vendors found.');
      return [];
    }

    log('Vendors found: ${snapshot.docs.length}');
    return snapshot.docs.map((doc) => Vendor.fromMap(doc.data())).toList();
  }

  static Future<Vendor?> getVendorById({required String userId}) async {
    var doc = await _db.collection('users').doc(userId).get();

    if (doc.exists) {
      return Vendor.fromMap(doc.data()!);
    }

    return null;
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
