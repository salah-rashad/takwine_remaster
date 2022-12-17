import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/controllers/courses/courses_controller.dart';
import '../../../core/models/app_tab.dart';
import '../../theme/palette.dart';
import '../tabs_wrapper.dart';
import 'tabs/courses_home_tab_view.dart';
import 'tabs/my_activity_tab_view.dart';
import 'tabs/my_certificates_tab_view.dart';
import 'tabs/my_course_bookmarks_tab_view.dart';

// List<AppTab> _navBarTabs(CoursesController controller) => ;

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabsWrapper<CoursesController>(
      controller: (context) => CoursesController(),
      tabs: (controller) {
        return [
          AppTab(
            title: "الدورات",
            colors: Palette.coursesHomeTabColors,
            icon: FontAwesomeIcons.graduationCap,
            page: (colors) => CoursesHomeTabView(colors),
            onRefresh: (force) => controller.initHomeTab(force: force),
          ),
          AppTab(
            title: "نشاطي",
            colors: Palette.coursesMyActivityTabColors,
            icon: FontAwesomeIcons.barsProgress,
            page: (colors) => MyActivityTabView(colors),
            onRefresh: (force) => controller.initActivityTab(force: force),
          ),
          AppTab(
            title: "شواهدي",
            colors: Palette.coursesMyCertificatesTabColors,
            icon: FontAwesomeIcons.medal,
            page: (colors) => MyCertificatesTabView(colors),
            onRefresh: (force) => controller.initCertificatesTab(force: force),
          ),
          AppTab(
            title: "محفوظاتي",
            colors: Palette.coursesMyBookmarksTabColors,
            icon: FontAwesomeIcons.solidBookmark,
            page: (colors) => MyCourseBookmarksTabView(colors),
            onRefresh: (force) => controller.initBookmarksTab(force: force),
          ),
        ];
      },
    );
  }
}
