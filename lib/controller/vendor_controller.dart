import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/cetegory_model.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/model/vendor_model.dart';
import 'package:ontrend_food_and_e_commerce/repository/item_repository.dart';
import 'package:ontrend_food_and_e_commerce/repository/vendor_repository.dart';
import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class VendorController extends GetxController {
  static VendorController get instance => Get.find();
  RxBool isVendorLoading = RxBool(false);
  RxBool isItemsLoading = RxBool(false);
  Rx<VendorModel?> vendorDetail = Rx<VendorModel?>(null);
  RxList<VendorModel> vendorsList = RxList<VendorModel>();
  RxList<VendorModel> vendorsListCat = RxList<VendorModel>();
  RxList<VendorModel> vendorsListf = RxList<VendorModel>();
  RxList<ItemModel> itemsList = RxList<ItemModel>();
  RxString userName = ''.obs;
  Position? userPosition;
  RxString userCity = RxString('Salala');
  // RxString userCountry = RxString('Unknown');

  @override
  void onInit() {
    super.onInit();
    fetchUserLocation();
  }

  Future<void> fetchUserLocation() async {
    try {
      userPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      await getAddressFromLatLng(
          userPosition!.latitude, userPosition!.longitude);
    } catch (e) {
      log('Error fetching user location: $e');
    }
  }

  Future<double> getDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    double distanceInMeters = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    return distanceInMeters / 1000; // convert to kilometers
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return "${placemark.locality}, ${placemark.country}";
      } else {
        log('No placemarks found for the given coordinates.');
      }
    } catch (e) {
      log('Error fetching address: $e');
    }
    return 'Unknown location';
  }

  double calculateDistance(Location vendorLocation) {
    if (userPosition != null) {
      return Geolocator.distanceBetween(
            userPosition!.latitude,
            userPosition!.longitude,
            vendorLocation.lat,
            vendorLocation.lng,
          ) /
          1000; // Convert to km
    }
    return 0.0;
  }

  Future<void> getVendors(String userId) async {
    try {
      isVendorLoading.value = true;
      var vendors = await VendorRepository.getVendors(userId);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        vendorsList.assignAll(vendors);
      });
      log("Vendor data fetched successfully");
    } catch (e) {
      log('Error fetching Vendor data: $e');
    } finally {
      isVendorLoading.value = false;
    }
  }

  // Fetch list of vendors from Firebase
  Future<void> fetchVendors(
    String type,
  ) async {
    try {
      var vendorsQuerySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Vendor')
          .where('vendorType',
              isEqualTo: type) // Add this condition to filter by vendorType
          .get();

      var vendors = vendorsQuerySnapshot.docs.map((doc) {
        return VendorModel.fromMap(doc.data(), doc.id);
      }).toList();

      vendorsListCat.assignAll(vendors);
      log("Vendors data fetched successfully");
    } catch (e) {
      log('Error fetching vendors: $e');
    }
  }

  // Fetch list of vendors from Firebase
  Future<void> fetchVendorsf(
    String type,
  ) async {
    try {
      var vendorsQuerySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Vendor')
          .where('vendorType',
              isEqualTo: type) // Add this condition to filter by vendorType
          .get();

      var vendors = vendorsQuerySnapshot.docs.map((doc) {
        return VendorModel.fromMap(doc.data(), doc.id);
      }).toList();

      vendorsListf.assignAll(vendors);
      log("Vendors data fetched successfully");
    } catch (e) {
      log('Error fetching vendors: $e');
    }
  }

  Future<void> getItems(String userId) async {
    try {
      isItemsLoading.value = true;
      itemsList.clear();
      var items = await ItemRepository.getItems(
        userId,
      );
      itemsList.addAll(items);
      log("Items data fetched successfully");
    } catch (e) {
      log('Error fetching items: $e');
    } finally {
      isItemsLoading.value = false;
    }
  }

  Future<void> getItemsnew(String userId) async {
    try {
      isItemsLoading.value = true;
      itemsList.clear();
      var items = await ItemRepository.getItemsnew(
        userId,
      );
      itemsList.addAll(items);
      log("Items data fetched successfully");
    } catch (e) {
      log('Error fetching items: $e');
    } finally {
      isItemsLoading.value = false;
    }
  }

  Future<void> getItemsGr(String userId, String category, String type) async {
    try {
      isItemsLoading.value = true;
      itemsList.clear();
      var items = await ItemRepository.getItemsGrocery(userId, category, type);
      itemsList.addAll(items);
      log("Items data fetched successfully");
    } catch (e) {
      log('Error fetching items: $e');
    } finally {
      isItemsLoading.value = false;
    }
  }

  Future<VendorModel?> getVendorByUId({required String userId}) async {
    VendorModel? data;
    try {
      data = await VendorRepository.getVendorById(userId: userId);
      if (data != null) {
        log("Vendor fetched successfully: ${data.restaurantName}");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          vendorDetail.value = data;
        });
      } else {
        log("Vendor not found for UID: $userId");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          vendorDetail.value = null;
        });
      }
    } catch (e) {
      log('Error fetching vendor: $e');
    }
    return data;
  }

  Future<VendorModel?> getProfile() async {
    VendorModel? data;

    try {
      final userId =
          await LocalStorage.instance.DataFromPrefs(key: HiveKeys.userData);
      data = await VendorRepository.getVendorById(userId: userId);

      if (data != null) {
        log("Vendor fetched successfully: ${data.restaurantName}");

        vendorDetail.value = data;
      } else {
        log("Vendor not found for UID: $userId");
        vendorDetail.value = null;
      }
    } catch (e) {
      log('Error fetching vendor: $e');
    }
    return null;
  }

////////////////////////////////////////////////////////////////////////////////
  RxList<VendorModel> vCat = RxList<VendorModel>();

  Future<List<String>> getVendorIdOfCategory(String cat, String type) async {
    try {
      QuerySnapshot categorySnapshot = await FirebaseFirestore.instance
          .collection(type)
          .doc("items")
          .collection('categories')
          .doc(cat)
          .collection('details')
          .get();

      // Clear the list before adding new vendor IDs
      List<String> vendorIds = [];

      // Extract the vendor IDs and add them to the vCat list
      for (var doc in categorySnapshot.docs) {
        String vendorId = doc['addedBy'];
        vendorIds.add(vendorId);
        return vendorIds;
      }
    } catch (e) {
      print('Error getting category document: $e');
    }
    return [];
  }

  Future<void> getVendorDetails(List<String> vendorIds) async {
    try {
      vCat.clear();

      for (String vendorId in vendorIds) {
        DocumentSnapshot vendorDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(vendorId)
            .get();

        if (vendorDoc.exists) {
          vCat.add(VendorModel.fromMap(
              vendorDoc.data() as Map<String, dynamic>, vendorDoc.id));
        }
      }
    } catch (e) {
      print('Error getting vendor details: $e');
    }
  }

  RxString cat = "".obs;
  Future<void> fetchVendorsCat(String type, String cat) async {
    try {
      List<String> vendorIds = await getVendorIdOfCategory(cat, type);
      await getVendorDetails(vendorIds);
    } catch (e) {
      print('Error fetching vendors: $e');
    }
  }

//*...............................................................*//
  RxList<ItemModel> CatList = RxList<ItemModel>();
  Future<void> getCatVendor(String userId, String type) async {
    try {
      print('fetching.....................cat');
      CatList.clear();
      var items = await ItemRepository.getCategoriesVendor(userId, type);
      CatList.addAll(items);
      print("type is $type");
      print("catlist is ${CatList}");
      log("Items data fetched successfully");
    } catch (e) {
      log('Error fetching items: $e');
    }
  }

  Future<void> getCatVendorNew(String userId, String type) async {
    try {
      print('fetching.....................cat');
      itemsList.clear();
      var items = await ItemRepository.getCategoriesVendor(userId, type);
      itemsList.addAll(items);
      print("type is $type");
      print("catlist is ${itemsList}");
      log("Items data fetched successfully");
    } catch (e) {
      log('Error fetching items: $e');
    }
  }
////////////////
}
