import 'package:flutter/material.dart';

import '../../../helpers/constants/api_urls.dart';
import '../../../helpers/utils/app_snackbar.dart';
import '../../../models/course_models/lesson/lesson.dart';
import '../../../models/course_models/material/lesson_material.dart';
import '../../../services/api_provider.dart';
import 'exam_controller.dart';

class MaterialsController extends ChangeNotifier {
  final Lesson lesson;
  MaterialsController(this.lesson) {
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
    if (index + 1 > totalCount) return;

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

  Future<void> getMaterial() async {
    if (isExam) return;
    material =
        ApiUrls.COURSE_lesson_material(lesson.course!, lesson.id!, currentIndex)
            .getCache((map) => LessonMaterial.fromMap(map));

    material = await ApiProvider()
        .courses
        .getLessonMaterial(lesson.course!, lesson.id!, currentIndex);
  }
}
