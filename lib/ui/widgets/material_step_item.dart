import 'package:flutter/material.dart';

import '../../core/helpers/extensions.dart';
import '../theme/palette.dart';

// ignore: must_be_immutable
class MaterialStepItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final bool isExam;
  final VoidCallback? onPressed;

  const MaterialStepItem(
    this.index, {
    super.key,
    required this.isSelected,
    required this.isExam,
    required this.onPressed,
  });

  bool get enabled => isSelected || index == 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 28.0,
            width: 28.0,
            decoration: BoxDecoration(
                color: enabled ? Palette.LIGHT_PINK : Palette.WHITE,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Palette.LIGHT_PINK,
                ),
                boxShadow: [
                  BoxShadow(
                    color: enabled
                        ? Palette.BLACK.withOpacity(0.16)
                        : Colors.transparent,
                    blurRadius: 6.0,
                    offset: const Offset(0.0, 3.0),
                  )
                ]),
            child: Center(
              child: isExam
                  ? Icon(
                      Icons.text_snippet_rounded,
                      size: 18.0,
                      color: enabled ? Palette.WHITE : Palette.LIGHT_PINK,
                    )
                  : Text(
                      (index + 1).toStringFormatted("00"),
                      style: TextStyle(
                        color: enabled ? Palette.WHITE : Palette.LIGHT_PINK,
                        fontSize: 14.0,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
