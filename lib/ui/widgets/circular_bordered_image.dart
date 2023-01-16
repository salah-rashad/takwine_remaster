import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/palette.dart';
import 'cover_image.dart';

class CircularBorderedImage extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final double spaceBetween;
  final PlaceholderWidgetBuilder? placeholder;

  const CircularBorderedImage({
    Key? key,
    this.imageUrl,
    required this.size,
    this.spaceBetween = 2.0,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: Palette.WHITE, width: 1),
      ),
      padding: EdgeInsets.all(spaceBetween),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(size * 2),
        child: Container(
          color: Palette.GRAY.withOpacity(0.7),
          child: CoverImage(
            url: imageUrl,
            height: size,
            width: size,
            memCacheWidth: (size * 3).toInt(),
            fit: BoxFit.cover,
            placeholder: placeholder,
          ),
        ),
      ),
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
