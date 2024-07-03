import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/best_seller_model.dart';
import 'package:ontrend_food_and_e_commerce/repository/best_seller_repository.dart';

class BestSellerController extends GetxController {
  RxBool isBestSellerLoading = RxBool(false);
  RxList<BestSellerModel> bestSellerList = RxList<BestSellerModel>();

  @override
  void onInit() {
    super.onInit();
    getBestSeller();
  }

  Future<void> getBestSeller() async {
    print("testing for now");
    try {
      isBestSellerLoading.value = true;
      bestSellerList.clear();
      final bestSellers = await BestSellerRepository.getBestSeller();
      bestSellerList.addAll(bestSellers);
    } catch (e) {
      debugPrint('Error fetching best sellers: $e');
    } finally {
      isBestSellerLoading.value = false;
    }
  }
}
