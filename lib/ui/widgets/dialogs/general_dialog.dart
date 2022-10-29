import 'package:flutter/material.dart';

import '../../theme/palette.dart';

class GeneralDialog extends StatelessWidget {
  final BuildContext context;
  final String? title;
  final String? content;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onDecline;
  final Color? confirmColor;

  const GeneralDialog(
    this.context, {
    super.key,
    this.title,
    this.content,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onDecline,
    this.confirmColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? "تحذير"),
      content: Text(content ?? ""),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor ?? Palette.RED),
          onPressed: () {
            onConfirm?.call();
            Navigator.pop(context, true);
          },
          child: Text(confirmText ?? "تأكيد"),
        ),
        TextButton(
          style: ElevatedButton.styleFrom(foregroundColor: Palette.GRAY),
          onPressed: () {
            onDecline?.call();
            Navigator.pop(context, false);
          },
          child: Text(cancelText ?? "إلغاء"),
        ),
      ],
    );
  }
}
