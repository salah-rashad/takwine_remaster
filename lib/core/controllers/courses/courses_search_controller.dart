import 'package:flutter/material.dart';

import '../../models/course_models/course/course.dart';
import '../../services/api_provider.dart';

class CoursesSearchController extends ChangeNotifier {
  final TextEditingController searchTextCtrl = TextEditingController();

  // final FocusNode searchFocusNode = new FocusNode();

  String get searchCtrlText => searchTextCtrl.text;
  set searchCtrlText(String value) => searchTextCtrl.text = value;

  List<Course>? _courses;
  List<Course>? get courses => _courses;
  set courses(List<Course>? value) {
    _courses = value;
    notifyListeners();
  }

  Future<void> updateSearch() async {
    courses = null;
    courses = await ApiProvider().courses.searchCourses(searchCtrlText);
  }
}
