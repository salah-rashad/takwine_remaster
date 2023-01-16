import 'package:flutter/material.dart';

import '../../../ui/screens/auth/change_password/change_password_screen.dart';
import '../routes/routes.dart';
import 'logger.dart';

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

  void showSnackbar(SnackBar snackBar) {
    try {
      if (context != null) {
        ScaffoldMessenger.of(context!).clearSnackBars();
        ScaffoldMessenger.of(context!).showSnackBar(snackBar);
      }
    } catch (e) {
      Logger.Red.log("Couldn't show Snackbar!");
      rethrow;
    }
  }

  Future<T?> toChangePasswordScreen<T>(BuildContext context, {String? token}) {
    final NavigatorState navigator = Navigator.of(context);
    final CapturedThemes themes =
        InheritedTheme.capture(from: context, to: navigator.context);
    return Navigator.push<T>(
      context,
      MaterialPageRoute(
        builder: (context) => themes.wrap(
          ChangePasswordScreen(resetToken: token),
        ),
      ),
    );
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
