import 'package:flutter/material.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/models/course_models/lesson/lesson.dart';
import '../../../../core/services/api_account.dart';
import '../../../theme/palette.dart';
import '../../../widgets/dialogs/celebration_dialog.dart';

class ExamResultScreen extends StatelessWidget {
  final Lesson lesson;
  final double result;
  const ExamResultScreen(
      {super.key, required this.lesson, required this.result});

  bool get isSuccessful => result >= 70.0;

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuery.size;

    return WillPopScope(
      onWillPop: () async {
        proceed(context);
        return false;
      },
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isSuccessful
                  ? const [Color(0xFF854B9F), Color(0xFF45145C)]
                  : const [Palette.RED, Palette.LIGHT_PINK],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Builder(
                    builder: (context) {
                      if (isSuccessful) {
                        return Image.asset("assets/images/gift_box.png");
                      } else {
                        return Icon(
                          Icons.not_interested_rounded,
                          color: Palette.RED,
                          size: size.width / 2,
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Text(
                  isSuccessful ? "نجحتم في الاختبار" : "لم تجتز الاختبار",
                  style: const TextStyle(color: Palette.WHITE, fontSize: 22.0),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  isSuccessful
                      ? "يمكنكم الآن الانتقال إلى التكوين الموالي"
                      : "عذراً، لا يمكنكم الانتقال إلى التكوين الموالي قبل نجاحكم في هذا الاختبار",
                  style: const TextStyle(color: Palette.WHITE, fontSize: 12.0),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: ElevatedButton.icon(
                        onPressed: () => proceed(context),
                        icon: const Icon(Icons.arrow_back_rounded),
                        clipBehavior: Clip.antiAlias,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: isSuccessful
                              ? const Color(0xFF6F3888)
                              : Palette.RED,
                          backgroundColor: Palette.WHITE,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 14.0),
                          child: Text(
                            "المتابعة",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void proceed(BuildContext context) async {
    await ApiAccount.getSingleEnrollment(lesson.course).then(
      (enrollment) {
        if (enrollment?.isComplete == true && isSuccessful) {
          Navigator.pop(
            context,
          );
          showDialog(
            context: context,
            builder: (context) => const CelebrationDialog(),
          );
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
}
