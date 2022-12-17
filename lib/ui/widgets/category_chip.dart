import 'package:flutter/material.dart';

import '../../core/helpers/utils/helpers.dart';

class CategoryChip extends Chip {
  const CategoryChip({
    super.key,
    required super.label,
    super.avatar,
    super.backgroundColor,
  });

  @override
  Color get backgroundColor => super.backgroundColor ?? Colors.black;

  @override
  VisualDensity? get visualDensity =>
      const VisualDensity(horizontal: 0.0, vertical: -4);

  @override
  MaterialTapTargetSize? get materialTapTargetSize =>
      MaterialTapTargetSize.shrinkWrap;

  @override
  EdgeInsetsGeometry? get padding => avatar == null
      ? const EdgeInsets.symmetric(horizontal: 8.0)
      : const EdgeInsets.only(left: 8.0);

  @override
  EdgeInsetsGeometry? get labelPadding => EdgeInsets.zero;

  @override
  TextStyle? get labelStyle => TextStyle(
        color: getFontColorForBackground(backgroundColor),
        fontSize: 12.0,
      );
}
