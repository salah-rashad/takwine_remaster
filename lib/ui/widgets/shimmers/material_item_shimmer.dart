import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../theme/palette.dart';
import 'shimmer_base.dart';

class MaterialItemShimmer extends StatelessWidget {
  final bool withTitle;

  const MaterialItemShimmer({
    Key? key,
    this.withTitle = true,
  }) : super(key: key);

  static const Color color = Palette.BLUE1;

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        withTitle
            ? Column(
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  ShimmerBase(
                    color: color,
                    width: size.width / 2,
                    height: 22.0,
                    radius: 30.0,
                  ),
                  const SizedBox(height: 16.0)
                ],
              )
            : const SizedBox(),
        ShimmerBase(
          color: color,
          width: size.width / 1.5,
          height: 16.0,
          radius: 30.0,
        ),
        const SizedBox(height: 16.0),
        ShimmerBase(
          color: color,
          width: size.width / 1.7,
          height: 16.0,
          radius: 30.0,
        ),
        const SizedBox(height: 16.0),
        const AspectRatio(
          aspectRatio: 16 / 9,
          child: ShimmerBase(
            color: color,
            radius: 8.0,
          ),
        ),
        const SizedBox(height: 16),
        const ShimmerBase(
          color: color,
          width: double.infinity,
          height: 16.0,
          radius: 30.0,
        ),
        const SizedBox(height: 8.0),
        const ShimmerBase(
          color: color,
          width: double.infinity,
          height: 16.0,
          radius: 30.0,
        ),
      ],
    );
  }
}
