// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// import '../model/user_model.dart';

// class UserRepository extends GetxController{
//   static UserRepository get instance => Get.find();

//   final FirebaseFirestore _db = FirebaseFirestore.instance;


//   // 
//   Future<void> saveUserRecord(UserModel user)async{
//     try{
//       await _db.collection("users").doc(user.Id).set(user.toJson());
//     } on FirebaseException catch (e){
//       throw TFirebaseException(e.code).massage; 
//     }
//   }
// }