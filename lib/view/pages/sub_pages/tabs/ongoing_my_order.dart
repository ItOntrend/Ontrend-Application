import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/order_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/order_modal.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/my_order_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';

class OngoingMyOrder extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

  OngoingMyOrder({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    // Fetch the user's ongoing orders when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderController.fetchUserOrders(userId);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Obx(() {
        if (orderController.isLoading.value) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return const ShimmerItems();
            },
          );
        }

        // Filter orders to only show those with statuses from pending to ready
        var filteredOrders = orderController.orders
            .where((order) =>
                order.status == 'Pending' ||
                order.status == 'Processing' ||
                order.status == 'Ready' ||
                order.status == 'Picked Up')
            .toList();

        // Sort the filtered orders by timestamp in descending order
        filteredOrders
            .sort((a, b) => b.orderTimestamp.compareTo(a.orderTimestamp));

        if (filteredOrders.isEmpty) {
          return Center(
            child: Text('No orders found'.tr),
          );
        }
        return ListView.builder(
          itemCount: filteredOrders.length,
          itemBuilder: (context, index) {
            OrderModel order = filteredOrders[index];
            return Column(
              children: [
                MyOrderCard(
                  restaurantName: order.restaurantName,
                  location: LatLng(order.restaurantLocation.lat,
                      order.restaurantLocation.lng),
                  status: order.status,
                  items: order.items,
                  totalPrice: order.totalPrice,
                  userId: order.userId,
                  orderId: order.orderID,
                ),
                const SizedBox(height: 25),
              ],
            );
          },
        );
      }),
    );
  }
}

class ShimmerItems extends StatelessWidget {
  const ShimmerItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        height: 200.h,
      ),
    );
  }
}
