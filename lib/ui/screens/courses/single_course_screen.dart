import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../../../core/controllers/auth/auth_controller.dart';
import '../../../core/controllers/courses/single_course_controller.dart';
import '../../../core/controllers/file_controller.dart';
import '../../../core/helpers/routes/routes.dart';
import '../../../core/helpers/utils/helpers.dart';
import '../../../core/helpers/utils/hex_color.dart';
import '../../../core/models/course_models/course/course.dart';
import '../../../core/models/course_models/enrollment/enrollment.dart';
import '../../../core/models/course_models/lesson/lesson.dart';
import '../../theme/palette.dart';
import '../../widgets/course/course_lesson_expansion_item.dart';
import '../../widgets/dialogs/auth_dialog.dart';
import '../../widgets/shimmers/course_lesson_expansion_item_shimmer.dart';

class SingleCourseScreen extends StatelessWidget {
  final Course course;
  const SingleCourseScreen({super.key, required this.course});

  Color get color => HexColor(course.category?.color ?? "");

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
                                  Hero(
                                    tag: "course-category-chip",
                                    transitionOnUserGestures: true,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                          color: color,
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      child: Text(
                                        (course.category?.title).toString(),
                                        style: TextStyle(
                                          color:
                                              getFontColorForBackground(color),
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Selector<SingleCourseController, Enrollment?>(
                              selector: (p0, p1) => p1.enrollment,
                              builder: enrollButton,
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
                              convertDateTimeFormat(course.date ?? ""),
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
                            ChangeNotifierProvider(
                              create: (context) => FileController(
                                context,
                                fileUrl: course.pdfUrl,
                                saveName: context
                                    .read<SingleCourseController>()
                                    .pdfName,
                              ),
                              builder: (context, widget) {
                                var file = context.watch<FileController>();

                                bool urlIsNull = course.pdfUrl == null;
                                bool done = file.status == DownloadStatus.done;
                                bool downloading =
                                    file.status == DownloadStatus.downloading;

                                return ElevatedButton.icon(
                                  onPressed: urlIsNull || downloading
                                      ? null
                                      : done
                                          ? () => file.openFile()
                                          : () => file.downloadFile(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: urlIsNull || downloading
                                        ? Palette.GRAY
                                        : Palette.YELLOW,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
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
                                );
                              },
                            ),
                            const SizedBox(width: 8.0),
                            ElevatedButton.icon(
                              onPressed: course.videoUrl == null
                                  ? null
                                  : () => launchURL(course.videoUrl!),
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
                  /* Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "البحث في المجالات",
                          style: TextStyle(
                            color: Palette.DARKER_TEXT_COLOR,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        FutureBuilder<List<CourseCategory>?>(
                          future: APIService.courses.getCourseCategories(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var categories = snapshot.data!;

                              List<Widget> chips = [];

                              categories.forEach(
                                (category) => chips.add(
                                  GestureDetector(
                                    onTap: () => Get.toNamed(
                                      Routes.COURSE_BY_CATEGORY,
                                      arguments: category,
                                    ),
                                    child: Chip(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      label: Text(
                                        category.title!,
                                        style: TextStyle(
                                          color: Palette.WHITE,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      backgroundColor: HexColor(category.color!),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                    ),
                                  ),
                                ),
                              );

                              return Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: chips,
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ), */
                ],
              ),
            ),
          );
        });
  }

  Widget imagePlaceholder() {
    return Container(
      color: Palette.WHITE.withOpacity(0.7),
    );
  }

  Widget topPanel(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: ClipRRect(
        borderRadius:
            const BorderRadius.only(bottomRight: Radius.circular(40.0)),
        child: Stack(
          children: [
            Positioned.fill(
              child: course.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: course.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => imagePlaceholder(),
                      errorWidget: (context, url, error) => imagePlaceholder(),
                    )
                  : imagePlaceholder(),
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
                      TextButton.icon(
                        onPressed: () {},
                        label: const Text("حفظ"),
                        icon: const Icon(
                          Icons.bookmark_border_rounded,
                          textDirection: TextDirection.ltr,
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Palette.WHITE,
                        ),
                        // color: Palette.WHITE,
                      ),
                      Expanded(
                        child: Container(),
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
                      borderRadius: BorderRadius.circular(30.0),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(30.0),
                        child: const SizedBox(
                          height: 45.0,
                          width: 45.0,
                          child: Center(
                            child: SizedBox(
                              height: 22.0,
                              width: 22.0,
                              // child: SvgPicture.network(
                              //   ApiURLs.HOST_URL +
                              //       "/assets/images/" +
                              //       (course.category?.color ??
                              //           "") +
                              //       ".svg",
                              // ),
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

  Widget enrollButton(
    BuildContext context,
    Enrollment? enrollment,
    Widget? widget,
  ) {
    var auth = context.watch<AuthController>();
    var controller = context.read<SingleCourseController>();

    String label;
    IconData icon;
    String hint;
    Color color;
    VoidCallback? onPressed;

    if (!auth.isLoggedIn) {
      label = "سجّل بالدورة";
      hint = "رسوم الدورة: مجانًا";
      icon = Icons.add_rounded;
      color = Palette.YELLOW;
      onPressed = () => showDialog<bool>(
            context: context,
            builder: (context) => const AuthDialog(),
          ).then((value) => controller.initEnrollment());
    } else {
      if (enrollment != null) {
        if (enrollment.currentLesson != null) {
          label = "أكمل الدورة";
          hint = "${enrollment.progress}% مكتمل";
          icon = Icons.play_arrow_rounded;
          color = Palette.BLUE1;
          onPressed = () => Navigator.pushNamed(
                context,
                Routes.ENROLLMENT_LESSONS,
                arguments: enrollment,
              );
        } else {
          label = "بدأ الدورة";
          hint = "تم تسجيلك بالدورة";
          icon = Icons.play_arrow_rounded;
          color = Palette.BLUE1;
          onPressed = () => Navigator.pushNamed(
                context,
                Routes.ENROLLMENT_LESSONS,
                arguments: enrollment,
              );
        }
      } else {
        label = "سجّل بالدورة";
        hint = "رسوم الدورة: مجانًا";
        icon = Icons.add_rounded;
        color = Palette.YELLOW;
        onPressed = context.read<SingleCourseController>().enroll;
      }
    }

    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: onPressed,
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
