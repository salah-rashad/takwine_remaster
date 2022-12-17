import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../theme/palette.dart';

class CoursesSettingsWidget extends StatelessWidget {
  final List<Color>? colors;
  final String? title;
  final String? subtitle;
  final String? image;
  final String? titleFontFamily;

  const CoursesSettingsWidget({
    super.key,
    this.colors,
    this.title,
    this.subtitle,
    this.image,
    this.titleFontFamily,
  });

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      height: 80.0,
      width: size.width / 2.3,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors!,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Image.asset(
              image!,
              height: 32.0,
              width: 32.0,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                    color: Palette.WHITE,
                    fontFamily: titleFontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    color: Palette.WHITE,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
