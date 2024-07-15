import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ontrend_food_and_e_commerce/model/order_modal.dart';

class OrderController extends GetxController {
  var orders = <OrderModel>[].obs;
  var isLoading = false.obs;

  // Method to fetch user orders from Firestore
  void fetchUserOrders(String userId) async {
    isLoading.value = true;
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('userID', isEqualTo: userId)
          .get();

      List<OrderModel> fetchedOrders = querySnapshot.docs.map((doc) {
        return OrderModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      orders.value = fetchedOrders;
    } catch (e) {
      print("Error fetching orders: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrder(String documentId) async {
  if (documentId.isEmpty) {
    print("Invalid document ID");
    return;
  }

  try {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('orders')
        .doc(documentId)
        .get();

    if (doc.exists) {
      // Process the document
      print("Document data: ${doc.data()}");
    } else {
      print("Document does not exist");
    }
  } catch (e) {
    print("Error fetching document: $e");
  }
}

}
