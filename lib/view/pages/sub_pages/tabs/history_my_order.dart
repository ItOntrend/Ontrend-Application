import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ontrend_food_and_e_commerce/controller/order_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/order_modal.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/widgets/my_order_card.dart';
import 'package:get/get.dart';

class HistoryMyOrder extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

  HistoryMyOrder({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    // Fetch the user's order history when the widget is built
    orderController.fetchUserOrders(userId);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Obx(() {
        if (orderController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Filter orders to only show rejected and completed
        var filteredOrders = orderController.orders.where((order) => 
          order.status == 'Rejected' || order.status == 'Completed').toList();

        if (filteredOrders.isEmpty) {
          return const Center(
            child: Text('No orders found'),
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
