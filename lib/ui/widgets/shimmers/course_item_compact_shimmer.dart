import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../../../core/helpers/extensions.dart';
import '../../theme/palette.dart';
import 'shimmer_base.dart';

class CourseItemCompactShimmer extends StatelessWidget {
  const CourseItemCompactShimmer({super.key});

  Color get color => Palette.coursesHomeTabColors[0];

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22.0),
      height: 90.0,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Palette.WHITE,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ShimmerBase(
              color: color,
              radius: 12.0,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBase(
                  color: color,
                  radius: 30,
                  width: size.width / 2.5,
                  height: 12.0,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                ShimmerBase(
                  color: color,
                  radius: 30,
                  width: size.width / 4,
                  height: 12.0,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                SmoothStarRating(
                  rating: 0.0,
                  // isReadOnly: true,
                  allowHalfRating: false,
                  size: 11.0,
                  color: const Color(0xFFFBB438),
                  borderColor: const Color(0xFFECE5F0),
                  defaultIconData: Icons.star,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
