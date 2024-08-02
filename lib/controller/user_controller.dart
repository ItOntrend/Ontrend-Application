import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';

class UserController extends GetxController {
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var nationality = ''.obs;
  var number = ''.obs;
  var rewardPoints = 0.0.obs;
  var isLoading = false.obs;
  var profileImageUrl = ''.obs;

  RxMap<String, String> userDetail = RxMap<String, String>();

  @override
  void onInit() {
    super.onInit();
    everAll([firstName, lastName, email, nationality, number, rewardPoints],
        (_) {
      userDetail.value = {
        'firstName': firstName.value,
        'lastName': lastName.value,
        'email': email.value,
        'nationality': nationality.value,
        'number': number.value,
        'rewardPoints': rewardPoints.value.toString(),
      };
    });
    fetchUserDataFromPrefs();
  }

  void setUserData({
    required String firstName,
    required String lastName,
    required String email,
    required String nationality,
    required String number,
    required double rewardPoints,
  }) {
    this.firstName.value = firstName;
    this.lastName.value = lastName;
    this.email.value = email;
    this.nationality.value = nationality;
    this.number.value = number;
    this.rewardPoints.value = rewardPoints;

    saveUserDataToPrefs();
  }

  Future<void> saveUserDataToPrefs() async {
    await LocalStorage.instance
        .writeDataToPrefs(key: 'firstName', value: firstName.value);
    await LocalStorage.instance
        .writeDataToPrefs(key: 'lastName', value: lastName.value);
    await LocalStorage.instance
        .writeDataToPrefs(key: 'email', value: email.value);
    await LocalStorage.instance
        .writeDataToPrefs(key: 'nationality', value: nationality.value);
    await LocalStorage.instance
        .writeDataToPrefs(key: 'number', value: number.value);
    await LocalStorage.instance.writeDataToPrefs(
        key: 'rewardPoints', value: rewardPoints.value.toString());
  }

  Future<void> fetchUserDataFromPrefs() async {
    firstName.value =
        await LocalStorage.instance.dataFromPrefs(key: 'firstName') ?? '';
    lastName.value =
        await LocalStorage.instance.dataFromPrefs(key: 'lastName') ?? '';
    email.value = await LocalStorage.instance.dataFromPrefs(key: 'email') ?? '';
    nationality.value =
        await LocalStorage.instance.dataFromPrefs(key: 'nationality') ?? '';
    number.value =
        await LocalStorage.instance.dataFromPrefs(key: 'number') ?? '';
    rewardPoints.value = double.tryParse(await LocalStorage.instance
                .dataFromPrefs<String>(key: 'rewardPoints') ??
            '0') ??
        0.0;
  }

  // Fetch user data from Firebase
  Future<void> fetchUserData() async {
    isLoading.value = true;
    try {
      String userId =
          await LocalStorage.instance.dataFromPrefs(key: HiveKeys.userData);
      log(userId);
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userData.exists) {
        var data = userData.data();
        if (data != null) {
          setUserData(
            firstName: data['firstName'],
            lastName: data['lastName'],
            email: data['email'],
            nationality: data['nationality'],
            number: data['number'],
            rewardPoints: (data['rewardPoints'] ?? 0.0).toDouble(),
          );
          profileImageUrl.value = data['profileImageUrl'] ?? '';
        } else {
          print('Error: User data is not in expected format');
        }
      } else {
        print('Error: User document does not exist');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update individual user fields in Firebase
  Future<void> updateUserField(String field, String value) async {
    try {
      String userId =
          await LocalStorage.instance.dataFromPrefs(key: HiveKeys.userData);
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        field: value,
      });
      // Update local storage as well
      await LocalStorage.instance.writeDataToPrefs(key: field, value: value);
    } catch (e) {
      print('Error updating user $field: $e');
    }
  }

  // Delete account from Firebase
  Future<void> deleteAccount() async {
    try {
      String userId =
          await LocalStorage.instance.dataFromPrefs(key: HiveKeys.userData);
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Delete user document from Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .delete();

        // Delete the user's authentication record
        await user.delete();

        // Clear local storage
        await LocalStorage.instance.clearAll();

        // Optionally: You may want to log out the user and redirect them to a login screen
        await FirebaseAuth.instance.signOut();
      } else {
        print('Error: No user is currently logged in');
      }
    } catch (e) {
      print('Error deleting account: $e');
    }
  } // Upload profile image to Firebase Storage and update Firestore

  Future<void> uploadProfileImage(File image) async {
    try {
      String userId =
          await LocalStorage.instance.dataFromPrefs(key: HiveKeys.userData);

      // Upload image to Firebase Storage
      Reference storageRef =
          FirebaseStorage.instance.ref().child('profileImages/$userId.jpg');
      UploadTask uploadTask = storageRef.putFile(image);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore with the image URL
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'profileImageUrl': downloadUrl});

      profileImageUrl.value = downloadUrl;

      // Save to local storage
      await LocalStorage.instance
          .writeDataToPrefs(key: 'profileImageUrl', value: downloadUrl);
    } catch (e) {
      print('Error uploading profile image: $e');
    }
  }
}
