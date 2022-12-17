import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/constants/urls.dart';
import '../../../helpers/utils/app_snackbar.dart';
import '../../../helpers/utils/change_notifier_helpers.dart';
import '../../../models/course_models/lesson/lesson.dart';
import '../../../models/course_models/material/lesson_material.dart';
import '../../../services/api_courses.dart';
import '../../auth/auth_controller.dart';
import 'exam_controller.dart';

class ClassroomController extends ChangeNotifier with ChangeNotifierHelpers {
  final Lesson lesson;
  final BuildContext context;

  ClassroomController(this.context, this.lesson) {
    context.read<AuthController>().updateLastActivity(lesson.course);
    getMaterial();
  }

  final scrollController = ScrollController();

  int _index = 0;
  int get currentIndex => _index;
  set currentIndex(int v) {
    _index = v;
    notifyListeners();
    getMaterial();
  }

  LessonMaterial? _material;
  LessonMaterial? get material => _material;
  set material(LessonMaterial? v) {
    _material = v;
    notifyListeners();
  }

  int get totalCount => (lesson.totalMaterialsCount ?? 0) + 1;

  bool get isExam => currentIndex + 1 == totalCount;

  void changeIndex(int index, ExamStatus examStatus) {
    if (index + 1 > totalCount || index < 0) return;

    if (isExam) {
      if (index + 1 < totalCount) {
        if (examStatus != ExamStatus.None) {
          AppSnackbar.warning(
            message: "يجب أن تنتهي من حل الاختبار أولاً",
          );
          return;
        }
      }
    }

    currentIndex = index;
  }

  void nextPage(ExamStatus examStatus) {
    changeIndex(
      currentIndex + 1,
      examStatus,
    );
  }

  void previousPage(ExamStatus examStatus) {
    changeIndex(
      currentIndex - 1,
      examStatus,
    );
  }

  Future<void> getMaterial() async {
    if (isExam) return;
    material =
        ApiUrls.COURSES_lesson_material(lesson.course, lesson.id, currentIndex)
            .getCache(LessonMaterial.fromMap);

    material = await ApiCourses.getLessonMaterial(
      lesson.course,
      lesson.id,
      currentIndex,
    );
  }
}
