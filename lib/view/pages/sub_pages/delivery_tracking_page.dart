import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
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
  LatLng destination = const LatLng(17.0194, 54.1108);
  LatLng deliveryBoyLocation = const LatLng(17.0194, 54.1108);
  LatLng restaurantLocation = const LatLng(17.0194, 54.1108);
  late GoogleMapController mapController;
  final CartController cartController = Get.find<CartController>();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor restaurantIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  double remainingDistance = 0.0;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderTrackingColloction;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void addCustomMarker() {
    ImageConfiguration configuration =
        const ImageConfiguration(size: Size(0, 0), devicePixelRatio: 5);

    BitmapDescriptor.asset(
            configuration, "assets/icons/delivery_boy_location_icon.png")
        .then((value) {
      setState(() {
        markerIcon = value;
      });
    });
  }

  void addRestaurantMarker() {
    ImageConfiguration configuration =
        const ImageConfiguration(size: Size(0, 0), devicePixelRatio: 5);

    BitmapDescriptor.asset(configuration, "assets/icons/restaurant_icon.png")
        .then((value) {
      setState(() {
        restaurantIcon = value;
      });
    });
  }

  void addCurrentMarker() {
    ImageConfiguration configuration =
        const ImageConfiguration(size: Size(0, 0), devicePixelRatio: 5);

    BitmapDescriptor.asset(configuration, "assets/icons/user_location_icon.png")
        .then((value) {
      setState(() {
        currentLocationIcon = value;
      });
    });
  }

  void updateCurrentLocation(Position position) {
    setState(() {
      destination = LatLng(position.latitude, position.longitude);
    });
  }

  void updateDeliveryBoyLocation(Position position) {
    setState(() {
      deliveryBoyLocation = LatLng(position.latitude, position.longitude);
    });

    mapController.animateCamera(CameraUpdate.newLatLng(deliveryBoyLocation));

    calculateRemainingDistance();
  }

  void calculateRemainingDistance() {
    double distance = Geolocator.distanceBetween(
      deliveryBoyLocation.latitude,
      deliveryBoyLocation.longitude,
      destination.latitude,
      destination.longitude,
    );

    double distanceInKm = distance / 1000;

    setState(() {
      remainingDistance = distanceInKm;
    });
  }

  @override
  void initState() {
    super.initState();
    orderTrackingColloction = firestore.collection('orderTracking');
    addCustomMarker();
    addRestaurantMarker();
    addCurrentMarker();
    startTracking(widget.orderId);
    Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.best, distanceFilter: 10))
        .listen((Position position) {
      updateCurrentLocation(position);
    });
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
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: StreamBuilder<DocumentSnapshot>(
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

                // Ensure data is not null and handle missing fields
                final data = snapshot.data!.data() as Map<String, dynamic>?;
                if (data == null) {
                  return const Center(child: Text('Order data is null'));
                }

                // Parse order data
                OrderModel order = OrderModel.fromJson(data);

                return FlexibleSpaceBar(
                  background: order.status == 'Picked Up'
                      ? GoogleMap(
                          mapType: MapType.normal,
                          onMapCreated: (controller) {
                            mapController = controller;
                          },
                          initialCameraPosition: CameraPosition(
                            target: deliveryBoyLocation,
                            zoom: 14,
                          ),
                          markers: {
                            Marker(
                              markerId: const MarkerId("Destination"),
                              position: destination,
                              icon: currentLocationIcon,
                              infoWindow: InfoWindow(
                                title: 'Destination',
                                snippet:
                                    'Lat: ${order.deliveryLocation.lat}, Lng: ${order.deliveryLocation.lng}',
                              ),
                            ),
                            Marker(
                              markerId: const MarkerId("DeliveryBoy"),
                              position: deliveryBoyLocation,
                              icon: markerIcon,
                              infoWindow: const InfoWindow(
                                title: 'Delivery Boy',
                                snippet: 'Lat: , Lng: ',
                              ),
                            ),
                            Marker(
                              markerId: const MarkerId("Restaurant"),
                              position: LatLng(order.restaurantLocation.lat,
                                  order.restaurantLocation.lng),
                              icon: markerIcon,
                              infoWindow: InfoWindow(
                                title: 'Restaurant',
                                snippet:
                                    'Lat: ${order.restaurantLocation.lat}, Lng: ${order.restaurantLocation.lng}',
                              ),
                            ),
                          },
                        )
                      : SizedBox(
                          child: Image.asset(
                              "assets/lottie_animation/pending.gif"),
                        ),
                  stretchModes: const [
                    StretchMode.blurBackground,
                    StretchMode.zoomBackground
                  ],
                );
              },
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
              ),
            ),
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

  void startTracking(String orderId) {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      var trackingData = await getOrderTracking(orderId);

      if (trackingData != null) {
        double latitude = trackingData['deliveryPartnerLat'];
        double longitude = trackingData['deliveryPartnerLong'];
        updateUIWithLocation(latitude, longitude);
        log('Latest location: $latitude, $longitude');
      } else {
        log('No tracking data available for order ID: $orderId');
      }
    });
  }

  Future<Map<String, dynamic>?> getOrderTracking(String orderId) async {
    try {
      var snapshot = await orderTrackingColloction.doc(orderId).get();

      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      log("Error retriving order tracking information: $e");
      return null;
    }
  }

  void updateUIWithLocation(double latitude, double longitude) {
    setState(() {
      deliveryBoyLocation = LatLng(latitude, longitude);
    });

    mapController.animateCamera(CameraUpdate.newLatLng(deliveryBoyLocation));

    calculateRemainingDistance();
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
        "Pending",
        "Processing",
        "Ready",
        "Picked Up",
        "Delivered"
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
          isPast: isPast("Pending"),
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
          child: const Text(
            "Processing",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        MyTimelineTile(
          isFirst: false,
          isLast: false,
          isPast: isPast("Ready"),
          child: const Text(
            "Ready",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        MyTimelineTile(
          isFirst: false,
          isLast: false,
          isPast: isPast("Picked Up"),
          child: const Text(
            "Picked Up",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        MyTimelineTile(
          isFirst: false,
          isLast: true,
          isPast: isPast("Delivered"),
          child: const Text(
            "Delivered",
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
          const Text(
            "Order Details",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Divider(),
          _buildOrderDetailRowTwo("Order ID", "#${order.orderID}"),
          _buildOrderDetailRowTwo(
            "Order Total",
            "OMR ${order.totalPrice.toStringAsFixed(3)}",
          ),
          _buildOrderDetailRowTwo("Payment Method", "Cash"),
          const Divider(),
          const Text(
            "Order Menu",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          ...order.items
              .map((item) => Column(
                    children: [
                      ListTile(
                        title: Text(item.itemName),
                        subtitle: Text(
                            "${item.itemQuantity} x OMR ${item.itemPrice}00"),
                        trailing: Text("OMR ${item.total}00"),
                      ),
                    ],
                  ))
              .toList(),
          ListTile(
            title: const Text("Delivery fee"),
            trailing: Text("OMR ${order.deliveryFee}00"),
          ),
          ListTile(
            title: const Text("Service fee"),
            trailing: Text("OMR ${order.servicFee}00"),
          ),
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
        Text("Distance: ${distance.toStringAsFixed(2)} km"),
        Text("Estimated Delivery Time: $formattedDeliveryTime"),
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
