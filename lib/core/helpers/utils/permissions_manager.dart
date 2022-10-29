import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionsManager {
  // STORAGE

  static Future<bool> checkPermission(Permission permission) async {
    if (Platform.isAndroid) {
      final status = await permission.status;
      if (status != PermissionStatus.granted) {
        final result = await permission.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }
}
