import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import 'shimmer_base.dart';

class CourseItemShimmer extends StatelessWidget {
  const CourseItemShimmer({super.key});

  Color get color => Palette.coursesHomeTabColors[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Positioned.fill(
              child: Container(
                color: color.withOpacity(0.16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBase(
                    color: color,
                    width: 160.0,
                    height: 35.0,
                    radius: 30.0,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ShimmerBase(
                    color: color,
                    width: 120.0,
                    height: 20.0,
                    radius: 30.0,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
