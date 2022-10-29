import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../theme/palette.dart';
import 'document_item_shimmer.dart';
import 'shimmer_base.dart';

class DocumentsCategoriesListShimmer extends StatelessWidget {
  const DocumentsCategoriesListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return SizedBox(
      height: 256.0,
      child: Column(
        children: [
          SizedBox(
            height: 76.0,
            child: ListView.separated(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(vertical: 22.0, horizontal: 16.0),
              itemBuilder: (context, index) {
                return const ShimmerBase(
                  color: Palette.PURPLE,
                  width: 120.0,
                  height: 32.0,
                  radius: 4.0,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 8.0,
                );
              },
            ),
          ),
          SizedBox(
            height: 180.0,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: (size.width / 148.0).floor() + 2,
              scrollDirection: Axis.horizontal,
              itemBuilder: (c, i) {
                return const DocumentItemShimmer();
              },
            ),
          )
        ],
      ),
    );
  }
}
