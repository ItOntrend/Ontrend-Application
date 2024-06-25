import 'package:ontrend_food_and_e_commerce/utils/enums/auth_status.dart';

class AuthExceptionHandler {
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "ERROR_INVALID_EMAIL":
        status = AuthStatus.invalidEmail;
        break;
      case "ERROR_WRONG_PASSWORD":
        status = AuthStatus.wrongPassword;
        break;
      case "ERROR_USER_NOT_FOUND":
        status = AuthStatus.userNotFound;
        break;
      case "ERROR_USER_DISABLED":
        status = AuthStatus.userDisabled;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        status = AuthStatus.tooManyRequests;
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        status = AuthStatus.operationNotAllowed;
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        status = AuthStatus.emailAlreadyExists;
        break;
      default:
        status = AuthStatus.undefined;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthStatus.wrongPassword:
        errorMessage = "Your password is wrong.";
        break;
      case AuthStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthStatus.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case AuthStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage =
            "The email has already been registered. Please login or reset your password.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }
}