import 'package:flutter/material.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      height: 80.0,
      width: 150,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors!,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0.0,
            bottom: 0.0,
            child: Align(
              widthFactor: 0.3,
              heightFactor: 0.3,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  image!,
                  height: 64.0,
                  width: 64.0,
                ),
              ),
            ),
          ),
          Positioned.fill(
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
                    fontSize: 14.0,
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
