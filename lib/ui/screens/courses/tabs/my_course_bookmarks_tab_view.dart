import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/controllers/auth/auth_controller.dart';
import '../../../../core/controllers/courses/courses_controller.dart';
import '../../../../core/models/course_models/course_bookmark.dart';
import '../../../../core/services/api_account.dart';
import '../../../theme/palette.dart';
import '../../../widgets/course/course_item_compact.dart';
import '../../../widgets/dialogs/general_dialog.dart';
import '../../../widgets/login_required_widget.dart';
import '../../../widgets/shimmers/certificate_item_shimmer.dart';
import '../../../widgets/user_widget.dart';

class MyCourseBookmarksTabView extends StatelessWidget {
  final List<Color> colors;
  const MyCourseBookmarksTabView(this.colors, {super.key});

  @override
  Widget build(BuildContext context) {
    var auth = context.watch<AuthController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // represents the status bar height
                height: MediaQuery.of(context).padding.top,
              ),
              const UserWidget(),
              const SizedBox(height: 22.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "محفوظاتي",
                          style:
                              TextStyle(color: Palette.WHITE, fontSize: 22.0),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "يمكن الضغط مطولاً على أي عنصر لإزالته من القائمة.",
                          style: TextStyle(
                            color: Palette.WHITE.withOpacity(0.7),
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 32.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset("assets/images/characters_book.png"),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Selector<CoursesController, List<CourseBookmark>?>(
            selector: (p0, p1) => p1.bookmarks,
            builder: (context, bookmarks, _) {
              return !auth.isLoggedIn
                  ? const LoginRequiredWidget()
                  : Builder(
                      builder: (context) {
                        if (bookmarks != null) {
                          if (bookmarks.isEmpty) {
                            return const Center(
                              child: Text(
                                "ليس لديك دورات محفوظة.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Palette.LIGHT_TEXT_COLOR,
                                  fontSize: 14.0,
                                ),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: bookmarks.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var bookmark = bookmarks[index];
                                return GestureDetector(
                                  onLongPress: () =>
                                      removeBookmarkDialog(context, bookmark),
                                  child: CourseItemCompact(bookmark.course!),
                                );
                              },
                            );
                          }
                        } else {
                          return Column(
                            children:
                                List.filled(3, const CertificateItemShimmer()),
                          );
                        }
                      },
                    );
            },
          ),
        )
      ],
    );
  }

  Future<void> removeBookmarkDialog(
      BuildContext context, CourseBookmark bookmark) {
    var controller = context.read<CoursesController>();

    return showDialog(
      context: context,
      builder: (context) {
        return GeneralDialog(
          context,
          title: "تأكيد",
          content: "إزالة هذه الدورة من المحفوظات؟",
          confirmText: "نعم",
          declineText: "لا",
          onConfirm: () async {
            await ApiAccount.removeCourseBookmark(bookmark.course?.id);
            controller.initBookmarksTab(force: true);
          },
        );
      },
    );
  }
}
