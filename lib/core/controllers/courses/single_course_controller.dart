import 'package:flutter/material.dart';

import '../../helpers/constants/api_urls.dart';
import '../../helpers/utils/change_notifier_state_logger.dart';
import '../../models/course_models/course/course.dart';
import '../../models/course_models/enrollment/enrollment.dart';
import '../../models/course_models/lesson/lesson.dart';
import '../../services/api_provider.dart';

class SingleCourseController extends ChangeNotifier
    with ChangeNotifierStateLogger {
  final Course course;
  String pdfName;
  SingleCourseController(this.course) : pdfName = "دليل دورة: ${course.title}" {
    initialize();
  }

  //*******************/

  Enrollment? _courseProgress;
  Enrollment? get enrollment => _courseProgress;
  set enrollment(Enrollment? value) {
    _courseProgress = value;
    notifyListeners();
  }

  bool get isEnrolled => enrollment != null;

  //*******************/

  List<Lesson>? _lessons;
  List<Lesson>? get lessons => _lessons;
  set lessons(List<Lesson>? value) {
    _lessons = value;
    notifyListeners();
  }

  //*******************/

  //*******************/

  Future<void> initialize() async {
    pdfName = "دليل دورة: ${course.title}";

    initEnrollment();
    initLessons();
  }

  void initEnrollment() {
    enrollment = ApiUrls.ENROLLMENTS_single(course.id!)
        .getCache((map) => Enrollment.fromMap(map));
    ApiProvider()
        .account
        .getSingleEnrollment(course.id!)
        .then((value) => enrollment = value);
  }

  void initLessons() {
    lessons = ApiUrls.COURSE_lessons(course.id!).getCache(
      (map) => Lesson.fromMap(map),
    );
    ApiProvider()
        .courses
        .getLessons(course.id!)
        .then((value) => lessons = value);
  }

  Future<void> enroll() async {
    if (course.id != null) {
      enrollment = null;
      enrollment = await ApiProvider().account.enrollInCourse(course.id!);
    }
  }
}
