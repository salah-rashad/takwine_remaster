import 'package:flutter/material.dart';

import '../../theme/palette.dart';
import 'shimmer_base.dart';

class CategoriesListShimmer extends StatelessWidget {
  const CategoriesListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.0,
      child: ListView.separated(
        itemCount: 5,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (context, index) {
          return const ShimmerBase(
            color: Palette.PURPLE,
            width: 120.0,
            height: 42.0,
            radius: 8.0,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 8.0,
          );
        },
      ),
    );
  }
}
