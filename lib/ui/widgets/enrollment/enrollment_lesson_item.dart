import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/models/course_models/lesson/lesson.dart';
import '../../theme/palette.dart';

class EnrollmentLessonItem extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onPressed;

  const EnrollmentLessonItem({
    super.key,
    required this.lesson,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
      child: Opacity(
        opacity: lesson.status == LessonStatus.Locked ? 0.4 : 1.0,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            gradient: LinearGradient(
              colors: lesson.status == LessonStatus.Complete
                  ? const [Color(0xFFFF5B7F), Color(0xFFFC9970)]
                  : const [Color(0xFFD2DBEC), Color(0xFFD2DBEC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Material(
            clipBehavior: Clip.antiAlias,
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onPressed,
              splashColor: Palette.BLACK.withOpacity(0.16),
              highlightColor: Palette.BLACK.withOpacity(0.16),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Container(
                      height: 45.0,
                      width: 45.0,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: const BoxDecoration(
                          color: Palette.WHITE, shape: BoxShape.circle),
                      child: Center(
                        child: lesson.status != LessonStatus.Locked
                            ? Image.asset(
                                lesson.status == LessonStatus.Complete
                                    ? "assets/images/lesson_complete.png"
                                    : "assets/images/lesson_in_progress.png",
                                fit: BoxFit.fitWidth,
                              )
                            : Icon(
                                Icons.lock_clock_outlined,
                                size: 22,
                                color: Palette.BABY_BLUE.withOpacity(0.3),
                              ),
                      ),
                    ),
                    const SizedBox(width: 32.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "التكوين ${(lesson.ordering ?? 0).toStringFormatted("00")}",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: lesson.status == LessonStatus.Complete
                                    ? Palette.WHITE
                                    : const Color(0xFF3A4C6E)),
                          ),
                          Text(
                            lesson.title ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10.0,
                              color: lesson.status == LessonStatus.Complete
                                  ? Palette.WHITE
                                  : const Color(0xFF3A4C6E),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "${lesson.days?.toStringFormatted("00")} أيام",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: lesson.status == LessonStatus.Complete
                            ? Palette.WHITE
                            : const Color(0xFF3A4C6E),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
