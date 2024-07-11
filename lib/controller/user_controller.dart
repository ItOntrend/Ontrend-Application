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
    fetchUserDataFromPrefs();
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

    saveUserDataToPrefs();
  }

  Future<void> saveUserDataToPrefs() async {
    await LocalStorage.instance.writeDataToPrefs(key: 'firstName', value: firstName.value);
    await LocalStorage.instance.writeDataToPrefs(key: 'lastName', value: lastName.value);
    await LocalStorage.instance.writeDataToPrefs(key: 'email', value: email.value);
    await LocalStorage.instance.writeDataToPrefs(key: 'nationality', value: nationality.value);
    await LocalStorage.instance.writeDataToPrefs(key: 'number', value: number.value);
  }

  Future<void> fetchUserDataFromPrefs() async {
    firstName.value = await LocalStorage.instance.DataFromPrefs(key: 'firstName') ?? '';
    lastName.value = await LocalStorage.instance.DataFromPrefs(key: 'lastName') ?? '';
    email.value = await LocalStorage.instance.DataFromPrefs(key: 'email') ?? '';
    nationality.value = await LocalStorage.instance.DataFromPrefs(key: 'nationality') ?? '';
    number.value = await LocalStorage.instance.DataFromPrefs(key: 'number') ?? '';
  }

  // Fetch user data from Firebase
  Future<void> fetchUserData() async {
    try {
      String userId = await LocalStorage.instance.DataFromPrefs(key: HiveKeys.userData);
      log(userId);
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userData.exists) {
        var data = userData.data();
        if (data != null && data is Map<String, dynamic>) {
          setUserData(
            firstName: data['firstName'],
            lastName: data['lastName'],
            email: data['email'],
            nationality: data['nationality'],
            number: data['number'],
          );
        } else {
          print('Error: User data is not in expected format');
        }
      } else {
        print('Error: User document does not exist');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
