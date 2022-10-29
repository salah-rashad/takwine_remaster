import 'package:flutter/material.dart';

import '../../../core/helpers/utils/hex_color.dart';
import '../../../core/models/course_models/enrollment/enrollment.dart';
import '../../theme/palette.dart';

class EnrollmentItem extends StatelessWidget {
  final Enrollment enrollment;
  final VoidCallback onPressed;

  const EnrollmentItem(
    this.enrollment, {
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        color: Palette.WHITE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: onPressed,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22.0),
            child: Row(
              children: [
                SizedBox(
                  height: 64,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color:
                            HexColor(enrollment.course?.category?.color ?? ""),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Center(
                          // child: SvgPicture.network(
                          //   ApiURLs.HOST_URL +
                          //       "/assets/images/" +
                          //       HexColor(course?.course?.category?.color ?? "")
                          //           .toString() +
                          //       ".svg",
                          // ),
                          ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (enrollment.course?.title).toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Palette.DARKER_TEXT_COLOR,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: "الفصل الحالي:  ",
                          children: [
                            TextSpan(
                              text: enrollment.currentLesson?.title,
                              style: const TextStyle(color: Color(0xFFACAFB9)),
                            )
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Palette.DARKER_TEXT_COLOR,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${enrollment.progress ?? 0}%",
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Color(0xFFFBB438),
                            fontFamily: "",
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Stack(
                        children: [
                          Container(
                            height: 4.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCE0EC),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          TweenAnimationBuilder<double>(
                            tween: Tween(
                              begin: 0.0,
                              end: enrollment.progress?.toDouble() ?? 0.0,
                            ),
                            curve: Curves.easeOutCubic,
                            duration: const Duration(seconds: 2),
                            builder: (context, value, child) {
                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  return Container(
                                    height: 4.0,
                                    width: (constraints.maxWidth * value) / 100,
                                    // duration:
                                    //     Duration(milliseconds: 1200),
                                    decoration: BoxDecoration(
                                      color: HexColor(
                                        enrollment.course?.category?.color ??
                                            "",
                                      ),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        ],
                      )
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
