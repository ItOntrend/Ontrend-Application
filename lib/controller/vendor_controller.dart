import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/model/vendor_model.dart';
import 'package:ontrend_food_and_e_commerce/repository/item_repository.dart';
import 'package:ontrend_food_and_e_commerce/repository/vendor_repository.dart';
import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class VendorController extends GetxController {
  RxBool isVendorLoading = RxBool(false);
  RxBool isItemsLoading = RxBool(false);
  Rx<VendorModel?> vendorDetail = Rx<VendorModel?>(null);
  RxList<VendorModel> vendorsList = RxList<VendorModel>();
  RxList<VendorModel> vendorsListCat = RxList<VendorModel>();
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

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
  try {
    List<geocoding.Placemark> placemarks =
        await geocoding.placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      return "${placemark.locality}, ${placemark.country}";
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
      WidgetsBinding.instance!.addPostFrameCallback((_) {
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
  Future<void> fetchVendors() async {
    try {
      var vendorsQuerySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Vendor')
          .get();

      var vendors = vendorsQuerySnapshot.docs.map((doc) {
        return VendorModel.fromMap(doc.data(), doc.id);
      }).toList();

      vendorsListCat.assignAll(vendors);
    } catch (e) {
      print('Error fetching vendors: $e');
    }
  }

  Future<void> getItems(String userId) async {
    try {
      isItemsLoading.value = true;
      itemsList.clear();
      var items = await ItemRepository.getItems(userId);
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
    print(userId);
    try {
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
}
