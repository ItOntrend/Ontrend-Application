import 'dart:math' as math;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';

class ExploreCard extends StatelessWidget {
  final String locationCityCountry;
  final double distance;
  final String name;
  final List<String> images;
  final double latitude;
  final double longitude;
  final VoidCallback onTap;
  final bool isOnline;

  const ExploreCard({
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
    final double time = (distance / averageSpeed) * 60;
    return time;
  }

  double _degreeToRadian(double degree) {
    return degree * (math.pi / 180);
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371;

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

    return GestureDetector(
      onTap: isOnline
          ? onTap
          : () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("restaurant can't take orders now".tr,
                      style:
                          GoogleFonts.notoSansImperialAramaic(color: kWhite),),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: images.isNotEmpty
                      ? CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1.0,
                            autoPlayInterval: const Duration(seconds: 2),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 600),
                            autoPlay: images.length > 1,
                          ),
                          items: images.map((imageUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                return CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 150,
                                );
                              },
                            );
                          }).toList(),
                        )
                      : Container(
                          width: double.infinity,
                          height: 150,
                          color: Colors.grey[300],
                          child: Center(
                            child: Text(
                              'No image available'.tr,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ),
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
                        child: Center(
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 225.w,
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      FutureBuilder<String>(
                        future: Get.find<VendorController>()
                            .getAddressFromLatLng(latitude, longitude),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              width: 110.w,
                              child: Text(
                                snapshot.data!,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
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
                      Image.asset(
                        "assets/image/small_location_image.png",
                        height: 16,
                        width: 16,
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '${distance.toStringAsFixed(2)} ${"km away".tr}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.alarm_rounded,
                        color: Colors.grey[600],
                        size: 18,
                      ),
                      Text(
                        '${estimatedTime.toStringAsFixed(0)} ${"mins".tr}',
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
          ],
        ),
      ),
    );
  }
}
