import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/controllers/courses/enrollment/exam_controller.dart';
import '../../../../core/helpers/utils/app_snackbar.dart';
import '../../../../core/models/course_models/exam/question.dart';
import '../../../../core/models/course_models/lesson/lesson.dart';
import '../../../theme/palette.dart';

class LessonExamView extends StatelessWidget {
  final Lesson lesson;
  final ExamController controller;

  const LessonExamView(this.lesson, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      builder: (context, _) {
        final c = context.watch<ExamController>();
        var questions = c.questions;

        if (questions != null) {
          if (questions.isNotEmpty) {
            return Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 45.0,
                        bottom: 32.0,
                        right: 45.0,
                        left: 45.0,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 4.0,
                            width: double.infinity,
                            color: const Color(0xFFD9D9E8),
                          ),
                          LayoutBuilder(builder: (context, cons) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 800),
                              height: 4.0,
                              curve: Curves.easeInOutQuart,
                              width: (cons.maxWidth / questions.length) *
                                  (c.currentIndex + 1),
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFEE7D77),
                                      Color(0xFFFFABA7),
                                    ],
                                    stops: [0.5, 1.0],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF130A3B)
                                          .withOpacity(0.24),
                                      blurRadius: 4.0,
                                      offset: const Offset(0.0, 2.0),
                                    )
                                  ]),
                            );
                          }),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: c.pageController,
                        itemCount: questions.length,
                        physics: const ClampingScrollPhysics(),
                        onPageChanged: (index) => c.currentIndex = index,
                        itemBuilder: (context, index) {
                          var question = questions[index];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 45.0),
                                child: Text(
                                  (question.title ?? "").trimRight(),
                                  style: const TextStyle(
                                    color: Palette.BLACK,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 32.0,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  key: PageStorageKey(question.id),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  itemCount: question.choices?.length ?? 0,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return choiceButton(index, c, question);
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: c.previousPage,
                            child: Container(
                              height: 32.0,
                              width: 32.0,
                              decoration: BoxDecoration(
                                color: c.currentIndex - 1 < 0
                                    ? Palette.GRAY
                                    : const Color(0xFFEF817B),
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.navigate_next_rounded,
                                  textDirection: TextDirection.ltr,
                                  color: Palette.WHITE,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: c.nextPage,
                            child: Container(
                              height: 32.0,
                              width: 32.0,
                              decoration: BoxDecoration(
                                color: c.currentIndex + 1 >=
                                        (c.questions?.length ?? 0)
                                    ? Palette.GRAY
                                    : const Color(0xFFEF817B),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.navigate_before_rounded,
                                textDirection: TextDirection.ltr,
                                color: Palette.WHITE,
                                size: 32,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Builder(
                  builder: (context) {
                    if (c.examStatus != ExamStatus.None) {
                      return const IgnorePointer();
                    } else {
                      return Positioned.fill(
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200.withOpacity(0.5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "عند بدأ الاختبار لا يمكنكم الرجوع للمواد مره اخرى، يجب حل الاختبار أولاً.",
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        c.examStatus = ExamStatus.Started,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Palette.BLUE1,
                                    ),
                                    child: const Text(
                                      'بدأ الاختبار',
                                      style: TextStyle(color: Palette.WHITE),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("لا يوجد محتوى"),
            );
          }
        } else {
          return const Center(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget choiceButton(
    int index,
    ExamController c,
    Question question,
  ) {
    String? choiceText = question.choices?[index];
    bool isChosen = c.getChosenAnswer(question.id!) == choiceText;

    return GestureDetector(
      onTap: () async {
        c.setAnswer(question.id!, choiceText ?? "");
        await Future.delayed(const Duration(milliseconds: 500));
        c.nextPage();
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 45.0),
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 28.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          gradient: LinearGradient(
            colors: !isChosen
                ? const [
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                  ]
                : const [
                    Color(0xFFEC7872),
                    Color(0xFFF7948F),
                  ],
          ),
          boxShadow: [
            BoxShadow(
              color:
                  const Color(0xFF130A3B).withOpacity(isChosen ? 0.32 : 0.16),
              blurRadius: 32.0,
              offset: const Offset(0.0, 8.0),
            )
          ],
        ),
        child: Text(
          (choiceText ?? "").trim(),
          style: TextStyle(
            color: !isChosen ? const Color(0xFF2D2D3A) : Palette.WHITE,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
