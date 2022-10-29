import 'dart:io';

import 'package:flutter/foundation.dart';

class Connectivity {
  static Future<bool> isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('CONNECTION: [TRUE]');
        return true;
      } else {
        // print('CONNECTION: [FALSE]');
        return false;
      }
    } on SocketException catch (e) {
      // print('CONNECTION: [FALSE]');
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }
}
