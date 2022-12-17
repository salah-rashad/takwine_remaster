import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:flutter/material.dart';

import '../../../core/models/course_models/lesson/lesson.dart';
import '../../theme/palette.dart';
import '../../../core/helpers/extensions.dart';

class CourseLessonExpansionItem extends StatelessWidget {
  final Lesson lesson;
  const CourseLessonExpansionItem(this.lesson, {super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Palette.WHITE,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ConfigurableExpansionTile(
          header: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "التكوين ${(lesson.ordering ?? 0).toStringFormatted("00")}:",
                  style: const TextStyle(
                    color: Palette.BLUE1,
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  (lesson.title).toString(),
                  style: const TextStyle(
                    color: Palette.DARKER_TEXT_COLOR,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          animatedWidgetFollowingHeader:
              const Icon(Icons.keyboard_arrow_down_rounded),
          childrenBody: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8.0),
              Text(
                (lesson.description).toString().trim(),
                style: const TextStyle(
                  color: Palette.GRAY,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
