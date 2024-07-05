import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  // get collection of orders
  final CollectionReference order = FirebaseFirestore.instance.collection("orders");


  // save orders to database
  Future<void> saveOrderToDatabase(String receipt) async{
    await order.add({
      'date' : DateTime.now(),
      'order': receipt,
      //  add more if neccesery
    });

  }
}