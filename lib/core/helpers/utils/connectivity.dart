import 'dart:io';

import 'package:flutter/foundation.dart';

class Connectivity {
  static Future<bool> isInternetConnected({bool debug = false}) async {
    bool value = false;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        value = true;
      } else {
        value = false;
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      value = false;
    }

    if (kDebugMode) {
      if (debug) {
        if (value) {
          print('CONNECTION: [TRUE]');
        } else {
          print('CONNECTION: [FALSE]');
        }
      }
    }

    return value;
  }
}
