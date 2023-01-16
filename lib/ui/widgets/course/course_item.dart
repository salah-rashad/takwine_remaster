import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/constants/font_awesome_icons.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/routes/routes.dart';
import '../../../core/helpers/utils/helpers.dart';
import '../../../core/helpers/utils/hex_color.dart';
import '../../../core/models/course_models/course/course.dart';
import '../../theme/palette.dart';
import '../category_chip.dart';
import '../cover_image.dart';

class CourseItem extends StatelessWidget {
  final Course course;

  Color get color => HexColor(course.category?.color ?? "");

  const CourseItem(this.course, {super.key});
  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Stack(
          children: [
            Positioned.fill(
              child: CoverImage(
                url: course.imageUrl,
                fit: BoxFit.cover,
                memCacheWidth: size.width.toInt(),
              ),
            ),
            Positioned.fill(
                child: Container(
              color: Palette.BLACK.withOpacity(0.16),
            )),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.SINGLE_COURSE,
                    arguments: course,
                  ),
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
                    AutoSizeText(
                      (course.title).toString(),
                      maxLines: 3,
                      maxFontSize: 18.0,
                      minFontSize: 14.0,
                      overflow: TextOverflow.ellipsis,
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
                    CategoryChip(
                      backgroundColor: color,
                      label: Text((course.category?.title).toString()),
                      avatar: Icon(
                        getFontAwesomeIcon(course.category?.icon),
                        color: getFontColorForBackground(color),
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
