import 'package:flutter/material.dart';
import '../theme/palette.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final Color leftColor;
  final Color rightColor;
  final VoidCallback? onTap;
  final bool isLoading;
  final double radius;
  final double width;
  final double height;
  final Color? splashColor;

  const GradientButton({
    Key? key,
    required this.child,
    required this.leftColor,
    required this.rightColor,
    this.radius = 4.0,
    this.width = double.maxFinite,
    this.height = 60.0,
    this.splashColor,
    this.onTap,
    this.isLoading = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width,
          height: height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [leftColor, rightColor],
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Material(
            color:
                isLoading ? Palette.GRAY.withOpacity(0.30) : Colors.transparent,
            child: InkWell(
              onTap: isLoading ? null : onTap,
              highlightColor: Colors.transparent,
              splashColor: splashColor ?? Palette.WHITE.withOpacity(0.16),
              borderRadius: BorderRadius.circular(radius),
              child: Align(
                alignment: Alignment.center,
                child: child,
              ),
            ),
          ),
        ),
        isLoading
            ? SizedBox(
                height: height,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: LinearProgressIndicator(
                    backgroundColor: Palette.WHITE.withOpacity(0.30),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
