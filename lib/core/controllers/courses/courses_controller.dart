import 'package:flutter/material.dart';

import '../../helpers/constants/api_urls.dart';
import '../../helpers/utils/change_notifier_state_logger.dart';
import '../../models/course_models/course/course.dart';
import '../../models/course_models/enrollment/enrollment.dart';
import '../../models/user_models/user_statements.dart';
import '../../services/api_provider.dart';

class CoursesController extends ChangeNotifier with ChangeNotifierStateLogger {
  CoursesController() {
    initialize();
  }

  int _index = 0;
  List<Course>? _featuredCourses;
  List<Course>? _allCourses;
  UserStatements? _statements;
  List<Enrollment>? _enrollments;

  int get currentIndex => _index;
  set currentIndex(int value) {
    _index = value;
    notifyListeners();
  }

  List<Course>? get featuredCourses => _featuredCourses;
  set featuredCourses(List<Course>? value) {
    _featuredCourses = value;
    notifyListeners();
  }

  List<Course>? get allCourses => _allCourses;
  set allCourses(List<Course>? value) {
    _allCourses = value;
    notifyListeners();
  }

  UserStatements? get statements => _statements;
  set statements(UserStatements? value) {
    _statements = value;
    notifyListeners();
  }

  List<Enrollment>? get enrollments => _enrollments;
  set enrollments(List<Enrollment>? value) {
    _enrollments = value;
    notifyListeners();
  }

  PageController pageController = PageController();
  Set<int> initializedTabs = {};

  Future<void> initialize() async {
    // load cached data
    // for home page
    featuredCourses =
        ApiUrls.COURSES_FEATURED.getCache((map) => Course.fromMap(map));
    allCourses = ApiUrls.COURSES.getCache((map) => Course.fromMap(map));

    // for my activity page
    statements =
        ApiUrls.USER_STATEMENTS.getCache((map) => UserStatements.fromMap(map));
    enrollments =
        ApiUrls.ENROLLMENTS.getCache((map) => Enrollment.fromMap(map));

    await initHomeTab();
  }

  Future<void> initHomeTab({force = false}) async {
    if (!force) {
      if (initializedTabs.contains(0)) return;
    }
    initializedTabs.add(0);
    // fetch new data
    featuredCourses = await ApiProvider().courses.getFeaturedCourses();
    allCourses = await ApiProvider().courses.getAllCourses();
  }

  Future<void> initActivityTab({force = false}) async {
    if (!force) {
      if (initializedTabs.contains(1)) return;
    }
    initializedTabs.add(1);
    // fetch new data
    statements = await ApiProvider().account.getUserStatements();
    enrollments = await ApiProvider().account.getEnrollments();
  }

  Future<void> iniCertificatesTab({force = false}) async {
    if (!force) {
      if (initializedTabs.contains(2)) return;
    }
    initializedTabs.add(2);
    // fetch new data
  }

  Future<void> iniBookmarksTab({force = false}) async {
    if (!force) {
      if (initializedTabs.contains(3)) return;
    }
    initializedTabs.add(3);
    // fetch new data
  }

  void changeIndex(int index) {
    // index is auto assigned to "_index" property
    // through PageView's onPageChanged

    // pageController.animateToPage(
    //   index,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeIn,
    // );

    pageController.jumpToPage(index);
  }
}
