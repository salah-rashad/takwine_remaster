import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

extension BuildContextExtensions on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get getSize => MediaQuery.of(this).size;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension WidgetExtensions on Widget {
  Route route(RouteSettings settings) => MaterialPageRoute(
        builder: (context) => this,
        settings: settings,
      );
}

extension IntExtensions on int {
  String toStringFormatted(String format) {
    return intl.NumberFormat(format).format(this);
  }
}
