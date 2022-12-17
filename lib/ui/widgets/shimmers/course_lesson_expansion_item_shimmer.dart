import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../theme/palette.dart';
import 'shimmer_base.dart';

class CourseLessonExpansionItemShimmer extends StatelessWidget {
  final Color color;

  const CourseLessonExpansionItemShimmer({super.key, this.color = Palette.BLACK});

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBase(
            color: color,
            width: size.width / 3,
            height: 14.0,
            radius: 30.0,
          ),
          const SizedBox(
            height: 6.0,
          ),
          ShimmerBase(
            color: color,
            width: size.width / 2,
            height: 12.0,
            radius: 30.0,
          ),
        ],
      ),
    );
  }
}
