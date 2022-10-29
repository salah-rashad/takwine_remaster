import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/controllers/courses/courses_controller.dart';
import '../../../../core/controllers/courses/courses_search_controller.dart';
import '../../../../core/helpers/routes/routes.dart';
import '../../../../core/helpers/utils/go.dart';
import '../../../../core/models/course_models/course/course.dart';
import '../../../theme/palette.dart';
import '../../../widgets/course/course_item.dart';
import '../../../widgets/course/course_item_compact.dart';
import '../../../widgets/course/courses_settings_widget.dart';
import '../../../widgets/hello_user_widget.dart';
import '../../../widgets/shimmers/course_item_compact_shimmer.dart';
import '../../../widgets/shimmers/course_item_shimmer.dart';

class CoursesHomeTabView extends StatelessWidget {
  const CoursesHomeTabView({super.key});
  final List<CoursesSettingsWidget> coursesSettingsList = const [
    CoursesSettingsWidget(
      title: "98%",
      subtitle: "نسبة النجاح",
      colors: [Color(0xFF5B2974), Color(0xFF9F55C3)],
      image: "assets/images/analytics.png",
    ),
    CoursesSettingsWidget(
      title: "التميّز",
      subtitle: "دورات احترافية ومنهجية",
      colors: [Palette.ORANGE, Color(0xFFBC5A1E)],
      image: "assets/images/diamond.png",
    ),
    CoursesSettingsWidget(
      title: "المجانية",
      subtitle: "كل الدورات مجانية",
      colors: [Palette.LIGHT_TEAL, Palette.DARK_TEAL],
      image: "assets/images/box.png",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: Palette.coursesHomeTabColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // status bar height
                height: MediaQuery.of(context).padding.top,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: HelloUserWidget()),
                  Align(
                    widthFactor: 0.5,
                    child: ClipOval(
                      child: Material(
                        type: MaterialType.transparency,
                        child: IconButton(
                          onPressed: () => Go().backToRoot(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                          ),
                          padding: const EdgeInsets.all(0.0),
                          color: Palette.WHITE,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22.0),
              const Text(
                "ماذا تطمح أن تتعلم اليوم" "\n" "في منصة تكوين؟",
                style: TextStyle(color: Palette.WHITE, fontSize: 18.0),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 38.0,
                child: ChangeNotifierProvider(
                    create: (context) => CoursesSearchController(),
                    builder: (context, widget) {
                      final searchController =
                          context.read<CoursesSearchController>();

                      return TextField(
                        controller: searchController.searchTextCtrl,
                        // textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Palette.DARK_TEXT_COLOR,
                          fontSize: 12.0,
                        ),
                        onEditingComplete: () =>
                            search(context, searchController),
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30.0)),
                          filled: true,
                          fillColor: Palette.WHITE,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 24.0),
                          hintText: "ابحث هنا عن مواضيع تهمك ...",
                          hintStyle: const TextStyle(
                            color: Color(0xFFACAFB9),
                          ),
                          suffixIcon: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                            ),
                            child: Material(
                              color: Colors.white,
                              child: IconButton(
                                onPressed: () =>
                                    search(context, searchController),
                                icon: const Icon(
                                  Icons.search_rounded,
                                  color: Palette.BLACK,
                                ),
                                iconSize: 22.0,
                                tooltip: "بحث",
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: Selector<CoursesController, List<Course>?>(
            selector: (p0, p1) => p1.featuredCourses,
            builder: (context, courses, child) {
              if (courses != null) {
                return courses.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 22.0,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: courses.length,
                        itemBuilder: (context, i) {
                          return CourseItem(courses[i]);
                        },
                      )
                    : const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            "لا يوجد دورات متاحة.",
                            style: TextStyle(color: Palette.GRAY),
                          ),
                        ),
                      );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 22.0),
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (c, i) {
                    return const CourseItemShimmer();
                  },
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "خصائص الدورات",
                style:
                    TextStyle(color: Palette.DARKER_TEXT_COLOR, fontSize: 18.0),
              ),
              Icon(
                Icons.tune,
                size: 16.0,
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: coursesSettingsList,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 16.0, top: 16.0, bottom: 8.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "دورات قد تهمك",
              style:
                  TextStyle(color: Palette.DARKER_TEXT_COLOR, fontSize: 18.0),
            ),
          ),
        ),
        Selector<CoursesController, List<Course>?>(
          selector: (p0, p1) => p1.allCourses,
          builder: (context, courses, child) {
            if (courses != null) {
              courses.sort((a, b) => (b.rate ?? 0).compareTo(a.rate ?? 0));
              return courses.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: courses.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CourseItemCompact(courses[index]);
                      },
                    )
                  : const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          "لا يوجد دورات متاحة.",
                          style: TextStyle(color: Palette.GRAY),
                        ),
                      ),
                    );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return const CourseItemCompactShimmer();
                },
              );
            }
          },
        ),
      ],
    );
  }

  Future<void> search(
      BuildContext context, CoursesSearchController controller) async {
    if (controller.searchCtrlText.trim().isNotEmpty) {
      controller.updateSearch();
      FocusScope.of(context).unfocus();
      await Navigator.pushNamed(context, Routes.SEARCH_COURSES, arguments: controller);
    }
  }
}
