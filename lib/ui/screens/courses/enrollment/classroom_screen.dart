import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/controllers/courses/enrollment/classroom_controller.dart';
import '../../../../core/controllers/courses/enrollment/exam_controller.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/routes/routes.dart';
import '../../../../core/models/course_models/lesson/lesson.dart';
import '../../../../core/models/course_models/material/lesson_material.dart';
import '../../../theme/palette.dart';
import '../../../widgets/navbars/classroom_navbar.dart';
import '../../../widgets/dialogs/general_dialog.dart';
import '../../../widgets/enrollment/material_item.dart';
import '../../../widgets/shimmers/material_item_shimmer.dart';
import 'exam_view.dart';

class ClassroomScreen extends StatelessWidget {
  final Lesson lesson;

  const ClassroomScreen({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    // var size = context.mediaQuery.size;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ClassroomController(context, lesson),
          ),
          ChangeNotifierProvider(
            create: (context) => ExamController(lesson),
            lazy: true,
          ),
        ],
        builder: (context, _) {
          final controller = context.watch<ClassroomController>();
          final examController = context.watch<ExamController>();

          return WillPopScope(
            onWillPop: () async {
              if (examController.examStatus != ExamStatus.None) {
                return await goBackDialog(context) ?? false;
              } else {
                if (controller.currentIndex == 0) return true;
                controller.previousPage(examController.examStatus);
              }

              return false;
            },
            child: Scaffold(
              backgroundColor: Palette.BACKGROUND,
              body: Stack(
                children: [
                  topPanel(context, examController),
                  Column(
                    children: [
                      const SizedBox(
                        height: 120.0,
                      ),
                      Expanded(
                        child: Stack(
                          fit: StackFit.loose,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
                              child: contentView(
                                  context, controller, examController),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 22.0),
                              child: materialChip(controller),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Builder(
                        builder: (context) {
                          var status = examController.examStatus;

                          if (status == ExamStatus.None) {
                            return ClassroomNavBar(
                              controller: controller,
                              examController: examController,
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                                vertical: 16.0,
                              ),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: ElevatedButton.icon(
                                  onPressed: status == ExamStatus.Complete
                                      ? () => endExam(context)
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                      minimumSize:
                                          const Size(double.infinity, 56.0),
                                      backgroundColor: Palette.BLUE1),
                                  label: const Text(
                                    "إنهاء الاختبار",
                                    textDirection: TextDirection.rtl,
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_back_rounded,
                                    textDirection: TextDirection.ltr,
                                    // color: Palette.WHITE,
                                    size: 32,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  //////////////////////////////////////////////

  Widget topPanel(BuildContext context, ExamController examCtrl) {
    return Container(
      color: Palette.BLUE1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            // status bar height
            height: MediaQuery.of(context).padding.top + 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11.0),
                  child: Text(
                    (lesson.ordering ?? 0).toStringFormatted("00"),
                    style:
                        const TextStyle(color: Palette.WHITE, fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    (lesson.title ?? "").trimRight(),
                    style:
                        const TextStyle(color: Palette.WHITE, fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: Center(
                      child: IconButton(
                        onPressed: () async {
                          if (examCtrl.examStatus != ExamStatus.None) {
                            await goBackDialog(context);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          textDirection: TextDirection.ltr,
                        ),
                        iconSize: 18.0,
                        color: Palette.WHITE,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100.0),
        ],
      ),
    );
  }

  //////////////////////////////////////////////

  Widget materialChip(ClassroomController controller) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: 26.0,
        margin: const EdgeInsets.only(left: 22.0),
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0xFFFD7E77),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          controller.isExam
              ? "الاختبار"
              : "المادة ${(controller.currentIndex + 1).toStringFormatted("00")}",
          style: const TextStyle(color: Palette.WHITE, fontSize: 14.0),
        ),
      ),
    );
  }

  //////////////////////////////////////////////

  Widget contentView(
    BuildContext context,
    ClassroomController controller,
    ExamController examController,
  ) {
    var size = context.mediaQuery.size;

    return AnimatedContainer(
      margin: const EdgeInsets.only(top: 13.0),
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: size.height / 3,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Palette.WHITE,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: Palette.BLACK.withOpacity(0.20),
              blurRadius: 30.0,
              offset: const Offset(0.0, 8.0),
            )
          ]),
      duration: const Duration(milliseconds: 400),
      child: Builder(
        builder: (context) {
          if (controller.isExam) {
            return ExamView(
              lesson,
              examController,
            );
          } else {
            return materialView(controller);
          }
        },
      ),
    );
  }

  Widget materialView(ClassroomController controller) {
    return Selector<ClassroomController, LessonMaterial?>(
      selector: (p0, p1) => p1.material,
      builder: (context, material, _) {
        if (material != null) {
          return Padding(
            padding: const EdgeInsets.all(22.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: MaterialItem(material),
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.all(22.0),
            child: SingleChildScrollView(
              child: MaterialItemShimmer(),
            ),
          );
        }
      },
    );
  }

  Future<bool?> goBackDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => GeneralDialog(
        context,
        title: "تأكيد",
        content: "هل انت متأكد من الخروج من الاختبار؟",
        confirmText: "الخروج",
        declineText: "إلغاء",
        confirmColor: Palette.RED,
        onConfirm: () {
          Navigator.pop(context, true);
        },
      ),
    );
  }

  Future<void> endExam(BuildContext context) async {
    await context.read<ExamController>().endExam(context).then((result) {
      Navigator.popAndPushNamed(
        context,
        Routes.ENROLLMENT_RESULT,
        arguments: [lesson, result],
      );
    });
  }
}
