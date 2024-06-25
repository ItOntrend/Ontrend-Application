import 'package:get/get.dart';

class UserController extends GetxController {
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var nationality = ''.obs;
  var number = ''.obs;

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
}