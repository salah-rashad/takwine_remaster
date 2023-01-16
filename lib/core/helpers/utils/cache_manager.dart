import 'package:get_storage/get_storage.dart';

import '../../services/api_provider.dart';
import '../constants/constants.dart';
import 'logger.dart';

class CacheManager {
  CacheManager._();

  static final GetStorage authStorage = GetStorage("auth_storage");
  static final GetStorage generalStorage = GetStorage("general_storage");
  static final GetStorage accountStorage = GetStorage("account_storage");

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

  /// Reads [key] value from [storage] container.
  static T? read<T>(String key, {GetStorage? storage}) {
    try {
      T? value = (storage ?? generalStorage).read<T>(key);
      return value;
    } catch (e) {
      rethrow;
    }
  }

  /// Writes [data] to [key] in [storage] container.
  static Future<void> write<T>(
    String key,
    T data, {
    GetStorage? storage,
  }) async {
    try {
      await (storage ?? generalStorage).write(key, data);
    } catch (e) {
      rethrow;
    }
  }

  /// Reads [key] value from [storage] with a [convert]
  static T? readAndConvert<T, C>(
    String key,
    MapConverter<C> convert, {
    GetStorage? storage,
  }) {
    try {
      var data = read<dynamic>(key, storage: storage);

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

      Logger.Black.log(
        "$key - ${data.runtimeType}",
        name: "CacheManager",
      );

      if (data is T) {
        return data;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
