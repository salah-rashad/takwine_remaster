import 'package:flutter/material.dart';

import '../../../helpers/utils/change_notifier_state_logger.dart';
import '../../../models/course_models/enrollment/enrollment.dart';
import '../../../models/course_models/lesson/lesson.dart';
import '../../../services/api_provider.dart';

class EnrollmentLessonsController extends ChangeNotifier
    with ChangeNotifierStateLogger {
  final Enrollment enrollment;
  EnrollmentLessonsController(this.enrollment) {
    initialize();
  }

  List<Lesson>? _lessons;
  List<Lesson>? get lessons => _lessons;
  set lessons(List<Lesson>? value) {
    _lessons = value;
    notifyListeners();
  }

  Future<void> initialize() async {
    var courseId = enrollment.course?.id;
    if (courseId != null) {
      var list = await ApiProvider().courses.getLessons(courseId);
      var completeLessons =
          await ApiProvider().account.getCompleteLessons(courseId);

      for (int i = 0; i < list.length; i++) {
        var lesson = list[i];

        if (completeLessons.any((e) => e.lesson == lesson.id)) {
          lesson.status = LessonStatus.Complete;
          lesson.result =
              completeLessons.firstWhere((e) => e.lesson == lesson.id).result;
        } else if (enrollment.currentLesson?.id == lesson.id) {
          lesson.status = LessonStatus.InProgress;
        } else {
          if (i != 0) {
            lesson.status = LessonStatus.Locked;
          }
        }
      }

      lessons = list;
    }
  }
}
