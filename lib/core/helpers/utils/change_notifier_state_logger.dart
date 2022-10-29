import 'package:flutter/foundation.dart';

import 'logger.dart';

mixin ChangeNotifierStateLogger on ChangeNotifier {
  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    Logger.Yellow.log(
      runtimeType.toString(),
      name: "ADDED",
    );
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    Logger.Yellow.log(
      runtimeType.toString(),
      name: "REMOVED",
    );
  }

  @override
  void dispose() {
    super.dispose();
    Logger.Yellow.log(
      runtimeType.toString(),
      name: "DISPOSED",
    );
  }
}
