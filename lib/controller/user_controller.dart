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
