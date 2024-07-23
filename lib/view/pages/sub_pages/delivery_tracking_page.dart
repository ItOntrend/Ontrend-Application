import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:ontrend_food_and_e_commerce/model/order_modal.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/navigation_manu.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/my_timeline_tile.dart';

class DeliveryTrackingPage extends StatefulWidget {
  final String orderId;
  const DeliveryTrackingPage(
      {super.key,
      required this.orderId,
      required this.latitude,
      required this.longitude});
  final double latitude;
  final double longitude;

  @override
  _DeliveryTrackingPageState createState() => _DeliveryTrackingPageState();
}

class _DeliveryTrackingPageState extends State<DeliveryTrackingPage> {
  late GoogleMapController mapController;
  final CartController cartController = Get.find<CartController>();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    print("/////////////////////////////////////");
    log(widget.latitude.toString());
    log(widget.longitude.toString());
    print("////////////////////////////////////");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
                onPressed: () {
                  Get.offAll(const NavigationManu());
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                child: Image.asset("assets/lottie_animation/pending.gif"),
              ),
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground
              ],
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: Container(
                  height: 32.h,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Container(
                    width: 40.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: kLiteBackground,
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                    ),
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('orders')
                      .doc(widget.orderId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error fetching order status'));
                    }

                    // Debug logging
                    print("Order Data: ${snapshot.data!.data()}");

                    // Ensure data is not null and handle missing fields
                    final data = snapshot.data!.data() as Map<String, dynamic>?;
                    if (data == null) {
                      return Center(child: Text('Order data is null'.tr));
                    }

                    try {
                      OrderModel order = OrderModel.fromJson(data);
                      return Column(
                        children: [
                          _buildDeliveryDetails(order),
                          kHiegth24,
                          _buildOrderTimeline(order.status),
                          _buildOrderDetails(order),
                        ],
                      );
                    } catch (e) {
                      // Log the error for debugging purposes
                      print("Error parsing order data: $e");
                      return Center(child: Text('Error parsing order data'.tr));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryDetails(OrderModel order) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: kBorderLiteBlack),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: kWhite,
      ),
      height: 128.h,
      child: Row(
        children: [
          Image.asset(
            "assets/image/delivery_boy_image.png",
            height: 74.h,
            width: 92.w,
          ),
          kWidth15,
          if (order.deliveryAccepted) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  order.deliveryAcceptedBy.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "is your delivery hero for\ntoday.".tr,
                  style: TextStyle(
                    fontSize: 10,
                    color: kTextStyleGrey,
                  ),
                ),
              ],
            ),
          ] else ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Waiting for acceptance".tr,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Your delivery hero details will\nappear here once accepted."
                      .tr,
                  style: TextStyle(
                    fontSize: 10,
                    color: kTextStyleGrey,
                  ),
                ),
              ],
            ),
          ],
          const Spacer(),
          if (order.deliveryAccepted) ...[
            Container(
              height: 36.h,
              width: 36.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kWhite,
              ),
              child: IconButton(
                icon: const Icon(Icons.phone, color: Colors.white),
                onPressed: () {
                  // Add functionality to call the delivery person
                },
              ),
            ),
            kWidth16,
            Container(
              height: 36.h,
              width: 36.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kWhite,
              ),
              child: IconButton(
                icon: const Icon(Icons.message, color: Colors.white),
                onPressed: () {
                  // Add functionality to call the delivery person
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderTimeline(String status) {
    bool isPast(String step) {
      List<String> steps = [
        "Pending".tr,
        "Processing".tr,
        "Ready".tr,
        "Picked Up".tr,
        "Delivered".tr
      ];
      int currentIndex = steps.indexOf(status);
      int stepIndex = steps.indexOf(step);
      return stepIndex <= currentIndex;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTimelineTile(
          isFirst: true,
          isLast: false,
          isPast: isPast("Pending".tr),
          child: const Text(
            "Pending",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        MyTimelineTile(
          isFirst: false,
          isLast: false,
          isPast: isPast("Processing"),
          child: Text(
            "Processing".tr,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        MyTimelineTile(
          isFirst: false,
          isLast: false,
          isPast: isPast("Ready"),
          child: Text(
            "Ready".tr,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        MyTimelineTile(
          isFirst: false,
          isLast: false,
          isPast: isPast("Picked Up"),
          child: Text(
            "Picked Up".tr,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        MyTimelineTile(
          isFirst: false,
          isLast: true,
          isPast: isPast("Delivered"),
          child: Text(
            "Delivered".tr,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetails(OrderModel order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Details".tr,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Divider(),
          _buildOrderDetailRowTwo("Order ID".tr, "#${order.orderID}"),
          _buildOrderDetailRowTwo(
            "Order Total".tr,
            "${"OMR".tr} ${order.totalPrice.toStringAsFixed(3)}",
          ),
          _buildOrderDetailRowTwo("Payment Method".tr, "Cash".tr),
          const Divider(),
          Text(
            "Order Menu".tr,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          ...order.items
              .map((item) => ListTile(
                    title: Text(item.itemName),
                    subtitle:
                        Text("${item.itemQuantity} x OMR ${item.itemPrice}00"),
                    trailing: Text("${"OMR".tr} ${item.total}00"),
                  ))
              .toList(),
          const Divider(),
          _buildOrderDetailRow(order),
        ],
      ),
    );
  }

  Widget _buildOrderDetailRow(OrderModel order) {
    final vendorLocation =
        LatLng(order.restaurantLocation.lat, order.restaurantLocation.lng);
    final userLocation = LatLng(widget.latitude, widget.longitude);
    final distance = _calculateDistance(vendorLocation, userLocation);
    final deliveryTime = _estimateDeliveryTime(distance);

    String formattedDeliveryTime;
    if (deliveryTime >= 60) {
      final hours = (deliveryTime / 60).floor();
      final minutes = (deliveryTime % 60).floor();
      formattedDeliveryTime =
          "$hours hour${hours > 1 ? 's' : ''} ${minutes > 0 ? '$minutes minute${minutes > 1 ? 's' : ''}' : ''}";
    } else {
      formattedDeliveryTime = "${deliveryTime.toStringAsFixed(0)} mins";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${"Distance:".tr} ${distance.toStringAsFixed(2)} ${"km".tr}"),
        Text("${"Estimated Delivery Time:".tr} $formattedDeliveryTime"),
      ],
    );
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

  double _degreeToRadian(double degree) {
    return degree * (math.pi / 180);
  }

  double _estimateDeliveryTime(double distance) {
    // Assume an average speed of 40 km/h
    const double averageSpeed = 40;
    final double time = (distance / averageSpeed) * 60; // time in minutes
    return time;
  }

  Widget _buildOrderDetailRowTwo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
