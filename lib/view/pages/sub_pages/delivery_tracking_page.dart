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
import 'package:ontrend_food_and_e_commerce/view/pages/widgets/my_timeline_tile.dart';

class DeliveryTrackingPage extends StatefulWidget {
  final String orderId;
  const DeliveryTrackingPage({super.key, required this.orderId});

  @override
  _DeliveryTrackingPageState createState() => _DeliveryTrackingPageState();
}

class _DeliveryTrackingPageState extends State<DeliveryTrackingPage> {
  late GoogleMapController mapController;
  final CartController cartController = Get.find<CartController>();

  final LatLng _center = const LatLng(45.521563, -122.677433);

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
                  Get.offAll(NavigationManu());
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('destination'),
                    position: _center,
                  ),
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId('route'),
                    points: [_center, const LatLng(45.531563, -122.677433)],
                    color: Colors.green,
                    width: 5,
                  ),
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: kBorderLiteBlack),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Mohammed",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "is your delivery hero for\ntoday.",
                            style: TextStyle(
                              fontSize: 10,
                              color: kTextStyleGrey,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 36.h,
                        width: 36.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhite,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.phone, color: Colors.white),
                          onPressed: () {
                            // Add functionality to call the delivery person
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('orders')
                      .doc(widget.orderId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error fetching order status'));
                    }
                    OrderModel order = OrderModel.fromJson(
                        snapshot.data!.data() as Map<String, dynamic>);
                    return order.deliveryAccepted
                        ? _buildAcceptedOrderDetails(order)
                        : _buildPendingOrderDetails();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingOrderDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Your order has been placed!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Waiting for the restaurant to accept your order...',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          // Placeholder for delivery person
          Container(
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
                Column(
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
                const Spacer(),
                Container(
                  height: 36.h,
                  width: 36.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAcceptedOrderDetails(OrderModel order) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Your order has been accepted!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      order.deliveryAcceptedBy.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "is your delivery hero for\ntoday.",
                      style: TextStyle(
                        fontSize: 10,
                        color: kTextStyleGrey,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  height: 36.h,
                  width: 36.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kWhite,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.phone, color: Colors.white),
                    onPressed: () {
                      // Add functionality to call the delivery person
                    },
                  ),
                ),
              ],
            ),
          ),
          // Display ordered items
          ...order.items
              .map((item) => ListTile(
                    title: Text(item.itemName),
                    subtitle: Text('Quantity: ${item.itemQuantity}'),
                    trailing: Text('\$${item.total.toStringAsFixed(2)}'),
                  ))
              .toList(),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
// import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
// import 'package:ontrend_food_and_e_commerce/view/pages/navigation_manu.dart';
// import 'package:ontrend_food_and_e_commerce/view/pages/widgets/my_timeline_tile.dart';

// class DeliveryTrackingPage extends StatefulWidget {
//   const DeliveryTrackingPage({super.key});

//   @override
//   _DeliveryTrackingPageState createState() => _DeliveryTrackingPageState();
// }

// class _DeliveryTrackingPageState extends State<DeliveryTrackingPage> {
//   late GoogleMapController mapController;

//   final LatLng _center = const LatLng(45.521563, -122.677433);

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         slivers: <Widget>[
//           SliverAppBar(
//             leading: IconButton(
//                 onPressed: () {
//                   Get.offAll(NavigationManu());
//                 },
//                 icon: const Icon(Icons.arrow_back_ios_new)),
//             pinned: true,
//             expandedHeight: 300,
//             flexibleSpace: FlexibleSpaceBar(
//               background: GoogleMap(
//                 onMapCreated: _onMapCreated,
//                 initialCameraPosition: CameraPosition(
//                   target: _center,
//                   zoom: 11.0,
//                 ),
//                 markers: {
//                   Marker(
//                     markerId: const MarkerId('destination'),
//                     position: _center,
//                   ),
//                 },
//                 polylines: {
//                   Polyline(
//                     polylineId: const PolylineId('route'),
//                     points: [_center, const LatLng(45.531563, -122.677433)],
//                     color: Colors.green,
//                     width: 5,
//                   ),
//                 },
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: kBorderLiteBlack),
//                     borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(40),
//                         topRight: Radius.circular(40)),
//                     color: kWhite,
//                   ),
//                   height: 128.h,
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         "assets/image/delivery_boy_image.png",
//                         height: 74.h,
//                         width: 92.w,
//                       ),
//                       kWidth15,
//                       const Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Mohammed",
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           Text(
//                             "is your delivery hero for\ntoday.",
//                             style: TextStyle(
//                               fontSize: 10,
//                               color: kTextStyleGrey,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Spacer(),
//                       Container(
//                         height: 36.h,
//                         width: 36.w,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: kGrey,
//                           ),
//                         ),
//                         child: Image.asset(
//                           "assets/icons/message_icon_image.png",
//                           height: 21.h,
//                           width: 21.w,
//                         ),
//                       ),
//                       kWidth20,
//                       Container(
//                         height: 36.h,
//                         width: 36.w,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: kGrey,
//                           ),
//                         ),
//                         child: Image.asset(
//                           "assets/icons/call_icon_image.png",
//                           height: 19.h,
//                           width: 19.w,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20)
//                       .copyWith(top: 20),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           GestureDetector(
//                             onTap: () => showOrderDetails(context),
//                             child: Container(
//                               height: 21,
//                               width: 117,
//                               decoration: BoxDecoration(
//                                   color: kWhite,
//                                   border: Border.all(color: kDarkOrange),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: const Center(
//                                 child: Text(
//                                   "Order Details",
//                                   style: TextStyle(
//                                       decoration: TextDecoration.underline,
//                                       decorationColor: kDarkOrange,
//                                       color: kDarkOrange,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Row(
//                         children: [Spacer(), Text("Order ID: ########")],
//                       ),
//                       kHiegth24,
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Center(
//                               child: Text(
//                             'Preparing\nyour order',
//                             style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w300,
//                             ),
//                           )),
//                           Center(
//                               child: Text(
//                             'Picked up',
//                             style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w300,
//                             ),
//                           )),
//                           Center(
//                               child: Text(
//                             'On delivery',
//                             style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w300,
//                             ),
//                           )),
//                           Center(
//                               child: Text(
//                             'Delivered',
//                             style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w300,
//                             ),
//                           )),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       const Row(
//                         // crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           MyTimelineTile(
//                             isFirst: true,
//                             isLast: false,
//                             isPast: true,
//                             child: SizedBox(),
//                           ),
//                           MyTimelineTile(
//                             isFirst: false,
//                             isLast: false,
//                             isPast: true,
//                             child: SizedBox(),
//                           ),
//                           MyTimelineTile(
//                             isFirst: false,
//                             isLast: false,
//                             isPast: false,
//                             child: SizedBox(),
//                           ),
//                           MyTimelineTile(
//                             isFirst: false,
//                             isLast: true,
//                             isPast: false,
//                             child: SizedBox(),
//                           ),
//                         ],
//                       ),
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Address:"),
//                           Text(
//                             "Near topaz, 00 street , Salalah Wosta",
//                             style: kTextStyle14Grey,
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void showOrderDetails(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => OrderDetailsCard(),
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//     );
//   }
// }

// class OrderDetailsCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(20),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: kBorderLiteBlack),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: IconButton(
//               icon: const Icon(
//                 Icons.close,
//                 size: 30,
//               ),
//               onPressed: () => Get.back(),
//             ),
//           ),
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Delivery time", style: kTextStyle14Grey),
//               Text("20 min"),
//             ],
//           ),
//           kHiegth10,
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Distance", style: kTextStyle14Grey),
//               Text("2.5 km"),
//             ],
//           ),
//           kHiegth10,
//           const Text(
//             "Order menu",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           kHiegth10,
//           Row(
//             children: [
//               Container(
//                 height: 61.h,
//                 width: 82.w,
//                 decoration: BoxDecoration(
//                     color: kGreen, borderRadius: BorderRadius.circular(10)),
//               ),
//               kWidth10,
//               const Text("1 x Mango Juice"),
//               const Spacer(),
//               const Text("OMR 1.60"),
//             ],
//           ),
//           kHiegth10,
//           const Divider(),
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Order total",
//                 style: kTextStyle14Grey,
//               ),
//               Text(
//                 "OMR 9.67",
//                 style: TextStyle(fontSize: 14),
//               ),
//             ],
//           ),
//           kHiegth15,
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Payment method",
//                 style: kTextStyle14Grey,
//               ),
//               Text(
//                 "Cash",
//                 style: TextStyle(fontSize: 14),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
// import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
// import 'package:ontrend_food_and_e_commerce/view/pages/navigation_manu.dart';
// import 'package:ontrend_food_and_e_commerce/view/pages/widgets/delivery_boy_card.dart';
// import 'package:ontrend_food_and_e_commerce/view/pages/widgets/my_timeline_tile.dart';

// class AfterOrderPage extends StatelessWidget {
//   const AfterOrderPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Get.offAll(const NavigationManu()),
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//       ),
//       backgroundColor: kWhite,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: ListView(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.vertical,
//                   children: [
//                     MyTimelineTile(
//                       isFirst: false,
//                       isLast: false,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.asset(
//                               "assets/lottie_animation/pending.gif",
//                               height: 128.h,
//                               width: 128.w,
//                             ),
//                             const Text("Order is being prepared",
//                                 style: kTextStyle14Grey),
//                             const Text(
//                               "Estimated arrival",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             kHiegth20,
//                             const Text(
//                               "10 - 20 minutes",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                             kHiegth15,
//                             kHiegth24,
//                             const Text(
//                               "Mohammed has arrived at Dominos Pizza on time. If you have any questions, you can reach out to your rider 🛵 ",
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: Color(0xff5C5C5C),
//                               ),
//                             ),
//                             kHiegth10,
//                             const DeliveryBoyCard(),
//                           ],
//                         ),
//                       ),
//                     ),
//                     MyTimelineTile(
//                       isFirst: false,
//                       isLast: false,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text("Picked up your order"),
//                             const Text("Track your order"),
//                             Image.asset(
//                               "assets/lottie_animation/on_the_way.gif",
//                               height: 128,
//                               width: 128,
//                             ),
//                             Container(
//                               height: 32,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: kGrey,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: const Center(child: Text("Click Here")),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     MyTimelineTile(
//                       isFirst: false,
//                       isLast: false,
//                       child: Padding(
//                         padding: EdgeInsets.only(left: 16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "On delivery",
//                               style: kTextStyle14Grey,
//                             ),
//                             Row(
//                               children: [
//                                 const Text(
//                                   "Your order from- ",
//                                   style: kTextStyle14Grey,
//                                 ),
//                                 kWidth10,
//                                 Container(
//                                   height: 21,
//                                   width: 27,
//                                   decoration: BoxDecoration(
//                                     color: kGreen,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 kWidth10,
//                                 const Text("Vendor Name")
//                               ],
//                             ),
//                             kHiegth24,
//                             Container(
//                               padding: const EdgeInsets.all(13),
//                               height: 325.h,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(color: kGrey),
//                               ),
//                               child: const Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text("Item Count and Name"),
//                                       Spacer(),
//                                       Text("Item Price")
//                                     ],
//                                   ),
//                                   Divider(),
//                                   Row(
//                                     children: [
//                                       Text("Sub Total"),
//                                       Spacer(),
//                                       Text("Item Price")
//                                     ],
//                                   ),
//                                   kHiegth10,
//                                   Row(
//                                     children: [
//                                       Text("Discount"),
//                                       Spacer(),
//                                       Text("Item Price")
//                                     ],
//                                   ),
//                                   kHiegth10,
//                                   Row(
//                                     children: [
//                                       Text("Delivery fee"),
//                                       Spacer(),
//                                       Text("Item Price")
//                                     ],
//                                   ),
//                                   kHiegth10,
//                                   Row(
//                                     children: [
//                                       Text("Service fee"),
//                                       Spacer(),
//                                       Text("Item Price")
//                                     ],
//                                   ),
//                                   kHiegth10,
//                                   Row(
//                                     children: [
//                                       Text("Total"),
//                                       Spacer(),
//                                       Text("Item Price")
//                                     ],
//                                   ),
//                                   kHiegth10,
//                                   Row(
//                                     children: [
//                                       Text("Payment method"),
//                                       Spacer(),
//                                       Text("Cash")
//                                     ],
//                                   ),
//                                   kHiegth10,
//                                   Row(
//                                     children: [
//                                       Text("Delivery Time"),
//                                       Spacer(),
//                                       Text("23 Min")
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     MyTimelineTile(
//                       isFirst: false,
//                       isLast: false,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text("Order Placed"),
//                             const Text(
//                                 "Thanks 🙏 for your order check here anytime for updates"),
//                             kHiegth10,
//                             Container(
//                               padding: EdgeInsets.all(10),
//                               height: 66,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Color(0xffFFA4746B),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                           "You earned 15 points for this order"),
//                                       Text("View rewards"),
//                                     ],
//                                   ),
//                                   Image.asset(
//                                     "assets/icons/reward_icon_image.png",
//                                     height: 35.h,
//                                     width: 45.w,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             kHiegth18,
//                             Text(
//                               "Deliverying to",
//                               style: TextStyle(),
//                             ),
//                             kHiegth10,
//                             Row(
//                               children: [
//                                 Image.asset(
//                                   "assets/icons/address_icon_image.png",
//                                   height: 35,
//                                   width: 35,
//                                 ),
//                                 kWidth15,
//                                 const Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Text("The Address"),
//                                     Text("Phone Number")
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
