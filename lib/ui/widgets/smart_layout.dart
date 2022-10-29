import 'package:flutter/material.dart';

class SmartLayout extends StatelessWidget {
  final Widget? child;

  const SmartLayout({Key? key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: child,
            ),
          ),
        );
      },
    );
  }
}
