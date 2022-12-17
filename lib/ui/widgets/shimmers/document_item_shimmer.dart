import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import 'shimmer_base.dart';

class DocumentItemShimmer extends StatelessWidget {
  const DocumentItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ShimmerBase(
          color: Palette.PURPLE,
          width: 140.0,
          height: 130.0,
          radius: 4.0,
        ),
        SizedBox(
          height: 4,
        ),
        ShimmerBase(
          color: Palette.PURPLE,
          width: 120.0,
          height: 18.0,
          radius: 4.0,
        ),
        SizedBox(
          height: 2,
        ),
      ],
    );
  }
}
