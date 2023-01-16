import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../models/user_models/user.dart';
import '../../models/user_models/user_gender.dart';

abstract class ProfileEditingController extends ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  String get firstName => firstNameController.text;
  String get lastName => lastNameController.text;
  String get email => emailController.text;
  String get password => passwordController.text;
  String get birthDate => birthDateController.text;
  String get job => jobController.text;

  /* ***************** */

  UserGender? _selectedGender;
  UserGender? get selectedGender => _selectedGender;
  set selectedGender(UserGender? value) {
    _selectedGender = value;
    notifyListeners();
  }

  /* ***************** */

  String? _selectedCity;
  String? get selectedCity => _selectedCity;
  set selectedCity(String? value) {
    _selectedCity = value;
    notifyListeners();
  }

  /* ***************** */

  DateTime? _selectedDate = DateTime.now();

  DateTime? get selectedDate => _selectedDate;
  set selectedDate(DateTime? value) {
    _selectedDate = value;
    notifyListeners();
  }

  /* ***************** */

  bool _isEmailValid = false;

  bool get isEmailValid => _isEmailValid;
  set isEmailValid(bool v) {
    _isEmailValid = v;
    notifyListeners();
  }

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

  /// Checks if [email] is valid or not and updating [isEmailValid]
  void validateEmail(String email) {
    isEmailValid = EmailValidator.validate(email);
  }

  //* Date Picker

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
      textDirection: TextDirection.ltr,
      locale: const Locale("ar", "MA"),
      keyboardType: TextInputType.datetime,
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      birthDateController.text = intl.DateFormat("yyyy-MM-dd").format(picked);

      if (kDebugMode) {
        print(birthDateController.text);
      }
    }
  }
}
