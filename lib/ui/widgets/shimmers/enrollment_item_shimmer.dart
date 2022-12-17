import 'package:flutter/material.dart';
import 'shimmer_base.dart';
import '../../../core/helpers/extensions.dart';
import '../../theme/palette.dart';

class EnrollmentItemShimmer extends StatelessWidget {
  const EnrollmentItemShimmer({super.key});

  Color get color => Palette.coursesMyActivityTabColors[0];

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
              width: size.width / 2.5,
              height: 35.0,
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
                  width: size.width / 2.5,
                  height: 12.0,
                  radius: 30.0,
                ),
                const SizedBox(height: 6.0),
                ShimmerBase(
                  color: color,
                  width: size.width / 4,
                  height: 12.0,
                  radius: 30.0,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ShimmerBase(
                    color: color,
                    width: 16,
                    height: 8,
                    radius: 30.0,
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                ShimmerBase(
                  color: color,
                  // width: size.width,
                  height: 4.0,
                  radius: 30.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
