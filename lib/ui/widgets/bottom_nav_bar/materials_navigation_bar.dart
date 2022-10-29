import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/controllers/courses/enrollment/materials_controller.dart';
import '../../../core/controllers/courses/enrollment/exam_controller.dart';
import '../../../core/helpers/routes/routes.dart';
import '../../theme/palette.dart';
import '../material_step_item.dart';

class MaterialsNavBar extends StatelessWidget {
  final MaterialsController controller;
  final ExamController examController;

  final stepItemSize = 28.0;
  final stepSpacing = 16.0;
  final fabSize = 32.0;
  final navHeight = 64.0;

  const MaterialsNavBar({
    super.key,
    required this.controller,
    required this.examController,
  });

  Color get buttonColor {
    if (controller.isExam && examController.examStatus != ExamStatus.Complete) {
      return Palette.GRAY;
    } else {
      return Palette.BLUE1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: controller,
        builder: (context, _) {
          return Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: <Widget>[
              PhysicalShape(
                color: Palette.WHITE,
                elevation: 16.0,
                shadowColor: const Color(0xFFD2D2D2),
                clipper: TabClipper(radius: 32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: navHeight,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification: (notification) {
                                notification.disallowIndicator();
                                return true;
                              },
                              child: SingleChildScrollView(
                                controller: controller.scrollController,
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      right: 16,
                                      left: 16,
                                      child: Container(
                                        height: 1.0,
                                        width: double.infinity,
                                        color: const Color(0xFFB0B3C0),
                                        child: const Divider(
                                          thickness: 1,
                                        ),
                                      ),
                                    ),
                                    Builder(builder: (context) {
                                      var size = stepSpacing + stepItemSize;
                                      var begin = max<double>(0,
                                          (controller.currentIndex - 1) * size);
                                      var end =
                                          (controller.currentIndex) * size;

                                      return Positioned(
                                        right: 16.0,
                                        child: TweenAnimationBuilder<double>(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          tween: Tween(
                                            begin: begin,
                                            end: end,
                                          ),
                                          builder: (context, value, child) {
                                            return Container(
                                              height: 3.0,
                                              width: value,
                                              color: Palette.LIGHT_PINK,
                                              // duration: Duration(milliseconds: 500),
                                            );
                                          },
                                        ),
                                      );
                                    }),
                                    ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: controller.totalCount,
                                      itemBuilder: (context, index) {
                                        return MaterialStepItem(
                                          index,
                                          isSelected:
                                              index <= controller.currentIndex,
                                          isExam: index + 1 ==
                                              controller.totalCount,
                                          onPressed: () =>
                                              controller.changeIndex(
                                            index,
                                            examController.examStatus,
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: stepSpacing),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: fabSize * 3.2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: SizedBox(
                  width: fabSize * 2,
                  height: navHeight + fabSize,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: FloatingActionButton(
                      onPressed: proceed,
                      backgroundColor: buttonColor,
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        textDirection: TextDirection.ltr,
                        color: Palette.WHITE,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void proceed() async {
    controller.changeIndex(
      controller.currentIndex + 1,
      examController.examStatus,
    );
    controller.scrollController.animateTo(
      (26.0 + 16.0) * controller.currentIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
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
    path.arcTo(Rect.fromLTWH(v * 0.04, 0, radius, radius), degreeToRadians(270),
        degreeToRadians(70), false);

    path.arcTo(Rect.fromLTWH(v / 2, -v / 2, v, v), degreeToRadians(160),
        degreeToRadians(-140), false);

    path.arcTo(Rect.fromLTWH((radius + v) - v * 0.04, 0, radius, radius),
        degreeToRadians(200), degreeToRadians(70), false);
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
