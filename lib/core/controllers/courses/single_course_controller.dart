import 'package:flutter/material.dart';

import '../../helpers/constants/urls.dart';
import '../../helpers/utils/change_notifier_helpers.dart';
import '../../models/course_models/course/course.dart';
import '../../models/course_models/course_bookmark.dart';
import '../../models/course_models/enrollment/enrollment.dart';
import '../../models/course_models/lesson/lesson.dart';
import '../../services/api_account.dart';
import '../../services/api_courses.dart';

class SingleCourseController extends ChangeNotifier with ChangeNotifierHelpers {
  final Course course;
  SingleCourseController(this.course) {
    initialize();
  }

  Enrollment? _courseProgress;
  List<Lesson>? _lessons;
  CourseBookmark? _bookmark;

  Enrollment? get enrollment => _courseProgress;
  set enrollment(Enrollment? value) {
    _courseProgress = value;
    notifyListeners();
  }

  List<Lesson>? get lessons => _lessons;
  set lessons(List<Lesson>? value) {
    _lessons = value;
    notifyListeners();
  }

  CourseBookmark? get bookmark => _bookmark;
  set bookmark(CourseBookmark? value) {
    _bookmark = value;
    notifyListeners();
  }

  bool get isEnrolled => enrollment != null;
  bool get isBookmarked =>
      bookmark != null && bookmark != CourseBookmark.empty();

  //*******************//

  Future<void> initialize() async {
    initEnrollment();
    initLessons();
    initBookmark();
  }

  void initEnrollment() {
    enrollment = ApiUrls.ACCOUNT_enrollments_single(course.id)
        .getCache((map) => Enrollment.fromMap(map));
    ApiAccount.getSingleEnrollment(course.id)
        .then((value) => enrollment = value);
  }

  void initLessons() {
    lessons = ApiUrls.COURSES_lessons(course.id).getCache(
      (map) => Lesson.fromMap(map),
    );
    ApiCourses.getLessons(course.id).then((value) => lessons = value);
  }

  void initBookmark() {
    bookmark = ApiUrls.ACCOUNT_course_bookmarks_single(course.id).getCache(
      (map) => CourseBookmark.fromMap(map),
    );
    ApiAccount.getSingleCourseBookmark(course.id).then((value) {
      if (value != null) {
        bookmark = value;
      } else {
        bookmark = CourseBookmark.empty();
      }
    });
  }

  Future<void> enroll() async {
    if (course.id != null) {
      enrollment = null;
      enrollment = await ApiAccount.enrollInCourse(course.id);
    }
  }

  Future<void> toggleBookmark() async {
    final currentValue = bookmark?.copyWith();

    bool shouldRemove = isBookmarked;

    bookmark = null;
    if (shouldRemove) {
      bool success = await ApiAccount.removeCourseBookmark(course.id);
      if (success) {
        bookmark = CourseBookmark.empty();
      } else {
        bookmark = currentValue;
      }
    } else {
      bookmark = await ApiAccount.addCourseBookmark(course.id) ??
          CourseBookmark.empty();
    }
  }
}
