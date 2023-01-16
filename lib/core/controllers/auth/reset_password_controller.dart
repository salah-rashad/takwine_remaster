import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../helpers/utils/change_notifier_helpers.dart';

class ResetPasswordController extends ChangeNotifier
    with ChangeNotifierHelpers {
  TextEditingController emailController = TextEditingController();
  String get email => emailController.text;

  GlobalKey<FormState> formKey = GlobalKey();

  /* ***************** */

  bool _isEmailValid = false;

  bool get isEmailValid => _isEmailValid;
  set isEmailValid(bool v) {
    _isEmailValid = v;
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

  /// Checks if [email] is valid or not and updating [isEmailValid]
  void validateEmail(String email) {
    isEmailValid = EmailValidator.validate(email);
  }

  Future<void> resetPassword() async {
    if (formKey.currentState?.validate() == true) {}
  }
}
