import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../helpers/enums/auth_status_enum.dart';
import '../../helpers/utils/cache_manager.dart';
import '../../helpers/utils/change_notifier_helpers.dart';
import '../../helpers/utils/logger.dart';
import '../../services/api_account.dart';
import '../../services/api_auth.dart';
import 'auth_controller.dart';

class LoginController extends ChangeNotifier with ChangeNotifierHelpers {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String get email => emailController.text;
  String get password => passwordController.text;

  /* ***************** */

  bool _isEmailValid = false;

  bool get isEmailValid => _isEmailValid;
  set isEmailValid(bool v) {
    _isEmailValid = v;
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

  /// Check if Email string is valid
  void validateEmail(String email) {
    isEmailValid = EmailValidator.validate(email);
  }

  /// Login with Email & Password
  Future<bool> loginWithEmailPassword(AuthController auth) async {
    bool result = false;
    isLoading = true;

    var response = await ApiAuth.loginUser(email, password);

    if (response != null) {
      if (response.statusCode == HttpStatus.ok) {
        var body = response.data;
        var token = CacheManager.getToken();

        Logger.White.log(body['message']);
        Logger.Magenta.log("EMAIL: $email");
        Logger.Magenta.log("TOKEN: $token");

        auth.status = AuthStatus.LOGGED_IN;
        auth.user = await ApiAccount.getProfile();
        auth.fetchLastActivity();

        result = true;

        passwordController.clear();
      }
    }

    isLoading = false;

    return result;
  }
}
