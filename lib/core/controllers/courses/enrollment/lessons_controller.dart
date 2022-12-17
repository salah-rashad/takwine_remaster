import 'package:flutter/material.dart';

import '../../../helpers/utils/change_notifier_helpers.dart';
import '../../../models/course_models/enrollment/enrollment.dart';
import '../../../models/course_models/lesson/lesson.dart';
import '../../../services/api_account.dart';

class LessonsController extends ChangeNotifier with ChangeNotifierHelpers {
  final Enrollment enrollment;
  LessonsController(this.enrollment) {
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

    lessons = await ApiAccount.getEnrollmentLessons(courseId);

    if (lessons != null) {
      for (var i = 0; i < lessons!.length; i++) {
        var lesson = lessons![i];

        if (lesson.isComplete == true) {
          lesson.status = LessonStatus.Complete;
        } else if ((i > 0 && lessons![i - 1].isComplete == true) ||
            enrollment.currentLesson?.id == lesson.id) {
          lesson.status = LessonStatus.InProgress;
        } else {
          if (i == 0) {
            lesson.status = LessonStatus.InProgress;
          } else {
            lesson.status = LessonStatus.Locked;
          }
        }
      }
    }
  }
}
