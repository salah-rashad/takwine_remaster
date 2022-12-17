import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../theme/palette.dart';
import 'shimmer_base.dart';

class CertificateItemShimmer extends StatelessWidget {
  const CertificateItemShimmer({super.key});

  Color get color => Palette.coursesMyCertificatesTabColors[0];

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            ShimmerBase(
              color: color,
              radius: 12.0,
              width: 45.0,
              height: 45.0,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBase(
                    color: color,
                    radius: 30.0,
                    width: size.width / 4,
                    height: 14.0,
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  ShimmerBase(
                    color: color,
                    radius: 30.0,
                    width: size.width / 2.5,
                    height: 12.0,
                  ),
                ],
              ),
            ),
            ShimmerBase(
              color: color,
              radius: 30.0,
              width: 32.0,
              height: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}
