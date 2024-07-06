import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';

class UserController extends GetxController {
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var nationality = ''.obs;
  var number = ''.obs;

  RxMap<String, String> userDetail = RxMap<String, String>();

  @override
  void onInit() {
    super.onInit();
    everAll([firstName, lastName, email, nationality, number], (_) {
      userDetail.value = {
        'firstName': firstName.value,
        'lastName': lastName.value,
        'email': email.value,
        'nationality': nationality.value,
        'number': number.value,
      };
    });
  }

  void setUserData({
    required String firstName,
    required String lastName,
    required String email,
    required String nationality,
    required String number,
  }) {
    this.firstName.value = firstName;
    this.lastName.value = lastName;
    this.email.value = email;
    this.nationality.value = nationality;
    this.number.value = number;
  }

  // Fetch user data from Firebase
  Future<void> fetchUserData() async {
    try {
      String userId =
          await LocalStorage.instance.DataFromPrefs(key: HiveKeys.userData);
      log(userId);
      // Replace with your Firebase Firestore instance
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Update controller's observable values
      if (userData.exists) {
        var data = userData.data();
        if (data != null) {
          setUserData(
            firstName: data['firstName'],
            lastName: data['lastName'],
            email: data['email'],
            nationality: data['nationality'],
            number: data['number'],
          );
          log(data as String);
        }
      }
    } catch (e) {
      // Handle error
      print('Error fetching user data: $e');
    }
  }
}
