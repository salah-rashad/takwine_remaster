import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../core/controllers/auth/auth_controller.dart';
import '../../../core/controllers/tabs_controller.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/routes/routes.dart';
import '../../../core/models/app_tab.dart';
import '../../../core/models/course_models/enrollment/enrollment.dart';
import '../../theme/palette.dart';
import 'bottom_navbar_icon.dart';

class BottomNavBar<T extends TabsController> extends StatelessWidget {
  final List<AppTab> tabs;
  const BottomNavBar({super.key, required this.tabs});

  bool get isEven => tabs.length % 2 == 0;

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<T>();

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        PhysicalShape(
          color: Palette.WHITE,
          elevation: 16.0,
          shadowColor: Palette.primaryShadow12,
          clipper: TabClipper(radius: isEven ? 38.0 : 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: List.generate(
                    isEven ? tabs.length + 1 : tabs.length,
                    (index) {
                      if (isEven) {
                        var center = (tabs.length / 2).round();
                        if (index == center) {
                          return const SizedBox(width: 64.0);
                        }

                        if (index > center) index--;
                      }

                      final item = tabs[index];
                      return Expanded(
                        child: NavBarIcon(
                          onPressed: () => controller.changePage(index),
                          selected: controller.currentIndex == index,
                          title: item.title,
                          icon: item.icon,
                          color: item.colors[0],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: context.mediaQuery.padding.bottom,
              )
            ],
          ),
        ),
        if (isEven) navButton(context, tabs[controller.currentIndex].colors),
      ],
    );
  }

  Widget navButton(BuildContext context, List<Color> colors) {
    return Selector<AuthController, Enrollment?>(
      selector: (p0, p1) => p1.lastActivity,
      builder: (context, lastActivity, _) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: 44.0 +
                (Platform.isIOS ? context.mediaQuery.padding.bottom : 0.0),
          ),
          child: Container(
            color: Colors.transparent,
            child: SizedBox(
              width: 38 * 2,
              height: 38 * 2,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Tooltip(
                    message:
                        "الاستمرار من حيث توقفت: ${lastActivity?.currentLesson?.title}",
                    preferBelow: false,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    enableFeedback: true,
                    child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: colors,
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Palette.BLACK.withOpacity(0.16),
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onTap: lastActivity == null
                                ? null
                                : () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.ENROLLMENT_LESSONS,
                                      arguments: lastActivity,
                                    );
                                  },
                            onLongPress: lastActivity == null
                                ? null
                                : () {
                                    Fluttertoast.showToast(
                                      msg: "${lastActivity.course?.title}",
                                      gravity: ToastGravity.CENTER,
                                    );
                                  },
                            child: const Icon(
                              Icons.near_me,
                              color: Palette.WHITE,
                              size: 32,
                            ),
                          ),
                        )),
                  )),
            ),
          ),
        );
      },
    );
  }
}

class TabClipper extends CustomClipper<Path> {
  TabClipper({this.radius = 38.0});

  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();

    final double v = radius * 2;
    path.lineTo(0, 0);
    // path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
    //     degreeToRadians(90), false);
    path.arcTo(
        Rect.fromLTWH(
            ((size.width / 2) - v / 2) - radius + v * 0.04, 0, radius, radius),
        degreeToRadians(270),
        degreeToRadians(70),
        false);

    path.arcTo(Rect.fromLTWH((size.width / 2) - v / 2, -v / 2, v, v),
        degreeToRadians(160), degreeToRadians(-140), false);

    path.arcTo(
        Rect.fromLTWH((size.width - ((size.width / 2) - v / 2)) - v * 0.04, 0,
            radius, radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false);
    // path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
    //     degreeToRadians(270), degreeToRadians(90), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    final double radian = (math.pi / 180) * degree;
    return radian;
  }
}
