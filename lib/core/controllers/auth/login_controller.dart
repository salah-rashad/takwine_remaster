import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../helpers/enums/auth_status_enum.dart';
import '../../helpers/utils/cache_manager.dart';
import '../../helpers/utils/change_notifier_state_logger.dart';
import '../../helpers/utils/logger.dart';
import '../../services/api_provider.dart';
import 'auth_controller.dart';

class LoginController extends ChangeNotifier with ChangeNotifierStateLogger {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String get email => emailController.text;
  String get password => passwordController.text;

  /* ***************** */

  bool _isValid = false;

  bool get isValid => _isValid;
  set isValid(bool v) {
    _isValid = v;
    notifyListeners();
  }

  /* ***************** */

  bool _showPassword = false;

  bool get passwordRevealed => _showPassword;
  set passwordRevealed(bool v) {
    _showPassword = v;
    notifyListeners();
  }

  /* ***************** */

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  /* ***************** */

  //*   Login with Email & Password   **/

  Future<bool> loginWithEmailPassword(AuthController auth) async {
    bool result = false;
    isLoading = true;

    var response = await ApiProvider().auth.loginUser(email, password);

    if (response != null) {
      if (response.statusCode == HttpStatus.ok) {
        var body = response.data;
        var token = CacheManager.getToken();

        Logger.White.log(body['message']);
        Logger.Magenta.log("EMAIL: $email");
        Logger.Magenta.log("TOKEN: $token");

        auth.status = AuthStatus.LOGGED_IN;
        auth.user = await ApiProvider().account.getProfile();
        ApiProvider().account.getLastActivity().then(
              (value) => auth.lastActivity = value,
            );

        result = true;

        passwordController.clear();
      }
    }

    isLoading = false;

    return result;
  }

  //**   Check if Email string is valid   **/

  void validateEmail(String email) {
    isValid = EmailValidator.validate(email);
  }

  //**   Validate login inputs and show error snackbar   **/

  // void validateLogin(String? message, {bool isSocialLogin = false}) {
  //   switch (message) {

  //     /**  API Errors **/

  //     case "Email is required":
  //       ReadySnackBar(
  //         "خطأ!",
  //         isSocialLogin
  //             ? "حدث خطأ ما!، يرجى المحاولة مرة أخرى."
  //             : "البريد الإلكتروني يجب ألا يكون فارغاً.",
  //       ).showError();
  //       break;
  //     case "Password is required":
  //       ReadySnackBar(
  //         "خطأ!",
  //         "كلمة المرور يجب ألا تكون فارغة.",
  //       ).showError();
  //       break;
  //     case "Login Failed. User not Found":
  //       isSocialLogin
  //           ? ReadySnackBar(
  //               "خطأ!",
  //               "هذا الحساب غير موجود، هل تريد إنشاء حساب جديد؟ ",
  //             ).prompt(
  //               onConfirm: () => Get.toNamed(Routes.REGISTER),
  //               onCancel: null,
  //             )
  //           : ReadySnackBar(
  //               "خطأ!",
  //               "حدث خطأ ما، من فضلك تأكد من البريد الإلكتروني وكلمة المرور.",
  //             ).showError();
  //       break;
  //     case "Login Successful":
  //       passwordController.clear();
  //       // result = true;
  //       break;
  //     default:
  //       ReadySnackBar(
  //         "خطأ!",
  //         message.toString(),
  //       ).showError();
  //   }
  // }
}
