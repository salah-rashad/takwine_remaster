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
      dynamic data = generalStorage.read<dynamic>(key);

      if (data != null) {
        if (data is List) {
          var list = List<C>.empty(growable: true);

          for (var e in data) {
            list.add(convert(e));
          }

          data = list;
        } else {
          data = convert(data);
        }
      }

      Logger.Black.log("$key - ${data.runtimeType}", name: "CacheManager");

      return data;
    } catch (e) {
      if (kDebugMode) {
        print("ERROR! : $e");
      }
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

//? THE BELOW COMMENTED CODE WAS JUST FOR DEBUGGING

//// Future<T> read<T>(String key) async {
////     try {
////       T finalValue;
////       // log("=========================================================================");
////       // print("KEY: $key");
////       // print("🔍 READING FROM \"TEMPORARY\" MEMORY");
////       // T tempValue = storage.read<T>(_memoryPrefix + key);
//
////       // if (!tempValue == null) {
////       //   finalValue = tempValue;
////       //   print("SUCCESS!");
////       // } else {
////       //   print("TEMP: $tempValue");
//
////       // log("=========================================================================");
////       // print("KEY: $key");
////       // print("🔍 READING FROM \"PERMANENT\" CACHE");
//
////       T permValue = storage.read<T>(key);
////       finalValue = permValue;
//
////       // if (permValue == null)
////       //   print("PERM: $permValue");
////       // else
////       // print("SUCCESS!");
////       // }
//
////       return finalValue;
////     } catch (e) {
////       print(e.toString());
////       return null;
////     }
////   }
//
////   Future<void> write(String key, dynamic data) async {
////     try {
////       // log("=========================================================================");
////       // print("KEY: $key");
////       // print("✍ WRITING TO \"TEMPORARY\" MEMORY");
//
////       // storage.writeInMemory(_memoryPrefix + key, data);
////       // print("SUCCESS!");
//
////       // log("=========================================================================");
////       // print("KEY: $key");
////       // print("✍ WRITING TO \"PERMANENT\" CACHE");
//
////       await storage.write(key, data).catchError((e) => print("ERROR! : " + e));
////       // print("SUCCESS!");
////     } catch (e) {
////       print(e.toString());
////     }
////   }
//
