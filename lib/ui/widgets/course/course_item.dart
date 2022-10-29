import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/routes/routes.dart';
import '../../../core/helpers/utils/helpers.dart';
import '../../../core/helpers/utils/hex_color.dart';
import '../../../core/models/course_models/course/course.dart';
import '../../theme/palette.dart';

class CourseItem extends StatelessWidget {
  final Course course;

  Color get color => HexColor(course.category?.color ?? "");

  const CourseItem(this.course, {super.key});
  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: Stack(
            children: [
              Positioned.fill(
                child: course.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: course.imageUrl!,
                        fit: BoxFit.cover,
                        memCacheWidth: size.width.toInt(),
                        placeholder: (context, url) => placeholderImage(),
                        errorWidget: (context, url, error) =>
                            placeholderImage(),
                      )
                    : placeholderImage(),
              ),
              // Positioned.fill(child: Container(color: Palette.BLACK.withOpacity(0.16),)),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.SINGLE_COURSE,
                      arguments: course,
                    ),
                    splashColor: HexColor(course.category?.color ?? "")
                        .withOpacity(0.16),
                    highlightColor: HexColor(course.category?.color ?? "")
                        .withOpacity(0.16),
                  ),
                ),
              ),
              IgnorePointer(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (course.title).toString(),
                        style: const TextStyle(
                          color: Palette.WHITE,
                          fontSize: 18.0,
                          shadows: [
                            Shadow(
                              color: Palette.BLACK,
                              offset: Offset(0, 1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.0),
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                          (course.category?.title).toString(),
                          style: TextStyle(
                            color: getFontColorForBackground(color),
                            fontSize: 12.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget placeholderImage() {
    return Container(
      color: Palette.GRAY.withOpacity(0.7),
    );
  }
}
