import 'package:flutter/material.dart';

class FixedTextFormField extends TextFormField {
  FixedTextFormField({
    super.key,
    super.autocorrect,
    super.autofillHints,
    super.autofocus,
    super.autovalidateMode = AutovalidateMode.onUserInteraction,
    super.buildCounter,
    super.controller,
    super.cursorColor,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorWidth,
    super.decoration,
    super.enableIMEPersonalizedLearning,
    super.enableInteractiveSelection,
    super.enableSuggestions,
    super.enabled,
    super.expands,
    super.focusNode,
    super.initialValue,
    super.inputFormatters,
    super.keyboardAppearance,
    super.keyboardType,
    super.maxLength,
    super.maxLengthEnforcement,
    super.maxLines,
    super.minLines,
    super.mouseCursor,
    super.obscureText,
    super.obscuringCharacter,
    super.onChanged,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onSaved,
    super.readOnly,
    super.restorationId,
    super.scrollController,
    super.scrollPadding,
    super.scrollPhysics,
    super.selectionControls,
    super.showCursor,
    super.smartDashesType,
    super.smartQuotesType,
    super.strutStyle,
    super.style,
    super.textAlign,
    super.textAlignVertical,
    super.textCapitalization,
    super.textDirection,
    super.textInputAction,
    super.toolbarOptions,
    super.validator,
    VoidCallback? onTap,
  }) : super(onTap: () {
          onTap?.call();
          _onTap(controller);
        });

  // copied from https://github.com/flutter/flutter/issues/107006#issuecomment-1173183500
  static void _onTap(TextEditingController? controller) {
    if (controller == null) return;

    var condition = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length - 1));

    if (controller.selection == condition) {
      controller.selection = TextSelection.fromPosition(
        TextPosition(
          offset: controller.text.length,
        ),
      );
    }
  }
}
