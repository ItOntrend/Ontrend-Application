import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  //
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
            _updateConnectionStatus as void Function(
                List<ConnectivityResult> event)?)
        as StreamSubscription<ConnectivityResult>;
  }

  //
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      warningSnackBar(title: "No Internet Connection");
    }
  }

  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  // 

  @override
  void onClose(){
    super.onClose();
    _connectivitySubscription.cancel();
  }

  static warningSnackBar({required title, massage = ''}) {
    Get.snackbar(title, massage,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: kWhite,
        backgroundColor: kOrange,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(20),
        icon: Icon(Icons.warning));
  }
}
