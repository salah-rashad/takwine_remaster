import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/controllers/auth/auth_controller.dart';
import '../../../core/controllers/courses/courses_controller.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/models/app_tab.dart';
import '../../theme/palette.dart';
import '../../widgets/bottom_nav_bar/bottom_navbar.dart';
import 'tabs/courses_home_tab_view.dart';
import 'tabs/my_certificates_tab_view.dart';
import 'tabs/my_activity_tab_view.dart';

const List<AppTab> courses_tabs = [
  AppTab(
    title: "الدورات",
    colors: Palette.coursesHomeTabColors,
    icon: FontAwesomeIcons.graduationCap,
    page: CoursesHomeTabView(),
  ),
  AppTab(
    title: "نشاطي",
    colors: Palette.coursesMyActivityTabColors,
    icon: FontAwesomeIcons.barsProgress,
    page: MyActivityTabView(),
  ),
  AppTab(
    title: "شواهدي",
    colors: Palette.coursesMyCertificatesTabColors,
    icon: FontAwesomeIcons.medal,
    page: MyCertificatesTabView(),
  ),
  AppTab(
    title: "محفوظاتي",
    colors: Palette.coursesMyBookmarksTabColors,
    icon: FontAwesomeIcons.solidBookmark,
    page: Center(
      child: Text("AccountView"),
    ),
  ),
];

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = context.watch<AuthController>();

    return ChangeNotifierProvider(
        create: (context) => CoursesController(),
        builder: (context, widget) {
          var controller = context.watch<CoursesController>();
          return WillPopScope(
            onWillPop: () {
              if (controller.currentIndex == 0) {
                return Future.value(true);
              } else {
                controller.changeIndex(0);
                return Future.value(false);
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: !auth.isLoggedIn
                  ? homeTab(controller)
                  : Stack(
                      children: [
                        PageView.builder(
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (index) {
                            FocusScope.of(context).unfocus();
                            controller.currentIndex = index;
                            _refresh(index, controller, force: false);
                          },
                          controller: controller.pageController,
                          itemCount: courses_tabs.length,
                          itemBuilder: (context, index) {
                            return RefreshIndicator(
                              onRefresh: () => _refresh(index, controller),
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.only(
                                    bottom: 120.0 +
                                        (Platform.isIOS
                                            ? context.mediaQuery.padding.bottom
                                            : 0.0)),
                                child: courses_tabs[index].page,
                              ),
                            );
                          },
                        ),
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: BottomNavBar(
                            tabs: courses_tabs,
                          ),
                        )
                      ],
                    ),
            ),
          );
        });
  }

  Future<void> _refresh(int index, CoursesController controller,
      {bool force = true}) async {
    switch (index) {
      case 0:
        return controller.initHomeTab(force: force);
      case 1:
        return controller.initActivityTab(force: force);
      case 2:
        return controller.iniCertificatesTab(force: force);
      case 3:
        return controller.iniBookmarksTab(force: force);
      default:
        return Future.value();
    }
  }

  Widget homeTab(CoursesController controller) {
    return RefreshIndicator(
      onRefresh: () => controller.initHomeTab(force: true),
      child: const SingleChildScrollView(
        child: CoursesHomeTabView(),
      ),
    );
  }
}

class CustomScrollPhysics extends ScrollPhysics {}
