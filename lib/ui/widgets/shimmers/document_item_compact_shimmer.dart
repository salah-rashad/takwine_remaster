import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../theme/palette.dart';
import 'shimmer_base.dart';

class DocumentItemCompactShimmer extends StatelessWidget {
  const DocumentItemCompactShimmer({super.key});

  Color get color => Palette.PURPLE;

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Palette.WHITE,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 64,
            child: AspectRatio(
              aspectRatio: 1,
              child: ShimmerBase(
                color: color,
                radius: 12.0,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Flexible(
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
                ShimmerBase(
                  color: color,
                  radius: 30,
                  width: size.width / 3.5,
                  height: 16.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
