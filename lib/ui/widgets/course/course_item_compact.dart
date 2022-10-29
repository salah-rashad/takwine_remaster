import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../../../core/helpers/routes/routes.dart';
import '../../../core/helpers/utils/helpers.dart';
import '../../../core/helpers/utils/hex_color.dart';
import '../../../core/models/course_models/course/course.dart';
import '../../theme/palette.dart';

class CourseItemCompact extends StatelessWidget {
  final Course course;

  Color get color => HexColor(course.category?.color ?? "");

  const CourseItemCompact(this.course, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        color: Palette.WHITE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            Routes.SINGLE_COURSE,
            arguments: course,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 64,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.school_rounded,
                          color: getFontColorForBackground(color),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        course.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Palette.DARKER_TEXT_COLOR,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text.rich(
                        TextSpan(text: "مدة الدورة:  ", children: [
                          TextSpan(
                              text: "${course.days} يوم",
                              style: const TextStyle(color: Color(0xFFACAFB9)))
                        ]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11.0,
                          color: Palette.DARKER_TEXT_COLOR,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          SmoothStarRating(
                            rating: course.rate ?? 0,
                            // isReadOnly: true,
                            allowHalfRating: false,
                            size: 12.0,
                            color: const Color(0xFFFBB438),
                            borderColor: const Color(0xFFACAFB9),
                            defaultIconData: Icons.star,
                          ),
                          Text(
                            " (${course.rate ?? 0.0})",
                            style: const TextStyle(
                              color: Palette.DARKER_TEXT_COLOR,
                              fontSize: 12.0,
                              fontFamily: "",
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
