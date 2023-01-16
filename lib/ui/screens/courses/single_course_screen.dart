import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../../../core/controllers/auth/auth_controller.dart';
import '../../../core/controllers/courses/single_course_controller.dart';
import '../../../core/controllers/file_controller.dart';
import '../../../core/helpers/constants/font_awesome_icons.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/routes/routes.dart';
import '../../../core/helpers/utils/helpers.dart';
import '../../../core/helpers/utils/hex_color.dart';
import '../../../core/models/course_models/course/course.dart';
import '../../../core/models/course_models/enrollment/enrollment.dart';
import '../../../core/models/course_models/lesson/lesson.dart';
import '../../theme/palette.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/course/course_lesson_expansion_item.dart';
import '../../widgets/cover_image.dart';
import '../../widgets/dialogs/auth_dialog.dart';
import '../../widgets/shimmers/course_lesson_expansion_item_shimmer.dart';

class SingleCourseScreen extends StatelessWidget {
  final Course course;
  const SingleCourseScreen({super.key, required this.course});

  Color get color => HexColor(course.category?.color ?? "");
  String get fileName => "دليل دورة: ${course.title}";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SingleCourseController(course),
        builder: (context, widget) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topPanel(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (course.title).toString(),
                                    style: const TextStyle(
                                      color: Palette.DARKER_TEXT_COLOR,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  CategoryChip(
                                    backgroundColor: color,
                                    label: Text(
                                        (course.category?.title).toString()),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Selector<SingleCourseController, Enrollment?>(
                              selector: (p0, p1) => p1.enrollment,
                              builder: (context, enrollment, _) =>
                                  enrollButton(context, enrollment),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 12.0,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              formatDate(course.date ?? ""),
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Palette.DARKER_TEXT_COLOR,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            InkWell(
                              onTap: () {},
                              // onTap: () => Navigator.pushNamed(
                              //   context,
                              //   Routes.COURSE_RATINGS,
                              //   arguments: course.id,
                              // ),
                              child: Row(
                                children: [
                                  Text(
                                    " (${course.rate ?? 0.0})",
                                    style: const TextStyle(
                                        color: Palette.DARKER_TEXT_COLOR,
                                        fontSize: 12.0,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SmoothStarRating(
                                    rating: course.rate ?? 0.0,
                                    size: 12.0,
                                    color: const Color(0xFFFBB438),
                                    borderColor: const Color(0xFFACAFB9),
                                    defaultIconData: Icons.star,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Icon(
                              Icons.people_alt_outlined,
                              size: 12.0,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              "${course.totalEnrollments} مسجلين حالياً",
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Palette.GRAY,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Icon(
                              Icons.timeline,
                              size: 12.0,
                              color: Palette.DARKER_TEXT_COLOR,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              "${course.days ?? ""} يوم",
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Palette.GRAY,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Icon(
                              Icons.folder_open_outlined,
                              size: 12.0,
                              color: Palette.DARKER_TEXT_COLOR,
                            ),
                            const SizedBox(width: 8.0),
                            Selector<SingleCourseController, List<Lesson>?>(
                                selector: (p0, p1) => p1.lessons,
                                builder: (context, lessons, _) {
                                  return Text(
                                    "${(lessons?.length) ?? "..."} تكوينات",
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Palette.GRAY,
                                    ),
                                  );
                                }),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            if (course.guideFile != null)
                              ChangeNotifierProvider(
                                create: (context) => FileController(
                                  context,
                                  file: course.guideFile!,
                                  saveName: fileName,
                                ),
                                builder: (context, widget) {
                                  var file = context.watch<FileController>();

                                  bool urlIsNull = course.guideFile == null;
                                  bool done =
                                      file.status == DownloadStatus.done;
                                  bool downloading =
                                      file.status == DownloadStatus.downloading;

                                  if (urlIsNull) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: ElevatedButton.icon(
                                        onPressed: downloading
                                            ? null
                                            : done
                                                ? () => file.openFile()
                                                : () => file.downloadFile(),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              urlIsNull || downloading
                                                  ? Palette.GRAY
                                                  : Palette.YELLOW,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        label: Text(
                                          downloading
                                              ? "يتم التحميل (${file.progress}%)"
                                              : "دليل الدورة",
                                          style: const TextStyle(
                                            color: Palette.DARKER_TEXT_COLOR,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        icon: Icon(
                                          done
                                              ? Icons.menu_book_rounded
                                              : Icons.download_rounded,
                                          size: 14.0,
                                          textDirection: TextDirection.ltr,
                                          color: Palette.DARKER_TEXT_COLOR,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            if (course.videoUrl != null)
                              ElevatedButton.icon(
                                onPressed: () => launchURL(course.videoUrl!),
                                clipBehavior: Clip.antiAlias,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Palette.BLUE1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                label: const Text(
                                  "مشاهدة المختصر",
                                  style: TextStyle(
                                    color: Palette.WHITE,
                                    fontSize: 12.0,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.play_circle_fill_rounded,
                                  size: 14.0,
                                  color: Palette.WHITE,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          "عن الدورة",
                          style: TextStyle(
                            color: Palette.DARKER_TEXT_COLOR,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        ReadMoreText(
                          course.description ?? "",
                          style: const TextStyle(
                            color: Palette.GRAY,
                            fontSize: 12.0,
                          ),
                          trimMode: TrimMode.Line,
                          trimLines: 5,
                          trimExpandedText: " << أقل",
                          trimCollapsedText: "...المزيد >>",
                          colorClickableText: Palette.BLUE1.withOpacity(0.40),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          "التكوينات",
                          style: TextStyle(
                            color: Palette.DARKER_TEXT_COLOR,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Selector<SingleCourseController, List<Lesson>?>(
                    selector: (p0, p1) => p1.lessons,
                    builder: (context, lessons, _) {
                      if (lessons != null) {
                        if (lessons.isNotEmpty) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: lessons.length,
                            itemBuilder: (context, i) {
                              return CourseLessonExpansionItem(lessons[i]);
                            },
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return CourseLessonExpansionItemShimmer(
                              color: HexColor(course.category?.color ?? ""),
                            );
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          );
        });
  }

  Widget topPanel(BuildContext context) {
    var size = context.mediaQuery.size;

    return AspectRatio(
      aspectRatio: 4 / 3,
      child: ClipRRect(
        borderRadius:
            const BorderRadius.only(bottomRight: Radius.circular(40.0)),
        child: Stack(
          children: [
            Positioned.fill(
              child: CoverImage(
                url: course.imageUrl,
                memCacheWidth: (size.width * 2).toInt(),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 56 * 2,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Palette.BLACK,
                      Colors.transparent,
                    ],
                    stops: [
                      0.0,
                      1.0,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Consumer<SingleCourseController>(
                          builder: (context, controller, _) {
                        return TextButton.icon(
                          onPressed: onBookmarkPressed(context, controller),
                          label: Text(
                            controller.isBookmarked ? "تم الحفظ" : "حفظ",
                          ),
                          icon: Icon(
                            controller.isBookmarked
                                ? Icons.bookmark_added_rounded
                                : Icons.bookmark_add_outlined,
                            textDirection: TextDirection.ltr,
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: Palette.WHITE,
                          ),
                          // color: Palette.WHITE,
                        );
                      }),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                        ),
                        color: Palette.WHITE,
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Material(
                      color: HexColor(course.category?.color ?? ""),
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(30.0),
                      child: SizedBox(
                        height: 45.0,
                        width: 45.0,
                        child: Center(
                          child: SizedBox(
                            height: 22.0,
                            width: 22.0,
                            child: Icon(
                              getFontAwesomeIcon(course.category?.icon),
                              color: getFontColorForBackground(color),
                              size: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  VoidCallback? onBookmarkPressed(
      BuildContext context, SingleCourseController controller) {
    var auth = context.watch<AuthController>();
    if (auth.isLoggedIn) {
      if (controller.bookmark == null) {
        return null;
      } else {
        return controller.toggleBookmark;
      }
    } else {
      return () {
        showDialog<bool>(
          context: context,
          builder: (context) => const AuthDialog(),
        ).then((value) => controller.initialize());
      };
    }
  }

  Widget enrollButton(
    BuildContext context,
    Enrollment? enrollment,
  ) {
    var auth = context.watch<AuthController>();
    var controller = context.read<SingleCourseController>();

    String label = "سجّل بالدورة";
    String hint = "رسوم الدورة: مجانًا";
    IconData icon = Icons.add_rounded;
    Color color = Palette.YELLOW;
    VoidCallback? onPressed;

    if (!auth.isLoggedIn) {
      onPressed = () {
        showDialog<bool>(
          context: context,
          builder: (context) => const AuthDialog(),
        ).then((value) => controller.initialize());
      };
    } else {
      if (enrollment == null) {
        onPressed = () => controller.enroll();
      } else {
        label = "فتح الدورة";
        hint = "${enrollment.progress}% مكتمل";
        icon = Icons.play_arrow_rounded;
        color = Palette.BLUE2;
        onPressed = () {
          Navigator.pushNamed(
            context,
            Routes.ENROLLMENT_LESSONS,
            arguments: enrollment,
          );
        };
      }
    }

    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: onPressed,
          clipBehavior: Clip.antiAlias,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          label: Text(
            label,
            style: TextStyle(
              color: getFontColorForBackground(color),
              fontSize: 12.0,
            ),
          ),
          icon: Icon(
            icon,
            color: getFontColorForBackground(color),
          ),
        ),
        const SizedBox(width: 16.0),
        Column(
          children: [
            const SizedBox(
              height: 4.0,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 120,
              ),
              child: Text(
                hint,
                style: const TextStyle(color: Palette.GRAY, fontSize: 11.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ],
    );
  }
}
