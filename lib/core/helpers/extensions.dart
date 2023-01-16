import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import 'utils/logger.dart';

extension BuildContextExtensions on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;

  T listen<T>() {
    var widgetName = widget.toString();
    var routeName = ModalRoute.of(this)?.settings.name;
    var details = "$widgetName ($routeName)";

    Logger.Yellow.log(
      "$T - $details",
      name: "LISTENING",
    );
    return watch<T>();
  }
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

extension NumExtensions on num {
  String readableFileSize({bool base1024 = true}) {
    final base = base1024 ? 1024 : 1000;
    if (this <= 0) return "0";
    final units = ["B", "kB", "MB", "GB", "TB"];
    int digitGroups = (log(this) / log(base)).round();
    return "${intl.NumberFormat("#,##0.#").format(this / pow(base, digitGroups))} ${units[digitGroups]}";
  }
}
