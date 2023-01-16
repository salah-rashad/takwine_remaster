import 'package:flutter/material.dart';

import '../../core/helpers/extensions.dart';
import '../../core/helpers/utils/helpers.dart';
import '../theme/palette.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final Color? leftColor;
  final Color? rightColor;
  final VoidCallback? onTap;
  final bool isLoading;
  final double radius;
  final double width;
  final double height;
  final Color? splashColor;
  final double fontSize;
  final Color? textColor;

  Color primaryColor(BuildContext context) => context.theme.colorScheme.primary;

  List<Color> _colors(BuildContext context) => [
        leftColor ?? primaryColor(context),
        rightColor ?? primaryColor(context),
      ];

  Color _textColor(BuildContext context) =>
      textColor ?? getFontColorForBackground(_colors(context)[0]);

  const GradientButton({
    Key? key,
    required this.child,
    this.leftColor,
    this.rightColor,
    this.radius = 4.0,
    this.width = double.maxFinite,
    this.height = 60.0,
    this.splashColor,
    this.onTap,
    this.isLoading = false,
    this.fontSize = 18.0,
    this.textColor,
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
              colors: _colors(context),
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Material(
            clipBehavior: Clip.antiAlias,
            color:
                isLoading ? Palette.GRAY.withOpacity(0.30) : Colors.transparent,
            child: InkWell(
              onTap: isLoading ? null : onTap,
              highlightColor: Colors.transparent,
              splashColor: splashColor ?? _textColor(context).withOpacity(0.16),
              borderRadius: BorderRadius.circular(radius),
              child: Align(
                alignment: Alignment.center,
                child: DefaultTextStyle.merge(
                  style: TextStyle(
                    color: _textColor(context),
                    fontSize: fontSize,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        ),
        if (isLoading)
          SizedBox(
            height: height,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LinearProgressIndicator(
                backgroundColor: Palette.BLACK.withOpacity(0.3),
                color: _textColor(context),
              ),
            ),
          )
      ],
    );
  }
}
