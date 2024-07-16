import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/model/order_modal.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/delivery_tracking_page.dart';

class MyOrderCard extends StatefulWidget {
  const MyOrderCard({
    super.key,
    required this.restaurantName,
    required this.location,
    required this.status,
    required this.items,
    required this.totalPrice,
    required this.userId, required this.orderId,
  });

  final String restaurantName;
  final LatLng location;
  final String status;
  final List<Item> items;
  final double totalPrice;
  final String userId;
  final String orderId;

  @override
  State<MyOrderCard> createState() => _MyOrderCardState();
}

class _MyOrderCardState extends State<MyOrderCard> {
  String _address = "";
  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      Placemark place = placemarks[0];

      setState(() {
        _address = '${place.locality}';
      });
    } catch (e) {
      setState(() {
        _address = 'Location Not Found';
      });
    }
  }

  @override
  void initState() {
    _getAddressFromLatLng(widget.location.latitude, widget.location.longitude);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DeliveryTrackingPage(
          orderId: widget.orderId,
          latitude: 0.0,
          longitude: 0.0,
        ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 246.h,
        decoration: BoxDecoration(
          color: kWhite,
          border: Border.all(color: kBorderLiteBlack),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: kGrey,
                  radius: 26,
                ),
                kWidth20,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurantName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/image/small_location_image.png",
                          height: 16,
                          width: 16,
                        ),
                        kWidth6,
                        Text(
                          _address,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: kGrey),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  widget.status,
                  style: TextStyle(
                    color: kGreen,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            kHiegth10,
            Container(
              height: 146.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kBorderLiteGrey),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Column(
                      children: widget.items
                          .map((item) => Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 6,
                                  ),
                                  kWidth10,
                                  Text(
                                      '${item.itemName} x${item.itemQuantity} - OMR ${item.total.toStringAsFixed(3)}'),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Total Price"),
                      Container(
                        color: Colors.grey.shade400,
                        width: 1,
                        height: 36,
                      ),
                      Text('OMR ${widget.totalPrice.toStringAsFixed(3)}'),
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
