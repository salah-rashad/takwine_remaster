import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../core/controllers/courses/enrollment/enrollment_lessons_controller.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/routes/routes.dart';
import '../../../../core/helpers/utils/connectivity.dart';
import '../../../../core/helpers/utils/hex_color.dart';
import '../../../../core/models/course_models/enrollment/enrollment.dart';
import '../../../../core/models/course_models/lesson/lesson.dart';
import '../../../theme/palette.dart';
import '../../../widgets/circular_bordered_image.dart';
import '../../../widgets/dialogs/loading_dialog.dart';
import '../../../widgets/enrollment/enrollment_lesson_item.dart';
import '../../../widgets/shimmers/course_lesson_item_shimmer.dart';

class EnrollmentLessonsScreen extends StatelessWidget {
  final Enrollment enrollment;
  const EnrollmentLessonsScreen({super.key, required this.enrollment});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EnrollmentLessonsController(enrollment),
      builder: (context, _) {
        var controller = context.watch<EnrollmentLessonsController>();
        return Scaffold(
          backgroundColor: Palette.BACKGROUND,
          body: Column(
            children: [
              topPanel(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            right: 32.0, top: 32.0, bottom: 8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "تكوينات الدورة",
                            style: TextStyle(
                                color: Palette.DARKER_TEXT_COLOR,
                                fontSize: 18.0),
                          ),
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          var lessons = controller.lessons;
                          if (lessons == null) {
                            return Column(
                              children: List.filled(
                                3,
                                const CourseLessonItemShimmer(),
                              ),
                            );
                          } else {
                            if (lessons.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    "لا يوجد بيانات.",
                                    style: TextStyle(color: Palette.GRAY),
                                  ),
                                ),
                              );
                            } else {
                              lessons.sort((a, b) =>
                                  (a.ordering ?? 0).compareTo(b.ordering ?? 0));

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: lessons.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var lesson = lessons[index];

                                  var enabled = lessons[index].status !=
                                      LessonStatus.Locked;

                                  return EnrollmentLessonItem(
                                    lesson: lesson,
                                    onPressed: () => onLessonItemPressed(
                                      context,
                                      lesson,
                                      index,
                                      isEnabled: enabled,
                                      controller: controller,
                                    ),
                                  );
                                },
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget topPanel(BuildContext context) {
    var size = context.mediaQuery.size;
    return Container(
      decoration: const BoxDecoration(
        color: Palette.BLUE1,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // status bar height
            height: MediaQuery.of(context).padding.top + 16.0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32.0, left: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ClipOval(
                //   child: Material(
                //     color: Colors.transparent,
                //     child: IconButton(
                //       onPressed: () {},
                //       icon: const Icon(Icons.notifications_none),
                //       padding: const EdgeInsets.all(0.0),
                //       color: Palette.WHITE,
                //       iconSize: 18.0,
                //     ),
                //   ),
                // ),
                const Expanded(
                  child: Text(
                    "دوراتي",
                    style: TextStyle(color: Palette.WHITE, fontSize: 18.0),
                    textAlign: TextAlign.start,
                  ),
                ),
                ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        textDirection: TextDirection.ltr,
                      ),
                      iconSize: 18.0,
                      color: Palette.WHITE,
                      padding: const EdgeInsets.all(0.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              children: [
                CircularBorderedImage(
                  imageUrl: enrollment.course?.imageUrl,
                  spaceBetween: 6.0,
                  size: 60.0,
                ),
                const SizedBox(
                  width: 32.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        enrollment.course?.title ?? "",
                        style: const TextStyle(
                            color: Palette.WHITE, fontSize: 22.0),
                      ),
                      const SizedBox(height: 4.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        decoration: BoxDecoration(
                            color: HexColor(
                                enrollment.course?.category?.color ?? ""),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                          enrollment.course?.category?.title ?? "",
                          style: const TextStyle(
                            color: Palette.WHITE,
                            fontSize: 10.0,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Divider(
            height: 0,
            color: Palette.WHITE,
            indent: size.width / 3,
            endIndent: size.width / 3,
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              enrollment.course?.description?.trimRight() ?? "",
              style: const TextStyle(fontSize: 12.0, color: Palette.WHITE),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Future<void> onLessonItemPressed(
    BuildContext context,
    Lesson lesson,
    int index, {
    required bool isEnabled,
    required EnrollmentLessonsController controller,
  }) async {
    if (isEnabled) {
      await Navigator.pushNamed(
        context,
        Routes.ENROLLMENT_MATERIALS,
        arguments: lesson,
      ).then((value) async {
        if (await Connectivity.isInternetConnected()) {
          showLoadingDialog(context);

          await controller.initialize().then((value) => Navigator.pop(context));
        }
      });
    } else {
      Fluttertoast.showToast(msg: "يجب اجتياز التكوينات السابقة أولاً");
      return;
    }
  }
}
