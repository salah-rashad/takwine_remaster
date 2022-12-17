import 'package:flutter/material.dart';

import '../theme/palette.dart';
import 'cover_image.dart';

class CircularBorderedImage extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final double spaceBetween;

  const CircularBorderedImage({
    Key? key,
    this.imageUrl,
    required this.size,
    required this.spaceBetween,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: Palette.WHITE, width: 1),
      ),
      child: Container(
        margin: EdgeInsets.all(spaceBetween),
        child: ClipOval(
          child: CoverImage(
            url: imageUrl,
            height: size,
            width: size,
            memCacheWidth: (size * 1.5).toInt(),
            memCacheHeight: (size * 1.5).toInt(),
            fit: BoxFit.cover,
            placeholder: (context, url) => placeholderImage(),
          ),
        ),
      ),
    );
  }

  Widget placeholderImage() {
    return Image.asset(
      "assets/images/user.png",
      height: size,
      width: size,
      fit: BoxFit.cover,
    );
  }

  // static Widget file({
  //   required File file,
  //   required double size,
  //   required double spaceBetween,
  // }) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.transparent,
  //       shape: BoxShape.circle,
  //       border: Border.all(color: Palette.WHITE, width: 1),
  //     ),
  //     child: Container(
  //       margin: EdgeInsets.all(spaceBetween),
  //       child: ClipOval(
  //         child: Image.file(
  //           file,
  //           height: size,
  //           width: size,
  //           fit: BoxFit.cover,
  //           errorBuilder: (context, url, error) => Image.asset(
  //             "assets/images/user.png",
  //             height: size,
  //             width: size,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // static Widget asset({
  //   required String path,
  //   required double size,
  //   required double spaceBetween,
  // }) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.transparent,
  //       shape: BoxShape.circle,
  //       border: Border.all(color: Palette.WHITE, width: 1),
  //     ),
  //     child: Container(
  //       margin: EdgeInsets.all(spaceBetween),
  //       child: ClipOval(
  //         child: Image.asset(
  //           path,
  //           height: size,
  //           width: size,
  //           fit: BoxFit.cover,
  //           errorBuilder: (context, url, error) => Image.asset(
  //             "assets/images/user.png",
  //             height: size,
  //             width: size,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
