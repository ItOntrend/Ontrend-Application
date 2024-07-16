import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ontrend_food_and_e_commerce/controller/cart_controller.dart';
import 'package:ontrend_food_and_e_commerce/controller/vendor_controller.dart';
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
  final double latitude; // Change to double
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
                      return const Center(child: Text('Order data is null'));
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
                      return const Center(
                          child: Text('Error parsing order data'));
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
                const Text(
                  "is your delivery hero for\ntoday.",
                  style: TextStyle(
                    fontSize: 10,
                    color: kTextStyleGrey,
                  ),
                ),
              ],
            ),
          ] else ...[
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Waiting for acceptance",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Your delivery hero details will\nappear here once accepted.",
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
        "On Delivery",
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
          child: const Text("Pending"),
        ),
        MyTimelineTile(
          isFirst: false,
          isLast: false,
          isPast: isPast("Processing"),
          child: const Text("Processing"),
        ),
        MyTimelineTile(
          isFirst: false,
          isLast: false,
          isPast: isPast("On Delivery"),
          child: const Text("On Delivery"),
        ),
        MyTimelineTile(
          isFirst: false,
          isLast: true,
          isPast: isPast("Delivered"),
          child: const Text("Delivered"),
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
          _buildOrderDetailRowTwo("Order Total", "OMR ${order.totalPrice}"),
          _buildOrderDetailRowTwo("Payment Method", "Cash"),
          const Divider(),
          const Text(
            "Order Menu",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          ...order.items
              .map((item) => ListTile(
                    title: Text(item.itemName),
                    subtitle:
                        Text("${item.itemQuantity} x OMR ${item.itemPrice}"),
                    trailing: Text("OMR ${item.total}"),
                  ))
              .toList(),
          const Divider(),
          _buildOrderDetailRow(),
        ],
      ),
    );
  }

  Widget _buildOrderDetailRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Distance:", style: TextStyle(fontSize: 16.0)),
              FutureBuilder<String>(
                future: Get.find<VendorController>()
                    .getAddressFromLatLng(widget.latitude, widget.longitude),
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
                      'Location information unavailable',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    );
                  } else {
                    return Text(
                      'Fetching location...',
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
          kHiegth30,
        ],
      ),
    );
  }

  Widget _buildOrderDetailRowTwo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16.0)),
          Text(value, style: TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}
