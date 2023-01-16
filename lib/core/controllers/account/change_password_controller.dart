import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../helpers/utils/app_snackbar.dart';
import '../../helpers/utils/change_notifier_helpers.dart';
import '../../services/api_account.dart';

class ChangePasswordController extends ChangeNotifier
    with ChangeNotifierHelpers {
  final String? resetToken;
  ChangePasswordController({this.resetToken});

  var formKey = GlobalKey<FormState>();
  DateTime? currentBackPressTime;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmController = TextEditingController();

  String get oldPassword => oldPasswordController.text;
  String get newPassword => newPasswordController.text;
  String get newPasswordConfirm => newPasswordConfirmController.text;

  /* ***************** */

  bool _passwordRevealed = false;

  bool get passwordRevealed => _passwordRevealed;
  set passwordRevealed(bool v) {
    _passwordRevealed = v;
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

  Future<bool> changePassword() async {
    if (formKey.currentState?.validate() == false) return false;

    isLoading = true;

    if (newPassword != newPasswordConfirm) {
      AppSnackbar.error(message: "كلمة المرور غير متطابقة.");
      return false;
    }

    var result = await ApiAccount.changePassword(oldPassword, newPassword);

    isLoading = false;
    return result;
  }

  String? oldPasswordValidator(String? value) {
    if (value == null || value.isEmpty) return "هذا الحقل مطلوب";
    return null;
  }

  String? newPasswordValidator(String? value) {
    if (value == null || value.isEmpty) return "هذا الحقل مطلوب";
    return null;
  }

  String? newPasswordConfirmValidator(String? value) {
    if (value != newPassword) {
      return "كلمة المرور غير متطابقة.";
    }

    return null;
  }

  Future<bool> onWillPop() {
    if (resetToken != null) {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(
          msg: "اضغط على زر الرجوع مرة أخرى للخروج من الصفحة",
          toastLength: Toast.LENGTH_SHORT,
        );
        return Future.value(false);
      }
    }
    return Future.value(true);
  }
}
