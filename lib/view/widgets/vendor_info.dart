import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/vendor_model.dart';
import 'dart:math' as math;

final LanguageController lang = Get.find();

class VendorInfoPage extends StatelessWidget {
  final VendorModel? vendor;
  const VendorInfoPage({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    final VendorController _vendorController = Get.find();
    final distance = _vendorController.calculateDistance(vendor!.location);
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: const Text(""),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section with restaurant image and name
            Row(
              children: [
                _buildImage(),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildName(),
                      _buildRating(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 10),
                      Text(
                        "Restaurant Area".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      const Spacer(),
                      FutureBuilder<String>(
                        future: Get.find<VendorController>()
                            .getAddressFromLatLng(
                                vendor!.location.lat, vendor!.location.lng),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!,
                              style: const TextStyle(color: Colors.grey),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Location information unavailable'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold));
                          } else {
                            return Text('Fetching location...'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold));
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: lang.currentLanguage.value.languageCode == "ar"
                      ? EdgeInsets.only(right: 30)
                      : EdgeInsets.only(left: 30),
                  child: Divider(
                    thickness: 1,
                  ),
                )
              ],
            ),
            _buildInfoRow(Icons.access_time, 'Delivery time'.tr,
                '${_estimateDeliveryTime(distance).toStringAsFixed(2)}  ${"mins".tr}'),
            //_buildInfoRow(Icons.shopping_cart, 'Minimum order', 'OMR 0.800'),
            _buildInfoRow(Icons.money, 'Delivery fee'.tr,
                '${"OMR".tr} ${_vendorController.deliveryFee.value.toStringAsFixed(3)}'),
            //_buildInfoRow(Icons.info_outline, 'Pre-order', 'Yes'),
            _buildPaymentOptions(),
            _buildInfoRow(
                Icons.account_balance, 'Legal name'.tr, vendor!.ownerName),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return CircleAvatar(
      radius: 40,
      backgroundImage: NetworkImage(vendor?.image ?? ''),
      backgroundColor: Colors.grey.shade300,
    );
  }

  Widget _buildName() {
    return Obx(
      () => Text(
        lang.currentLanguage.value.languageCode == "ar"
            ? vendor?.restaurantArabicName ??
                'Restaurant' // Use Arabic name when language is Arabic
            : vendor?.restaurantName ??
                'Restaurant', // Use English name otherwise
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        //Icon(Icons.star, color: Colors.amber),
        Text(vendor?.ownerName ?? 'Owner'),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 10),
              Text(
                label,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              const Spacer(),
              Text(value, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Padding(
          padding: lang.currentLanguage.value.languageCode == "ar"
              ? EdgeInsets.only(right: 30)
              : EdgeInsets.only(left: 30),
          child: Divider(
            thickness: 1,
          ),
        )
      ],
    );
  }

  Widget _buildPaymentOptions() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Icon(Icons.payment),
              SizedBox(width: 10),
              Text(
                "Payment Options".tr,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              Spacer(),
              Wrap(
                children: [
                  Icon(Icons.credit_card_outlined),
                  SizedBox(width: 10),
                  Icon(Icons.credit_card),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: lang.currentLanguage.value.languageCode == "ar"
              ? EdgeInsets.only(right: 30)
              : EdgeInsets.only(left: 30),
          child: Divider(),
        )
      ],
    );
  }

  double _estimateDeliveryTime(double distance) {
    // Assume an average speed of 40 km/h
    const double averageSpeed = 40;
    final double time = (distance / averageSpeed) * 60; // time in minutes
    return time;
  }

  double _degreeToRadian(double degree) {
    return degree * (math.pi / 180);
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers

    final double dLat = _degreeToRadian(end.latitude - start.latitude);
    final double dLon = _degreeToRadian(end.longitude - start.longitude);

    final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreeToRadian(start.latitude)) *
            math.cos(_degreeToRadian(end.latitude)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    final double distance = earthRadius * c;

    return distance;
  }
}
