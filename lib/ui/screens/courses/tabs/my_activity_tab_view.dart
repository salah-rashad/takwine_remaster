import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/controllers/auth/auth_controller.dart';
import '../../../../core/controllers/courses/courses_controller.dart';
import '../../../../core/helpers/routes/routes.dart';
import '../../../../core/models/course_models/enrollment/enrollment.dart';
import '../../../../core/models/user_models/user_statements.dart';
import '../../../theme/palette.dart';
import '../../../widgets/dialogs/celebration_dialog.dart';
import '../../../widgets/enrollment/enrollment_item.dart';
import '../../../widgets/hello_user_widget.dart';
import '../../../widgets/login_required_widget.dart';
import '../../../widgets/shimmers/enrollment_item_shimmer.dart';

class MyActivityTabView extends StatelessWidget {
  const MyActivityTabView({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = context.watch<AuthController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: Palette.coursesMyActivityTabColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // represents the status bar height
                height: MediaQuery.of(context).padding.top,
              ),
              const HelloUserWidget(),
              const SizedBox(height: 22.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "النجاح سلالم لا تستطيع أن ترتقيها ويدك في جيبك",
                          style:
                              TextStyle(color: Palette.WHITE, fontSize: 18.0),
                        ),
                        // Text(
                        //   "لقد وصلت هذا الأسبوع إلى 80% من هدفك",
                        //   style: TextStyle(color: Palette.WHITE, fontSize: 14.0),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 32.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset("assets/images/characters_book.png"),
                  )
                ],
              ),
              const SizedBox(height: 64.0),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 64.0),
          child: Align(
            heightFactor: 0.0,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "إحصائياتي",
                      style: TextStyle(
                        color: Palette.DARKER_TEXT_COLOR,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "عدد الدورات المجتازة",
                                style: TextStyle(
                                  color: Palette.GRAY,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(height: 12.0),
                              Text(
                                "عدد الدورات قيد الاجتياز",
                                style: TextStyle(
                                  color: Palette.GRAY,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(height: 12.0),
                              Text(
                                "متوسط تقييماتي",
                                style: TextStyle(
                                  color: Palette.GRAY,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Selector<CoursesController, UserStatements?>(
                            selector: (p0, p1) => p1.statements,
                            builder: (context, statement, _) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    (statement?.completed?.toString()) ?? "--",
                                    style: const TextStyle(
                                      color: Palette.DARKER_TEXT_COLOR,
                                      fontSize: 14.0,
                                      fontFamily: "",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    (statement?.inProgress?.toString()) ?? "--",
                                    style: const TextStyle(
                                      color: Palette.DARKER_TEXT_COLOR,
                                      fontSize: 14.0,
                                      fontFamily: "",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 14.0),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xFFFBB438),
                                        size: 14,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        statement?.rate ?? "--",
                                        style: const TextStyle(
                                          color: Palette.DARKER_TEXT_COLOR,
                                          fontSize: 14.0,
                                          fontFamily: "",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32.0),
        const Padding(
          padding: EdgeInsets.only(right: 32.0, left: 32.0, bottom: 8.0),
          child: Text(
            "دوراتي الحالية",
            style: TextStyle(
              color: Palette.DARKER_TEXT_COLOR,
              fontSize: 18.0,
            ),
          ),
        ),
        Selector<CoursesController, List<Enrollment>?>(
          selector: (p0, p1) => p1.enrollments,
          builder: (context, enrollments, _) {
            return !auth.isLoggedIn
                ? const LoginRequiredWidget()
                : Builder(
                    builder: (context) {
                      if (enrollments != null) {
                        if (enrollments.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 32.0,
                              ),
                              child: Text(
                                "انت غير مسجَّل في أي دورة حالياً.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Palette.LIGHT_TEXT_COLOR,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          );
                        }

                        enrollments.sort((a, b) => a.id!.compareTo(b.id!));

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: enrollments.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var enrollment = enrollments[index];
                            return EnrollmentItem(
                              enrollment,
                              onPressed: () =>
                                  onPressedEnrollmentItem(context, enrollment),
                            );
                          },
                        );
                      } else {
                        return Column(
                          children:
                              List.filled(1, const EnrollmentItemShimmer()),
                        );
                      }
                    },
                  );
          },
        )
      ],
    );
  }

  Future<void> onPressedEnrollmentItem(
    BuildContext context,
    Enrollment enrollment,
  ) async {
    var celebrate = await Navigator.pushNamed(
      context,
      Routes.ENROLLMENT_LESSONS,
      arguments: enrollment,
    ).then(
      (value) {
        context.read<CoursesController>().initActivityTab();
        return value;
      },
    );

    if (celebrate == true) {
      showDialog(
        context: context,
        builder: (context) => const CelebrationDialog(),
      );
    }
  }
}
