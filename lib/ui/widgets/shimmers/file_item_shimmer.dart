import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import 'shimmer_base.dart';

class FileItemShimmer extends StatelessWidget {

  const FileItemShimmer({super.key});

   Color get color => const Color(0xFF5351FB);

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Container(
            height: 45.0,
            width: 45.0,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.24),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
                child: Image.asset(
              "assets/images/file.png",
              fit: BoxFit.fitWidth,
            )),
          ),
          const SizedBox(width: 16.0),
          Expanded(
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
                  height: 4.0,
                ),
                ShimmerBase(
                  color: color,
                  width: size.width / 4,
                  height: 14.0,
                  radius: 30.0,
                ),
                const SizedBox(
                  height: 4.0,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          ClipOval(
            child: ShimmerBase(
              color: color,
              width: 32.0,
              height: 32.0,
              radius: 0.0,
            ),
          )
        ],
      ),
    );
  }
}
