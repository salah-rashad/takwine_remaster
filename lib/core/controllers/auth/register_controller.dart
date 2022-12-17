import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants/constants.dart';
import '../../helpers/utils/change_notifier_helpers.dart';
import 'package:intl/intl.dart' as intl;

import '../../models/user_models/user.dart';
import '../../models/user_models/user_gender.dart';
import '../../services/api_account.dart';
import '../../services/api_auth.dart';

class RegisterController extends ChangeNotifier with ChangeNotifierHelpers {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  String get email => emailController.text;
  String get password => passwordController.text;
  String get firstName => firstNameController.text;
  String get lastName => lastNameController.text;
  String get birthDate => birthDateController.text;
  String get job => jobController.text;

  // final picker = ImagePicker();

  /* ***************** */

  UserGender _selectedGender = UserGender.values[0];
  UserGender get selectedGender => _selectedGender;
  set selectedGender(UserGender value) {
    _selectedGender = value;
    notifyListeners();
  }

  /* ***************** */

  String _selectedCity = cities[0];
  String get selectedCity => _selectedCity;
  set selectedCity(String value) {
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
      textDirection: TextDirection.rtl,
      locale: const Locale("ar", "MA"),
      keyboardType: TextInputType.datetime,
    );

    if (picked != selectedDate) {
      selectedDate = picked;
      birthDateController.text = intl.DateFormat("yyyy-MM-dd").format(picked!);

      if (kDebugMode) {
        print(birthDateController.text);
      }
    }
  }

  Future<bool> createAccount() async {
    var result = false;

    if (isLoading) return false;
    isLoading = true;

    User user = User(
      first_name: firstName,
      last_name: lastName,
      email: email,
      birthDate: birthDate,
      gender: selectedGender.name,
      city: selectedCity,
      job: job,
    );

    try {
      result = await ApiAuth.createUser(user, password);
    } catch (e) {
      result = false;
    }

    isLoading = false;
    return result;
  }
}
