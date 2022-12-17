import 'package:flutter/material.dart';

import '../../helpers/utils/change_notifier_helpers.dart';
import '../../models/course_models/course/course.dart';
import '../../services/api_courses.dart';

class CoursesSearchController extends ChangeNotifier
    with ChangeNotifierHelpers {
  final TextEditingController textFieldController = TextEditingController();

  // final FocusNode searchFocusNode = new FocusNode();

  String get searchText => textFieldController.text;
  set searchText(String value) => textFieldController.text = value;

  List<Course>? _courses;
  List<Course>? get courses => _courses;
  set courses(List<Course>? value) {
    _courses = value;
    notifyListeners();
  }

  Future<void> updateSearch() async {
    courses = null;
    courses = await ApiCourses.searchCourses(searchText);
  }
}
