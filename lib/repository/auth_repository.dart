import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ontrend_food_and_e_commerce/utils/constants/firebase_constants.dart';
import 'package:ontrend_food_and_e_commerce/utils/enums/auth_status.dart';
import 'package:ontrend_food_and_e_commerce/utils/exception/auth_exception.dart';
import 'package:ontrend_food_and_e_commerce/utils/local_storage/local_storage.dart';

abstract class AuthRepository {
  static Future<AuthStatus> login(
      {required String email, required String pass}) async {
    AuthStatus _status;
    try {
      final authResult = await FirebaseConstants.authInstance
          .signInWithEmailAndPassword(email: email, password: pass);

      if (authResult.user != null) {
        await LocalStorage.instance.writeDataToPrefs(
            key: HiveKeys.userData, value: authResult.user!.uid);

        String? token = await FirebaseMessaging.instance.getToken();

        if (token != null) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(authResult.user!.uid)
              .update({"fcmToken": token});
        }
        // Singleton.instance.someMethod();
        _status = AuthStatus.successful;
      } else {
        _status = AuthStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  static Future<AuthStatus> signUp({
    required String email,
    required String pass,
    required String firstName,
    required String lastName,
    required String nationality,
    required String number,
    required String role,
    required DateTime timeStamp,
    required double rewardPoints,
  }) async {
    AuthStatus _status;

    // Validate phone number (8 digits)
    if (!RegExp(r'^\d{8}$').hasMatch(number)) {
      print('Invalid phone number');
      return AuthStatus.invalidPhoneNumber;
    }

    // Validate password (custom validation can be added here)
    // if (!RegExp(r'^[a-zA-Z\d]{8,}$').hasMatch(pass)) {
    //   print('Invalid password');
    //   return AuthStatus.invalidPassword;
    // }

    try {
      // Create a new user with Firebase Authentication
      final authResult = await FirebaseConstants.authInstance
          .createUserWithEmailAndPassword(email: email, password: pass);

      if (authResult.user != null) {
        // Send email verification
        await authResult.user!.sendEmailVerification();
        await LocalStorage.instance.writeDataToPrefs(
            key: HiveKeys.userData, value: authResult.user!.uid);

        String? token = await FirebaseMessaging.instance.getToken();

        // Store additional user information in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'firstName': firstName,
          'lastName': lastName,
          'nationality': nationality,
          'number': number,
          'email': email,
          'role': role,
          'timeStamp': timeStamp,
          'emailVerified':
              authResult.user!.emailVerified, // Add email verification status
          'fcmToken': token
        });

        _status = AuthStatus.successful;
      } else {
        _status = AuthStatus.undefined;
      }
    } catch (e) {
      print('Exception @signUp: $e');
      _status = AuthExceptionHandler.handleException(e);
    }

    return _status;
  }

  // static Future<AuthStatus> signUp({
  //   required String email,
  //   required String pass,
  //   required String firstName,
  //   required String lastName,
  //   required String nationality,
  //   required String number,
  //   required String role,
  //   required DateTime timeStamp,
  // }) async {
  //   AuthStatus _status;

  //   // Validate phone number (10 digits)
  //   if (!RegExp(r'^\d{8}$').hasMatch(number)) {
  //     print('Invalid phone number');
  //     return AuthStatus.invalidPhoneNumber;
  //   }

  //   // Validate password
  //   // if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(pass))
  //   if (!RegExp(r'^[a-zA-Z\d]{8,}$').hasMatch(pass))
  //    {
  //     print('Invalid password');
  //     return AuthStatus.invalidPassword;
  //   }

  //   try {
  //     // Create a new user with Firebase Authentication
  //     final authResult = await FirebaseConstants.authInstance
  //         .createUserWithEmailAndPassword(email: email, password: pass);

  //     if (authResult.user != null) {
  //       // Store additional user information in Firestore
  //       await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
  //         'firstName': firstName,
  //         'lastName': lastName,
  //         'nationality': nationality,
  //         'number': number,
  //         'email': email,
  //         'role': role,
  //         'timeStamp': timeStamp,
  //       });
  //       _status = AuthStatus.successful;
  //     } else {
  //       _status = AuthStatus.undefined;
  //     }
  //   } catch (e) {
  //     print('Exception @signUp: $e');
  //     _status = AuthExceptionHandler.handleException(e);
  //   }
  //   return _status;
  // }

  static Future<AuthStatus> forgotPassword({required String email}) async {
    AuthStatus _status;
    try {
      await FirebaseConstants.authInstance.sendPasswordResetEmail(email: email);
      _status = AuthStatus.successful;
    } catch (e) {
      print('Exception @forgotPassword: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  static Future<void> onLogOut() async {
    try {
      await LocalStorage.instance.clearPrefs();
      print("Local storage cleared.");
    } catch (e) {
      print("Error clearing local storage: $e");
    }

    try {
      await FirebaseConstants.authInstance.signOut();
      print("Signed out from Firebase.");
    } catch (e) {
      print("Error signing out from Firebase: $e");
    }
  }

  static Future<AuthStatus> deleteAccount() async {
    AuthStatus _status;
    try {
      final user = FirebaseConstants.authInstance.currentUser;

      if (user != null) {
        // Delete user from Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();

        // Delete user from Firebase Auth
        await user.delete();

        // Sign out and clear user data from local storage
        await FirebaseConstants.authInstance.signOut();
        await LocalStorage.instance.clearPrefs();

        _status = AuthStatus.successful;
        print("deleted auth");
      } else {
        _status = AuthStatus.undefined;
      }
    } catch (e) {
      print('Exception @deleteAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }
}
