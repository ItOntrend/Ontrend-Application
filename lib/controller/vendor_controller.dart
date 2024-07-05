import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
import 'package:ontrend_food_and_e_commerce/model/vendor_model.dart';
import 'package:ontrend_food_and_e_commerce/repository/item_repository.dart';
import 'package:ontrend_food_and_e_commerce/repository/vendor_repository.dart';

class VendorController extends GetxController {
  RxBool isVendorLoading = RxBool(false);
  RxBool isItemsLoading = RxBool(false);
  Rx<Vendor?> vendorDetail = Rx<Vendor?>(null);
  RxList<Vendor> vendorsList = RxList<Vendor>();
  RxList<ItemModel> itemsList = RxList<ItemModel>();
  RxString userName = ''.obs;

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

  Future<Vendor?> getVendorByUId({required String userId}) async {
    Vendor? data;
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
}
