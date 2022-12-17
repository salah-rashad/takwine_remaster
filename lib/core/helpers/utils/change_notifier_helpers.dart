import 'package:flutter/foundation.dart';

import 'logger.dart';

mixin ChangeNotifierHelpers on ChangeNotifier {
  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    Logger.Yellow.log(
      "$runtimeType",
      name: "ADDED",
    );
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    Logger.Yellow.log(
      "$runtimeType",
      name: "REMOVED",
    );
  }

  @override
  void dispose() {
    Logger.Yellow.log(
      runtimeType.toString(),
      name: "DISPOSED",
    );
    super.dispose();
  }

  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } on FlutterError catch (e) {
      Logger.Red.log(e.message, name: "ProviderError");
    } catch (e) {
      rethrow;
    }
  }
}
