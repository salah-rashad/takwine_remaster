import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/api_provider.dart';
import '../constants/constants.dart';
import 'logger.dart';

class CacheManager {
  static final GetStorage generalStorage = GetStorage();
  static final GetStorage authStorage = GetStorage("auth_storage");
  // static final GetStorage authAppleStorage = GetStorage(STORAGE_AUTH_APPLE);

  // //* TOKEN
  static String? getToken() => authStorage.read<String>(STORAGE_AUTH_TOKEN);
  static Future<void> setToken(String? value) =>
      authStorage.write(STORAGE_AUTH_TOKEN, value);

  static String? getFullToken() =>
      authStorage.read<String>(STORAGE_AUTH_FULL_TOKEN);
  static Future<void> setFullToken(String? value) =>
      authStorage.write(STORAGE_AUTH_FULL_TOKEN, value);

  /* ***************************** */
  /* ***************************** */
  /* ***************************** */

  //* READ FROM GENERAL STORAGE
  static T? read<T>(String key) {
    try {
      T? value = generalStorage.read<T>(key);

      return value;
    } catch (e) {
      if (kDebugMode) {
        print("ERROR! : $e");
      }
      rethrow;
    }
  }

  //* READ FROM GENERAL STORAGE
  static T? readAndConvert<T, C>(String key, MapConverter<C> convert) {
    try {
      var data = generalStorage.read<dynamic>(key);

      if (data != null) {
        if (data is List) {
          var list = List<C>.empty(growable: true);

          for (var e in data) {
            try {
              var obj = convert(e);
              list.add(obj);
            } catch (e) {
              continue;
            }
          }

          data = list;
        } else {
          try {
            data = convert(data);
          } catch (e) {
            return null;
          }
        }
      }

      Logger.Black.log("$key - ${data.runtimeType}", name: "CacheManager");

      if (data is T) {
        return data;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  //* WRITE TO GENERAL STORAGE
  static Future<void> write<T>(String key, T data) async {
    try {
      await generalStorage.write(key, data);
    } catch (e) {
      if (kDebugMode) {
        print("ERROR! : $e");
      }
      rethrow;
    }
  }
}
