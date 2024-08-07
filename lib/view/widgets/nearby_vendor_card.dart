import 'dart:math' as math;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';

class NearbyRestaurantCard extends StatelessWidget {
  final String locationCityCountry;
  final double distance;
  final String name;
  final List<String> images;
  final double latitude;
  final double longitude;
  final VoidCallback onTap;
  final bool isOnline;

  const NearbyRestaurantCard({
    super.key,
    required this.locationCityCountry,
    required this.distance,
    required this.name,
    required this.images,
    required this.latitude,
    required this.longitude,
    required this.onTap,
    required this.isOnline,
  });

  double _estimateDeliveryTime(double distance) {
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

  @override
  Widget build(BuildContext context) {
    double estimatedTime = _estimateDeliveryTime(distance);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: GestureDetector(
          onTap: isOnline
              ? onTap
              : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "restaurant can't take orders now".tr,
                        style:
                            GoogleFonts.notoSansImperialAramaic(color: kWhite),
                      ),
                      backgroundColor: kDarkOrange,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                },
          child: Card(
              color: kWhite,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1.0,
                            autoPlay: images.length > 1,
                            autoPlayInterval: const Duration(seconds: 2),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 600),
                          ),
                          items: images.map((imageUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                return CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      if (!isOnline)
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Container(
                              color: Colors.black.withOpacity(0.7),
                              child: const Center(
                                child: Text(
                                  "Busy",
                                  style: TextStyle(
                                    color: kWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          FutureBuilder<String>(
                            future: Get.find<VendorController>()
                                .getAddressFromLatLng(latitude, longitude),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
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
                          const SizedBox(height: 4),
                          Text(
                            '${distance.toStringAsFixed(2)} ${"km away".tr}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.alarm_rounded,
                                color: Colors.grey[600],
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${estimatedTime.toStringAsFixed(0)} ${"mins".tr}', // Estimated time in minutes
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
