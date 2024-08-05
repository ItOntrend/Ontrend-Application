import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ontrend_food_and_e_commerce/controller/language_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/model/vendor_model.dart';
import 'dart:math' as math;

class VendorInfoPage extends StatelessWidget {
  final VendorModel? vendor;
  const VendorInfoPage({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    final LanguageController lang = Get.find();
    final VendorController _vendorController = Get.find();
    final distance = _vendorController.calculateDistance(vendor!.location);
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Text(""),
      ),
      /* body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 65.h,
                    width: 84.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: vendor!.image, // Use ! for non-null access
                          fit: BoxFit.cover,
                        )),
                  ),
                  kWidth20,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // _vendorController.vendorDetail.value?.restaurantName ??
                        //   "Not found",   // Check the selected language
                        lang.currentLanguage.value.languageCode == 'ar'
                            ? vendor!.restaurantArabicName
                            : vendor!.restaurantName,

                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // You can add more details in similar fashion
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                "Distance : ${distance.toStringAsFixed(3)} Km",
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                "Delivery time: ${_estimateDeliveryTime(distance).toStringAsFixed(1)} mins",
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    "Restaurant Area:  ",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  FutureBuilder<String>(
                    future: Get.find<VendorController>().getAddressFromLatLng(
                        vendor!.location.lat, vendor!.location.lng),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          'Location information unavailable'.tr,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        );
                      } else {
                        return Text(
                          'Fetching location...'.tr,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                "Delivery fee: OMR ${_vendorController.deliveryFee.value.toStringAsFixed(3)}",
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 10.h),
              // Add more vendor details here
            ],
          ),
        ),
      ),*/
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section with restaurant image and name
            Row(
              children: [
                _buildImage(),
                SizedBox(width: 20),
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
            SizedBox(height: 20),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 10),
                      Text(
                        "Restaurant Area",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Spacer(),
                      FutureBuilder<String>(
                        future: Get.find<VendorController>()
                            .getAddressFromLatLng(
                                vendor!.location.lat, vendor!.location.lng),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!,
                              style: TextStyle(color: Colors.grey),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Location information unavailable'.tr,
                                style: TextStyle(fontWeight: FontWeight.bold));
                          } else {
                            return Text('Fetching location...'.tr,
                                style: TextStyle(fontWeight: FontWeight.bold));
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Divider(
                    thickness: 1,
                  ),
                )
              ],
            ),
            _buildInfoRow(Icons.access_time, 'Delivery time',
                '${_estimateDeliveryTime(distance).toStringAsFixed(2)}  mins'),
            //_buildInfoRow(Icons.shopping_cart, 'Minimum order', 'OMR 0.800'),
            _buildInfoRow(Icons.money, 'Delivery fee',
                'OMR ${_vendorController.deliveryFee.value.toStringAsFixed(3)}'),
            _buildInfoRow(Icons.info_outline, 'Pre-order', 'Yes'),
            _buildPaymentOptions(),
            _buildInfoRow(
                Icons.account_balance, 'Legal name', 'Al Amar Food LLC'),
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
    return Text(
      vendor?.restaurantName ?? 'Restaurant',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
              SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              Spacer(),
              Text(value, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
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
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Icon(Icons.payment),
              SizedBox(width: 10),
              Text(
                "Payment Options",
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
          padding: const EdgeInsets.only(left: 30),
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
