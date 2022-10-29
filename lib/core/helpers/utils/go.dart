import 'package:flutter/material.dart';

import '../routes/routes.dart';

class Go {
  static final Go _instance = Go._internal();
  factory Go() => _instance;
  Go._internal();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext? get context => navigatorKey.currentContext;
  NavigatorState? get navState => navigatorKey.currentState;

  void backToRoot([BuildContext? context]) {
    if (context != null) {
      return Navigator.popUntil(context, ModalRoute.withName(Routes.ROOT));
    }
    return navState?.popUntil(ModalRoute.withName(Routes.ROOT));
  }

  // void closeCurrentDialog() {
  //   try {
  //     Navigator.of(context!).pop('dialog');
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("couldn't close current dialog");
  //     }
  //   }
  // }
}
