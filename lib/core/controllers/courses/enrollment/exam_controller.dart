import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../ui/widgets/dialogs/loading_dialog.dart';
import '../../../helpers/utils/change_notifier_state_logger.dart';
import '../../../helpers/utils/connectivity.dart';
import '../../../models/course_models/exam/exam.dart';
import '../../../models/course_models/exam/question.dart';
import '../../../models/course_models/lesson/lesson.dart';
import '../../../services/api_provider.dart';

enum ExamStatus {
  None,
  Started,
  Complete,
}

class ExamController extends ChangeNotifier with ChangeNotifierStateLogger {
  final Lesson lesson;
  ExamController(this.lesson);

  int _index = 0;
  Exam? _exam;
  Map<int, String> userAnswers = {};
  ExamStatus _examStatus = ExamStatus.None;

  PageController pageController = PageController();

  int get currentIndex => _index;
  set currentIndex(int value) {
    _index = value;
    notifyListeners();
  }

  Exam? get exam => _exam;
  set exam(Exam? value) {
    _exam = value;
    notifyListeners();
  }

  ExamStatus get examStatus => _examStatus;
  set examStatus(ExamStatus v) {
    _examStatus = v;
    notifyListeners();
  }

  List<Question>? get questions => _exam?.questions;

  void nextPage() async {
    if (currentIndex + 1 >= (questions?.length ?? 0)) return;

    await pageController.nextPage(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCirc,
    );
    if (kDebugMode) {
      var answer = questions?[currentIndex].answer;
      print("CORRECT IS $answer");
    }
  }

  void previousPage() async {
    if (currentIndex - 1 < 0) return;

    await pageController.previousPage(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCirc,
    );
    if (kDebugMode) {
      var answer = questions?[currentIndex].answer;
      print("CORRECT IS $answer");
    }
  }

  String? getChosenAnswer(int questionId) {
    String? answer = userAnswers[questionId];
    return answer;
  }

  void setAnswer(int questionId, String newAnswer) {
    var currentAnswer = userAnswers[questionId];

    try {
      if (currentAnswer == null) {
        userAnswers.addEntries([MapEntry(questionId, newAnswer)]);
        updateStatus();
      } else {
        userAnswers.update(questionId, (value) => newAnswer);
        updateStatus();
      }
    } catch (e) {
      rethrow;
    }
  }

  void updateStatus() {
    if (userAnswers.isNotEmpty) examStatus = ExamStatus.Started;
    if (questions?.length == userAnswers.length) {
      examStatus = ExamStatus.Complete;
    }
  }

  double getExamResult() {
    if (questions == null) return 0.0;

    int totalCorrectAnswers = 0;

    for (var question in questions!) {
      String? correctAnswer = question.answer;

      if (question.id != null) {
        String? userAnswer = getChosenAnswer(question.id!);

        if (userAnswer == correctAnswer) totalCorrectAnswers++;
      }
    }

    double result = (totalCorrectAnswers / questions!.length) * 100;
    return result;
  }

  Future<double> endExam(BuildContext context) async {
    double result = getExamResult();

    if (kDebugMode) {
      print(result.toString());
    }

    if (result >= 70) {
      if (await Connectivity.isInternetConnected()) {
        showLoadingDialog(context);

        await ApiProvider()
            .account
            .setLessonAsComplete(
              result,
              lesson.course!,
              lesson.id!,
            )
            .then((value) => Navigator.pop(context));
      }

      // await formationsController.getLessons().then((userFormations) async {
      //   if (userFormations.every((element) => element.isComplete!)) {
      //     await APIService.courses
      //         .setCourseAsCompleted(result.toString(), lesson?.lesson?.courseId)
      //         .then((value) async {
      //       print(value);
      //       if (value == true) {
      //         /**
      //          * In arguments:
      //          *
      //          * [result]: double of final exam result
      //          *
      //          * [true]: Continue Button will go to Home
      //          * [false]: Continue Button will go to formations page
      //          *
      //         **/

      //         await Get.offAndToNamed(
      //           Routes.COURSE_exam_RESULT,
      //           arguments: [result, true],
      //         )!
      //             .then((_) => formationsController.updateFormations());

      //         AppSnackbar.success(
      //           message: "تهانينا!\n"
      //               "لقد أكملت الدورة بنجاح 💖",
      //         );
      //       }
      //     });
      //   } else {
      //     Get.offAndToNamed(
      //       Routes.COURSE_exam_RESULT,
      //       arguments: [result, false],
      //     )!
      //         .then((_) => formationsController.updateFormations());
      //   }
      // });
    }

    return result;
  }

  Future<void> initialize() async {
    exam =
        await ApiProvider().courses.getLessonExam(lesson.course!, lesson.id!);
  }

  @override
  void addListener(VoidCallback listener) {
    initialize();
    super.addListener(listener);
  }
}
