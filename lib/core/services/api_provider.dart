// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/helpers/utils/logger.dart';
import '../controllers/auth/auth_controller.dart';
import '../helpers/constants/constants.dart';
import '../helpers/constants/urls.dart';
import '../helpers/utils/app_snackbar.dart';
import '../helpers/utils/cache_manager.dart';
import '../helpers/utils/connectivity.dart';
import '../helpers/utils/go.dart';

typedef MapConverter<T> = T Function(Map<String, dynamic> map);

class ApiProvider {
  late Dio _dio;
  CancelToken cancelToken = CancelToken();

  String? get token => CacheManager.getToken();

  final BaseOptions options = BaseOptions(
    baseUrl: ApiUrls.HOST_URL,
    receiveDataWhenStatusError: true,
    connectTimeout: 30 * 1000, // 30 seconds
    receiveTimeout: 30 * 1000, // 30 seconds
  );

  ApiProvider() {
    _dio = Dio(options);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) async {
          if (await Connectivity.isInternetConnected(debug: false)) {
            requestOptions.headers.addAll({"Cookie": token});
            requestOptions.cancelToken = cancelToken;
            return handler.next(requestOptions);
          } else {
            AppSnackbar.noInternet();
            return handler.reject(
              DioError(
                requestOptions: requestOptions,
                error: "No Internet Connection!",
              ),
            );
          }
        },
        onResponse: (response, handler) async {
          //get cookie from response
          final cookies = response.headers.map['set-cookie'];

          if (cookies != null && cookies.isNotEmpty) {
            final authToken = cookies[0].split(';')[0];

            await CacheManager.setToken(authToken);
            await CacheManager.setFullToken(cookies[0]);
          }

          logResponse(response);
          return handler.next(response);
        },
        onError: (error, handler) async {
          var e = handleError(error);
          return handler.next(e);
          // var origin = error.response?.requestOptions;
          // if (error.response?.statusCode == 401) {
          //   try {
          //     Response<dynamic> response = await _dio.get("your_refresh_url");
          //     token = response.data['access'];
          //     _cacheManager.setToken(token);
          //     origin?.headers["set-cookie"] = token;
          //     print(token);
          //     return _dio.request(origin!.path, options: origin);
          //   } catch (e) {
          //     rethrow;
          //   }
          // }
        },
      ),
    );
  }

  Future<Response?> GET(String url) async {
    Response? response;

    try {
      response = await _dio.get(url);
    } on DioError catch (e) {
      response = e.response;
    } catch (e) {
      rethrow;
    }

    return response;
  }

  Future<Response?> POST(String url, {dynamic data}) async {
    Response? response;

    try {
      response = await _dio.post(url, data: data);
    } on DioError catch (e) {
      response = e.response;
    } catch (e) {
      rethrow;
    }

    return response;
  }

  Future<Response?> PUT(String url, {dynamic data}) async {
    Response? response;

    try {
      response = await _dio.put(url, data: data);
    } on DioError catch (e) {
      response = e.response;
    } catch (e) {
      rethrow;
    }

    return response;
  }

  Future<Response?> DELETE(String url, {dynamic data}) async {
    Response? response;

    try {
      response = await _dio.delete(url, data: data);
    } on DioError catch (e) {
      response = e.response;
    } catch (e) {
      rethrow;
    }

    return response;
  }

  Future<T?> fetch<T>(Url url, MapConverter<T> convert,
      {bool saveCache = true}) async {
    var data = await _fetchData<T>(url, convert, saveCache);
    if (data is T) {
      return data;
    } else {
      return null;
    }
  }

  Future<List<T>> fetchList<T>(
    Url url,
    MapConverter<T> convert, {
    bool saveCache = true,
  }) async {
    var data = await _fetchData<T>(url, convert, saveCache);

    if (data is List<T>) {
      return data;
    } else {
      return List<T>.empty();
    }
  }

  /// This function tries fetching data from `url`.
  /// If the response is null or the status code is not `200`,
  /// try to get cached data from storage.
  /// If cache data is null neither, then return null.
  Future<Object?> _fetchData<T>(
    Url url,
    MapConverter<T> convert,
    bool saveCache,
  ) async {
    if (!saveCache) {
      url.storage.remove(url.url);
    }

    var response = await GET(url.url);

    // represents the raw data like "Map" or "List<Map>"
    dynamic data;
    // this should be the data converted to an Object or List<Object>
    // this is the object that should be returned
    Object? object;

    if (response != null && response.statusCode == 200) {
      data = response.data;

      if (saveCache) CacheManager.write(url.url, data, storage: url.storage);
    } else {
      var cache = CacheManager.read(url.url, storage: url.storage);

      if (cache != null) {
        data = cache;
      }
    }

    // Logger.White.log(data);

    // convert data
    if (data != null) {
      if (data is List) {
        var list = List<T>.empty(growable: true);

        for (var e in data) {
          list.add(convert(e));
        }

        object = list;
      } else {
        if (data is Map<String, dynamic>) {
          object = convert(data);
        }
      }
    }

    return object;
  }

  DioError handleError(DioError e) {
    if (e.response != null) {
      logResponse(e.response!);
    } else {
      Logger.Red.log(
        "${e.requestOptions.path} - [${e.requestOptions.method}] ${e.message}",
        name: "ERROR!",
        error: e.error,
      );
    }

    var response = e.response;
    if (response != null) {
      switch (response.statusCode) {
        case HttpStatus.unauthorized:
          _trySignOut();
          break;
        case HttpStatus.badRequest:
        default:
          handleBadRequestMessage(response.data);
      }
    }

    return e;
  }

  static Widget _header(value) => Text(
        "$value:".toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

  static Widget _item(value) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("• "),
            Expanded(
              child: Text(
                value.toString(),
                style: const TextStyle(
                  color: Color(0xFFD53939),
                ),
              ),
            ),
          ],
        ),
      );

  static void handleBadRequestMessage(data) {
    if (data is Map<String, dynamic>) {
      List<Widget> messages = [];

      for (var entry in data.entries) {
        var key = entry.key;
        var value = entry.value;

        key = responseMessageKeysTranslationsMap[key] ?? key;

        if (key != "message") {
          messages.add(_header(key));
        }

        if (value is List) {
          for (var v in value) {
            messages.add(_item(v));
          }
          messages.add(const SizedBox(height: 16.0));
        } else {
          messages.add(_item(value));
        }
      }

      AppSnackbar.custom(
        content: DefaultTextStyle.merge(
          style: const TextStyle(fontSize: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: messages,
          ),
        ),
      );
    }
  }

  void _trySignOut() {
    try {
      var ctx = Go().context;

      if (ctx != null) {
        ctx.read<AuthController>().signOut(ctx, forced: true);
      } else {
        throw Error;
      }
    } catch (e) {
      if (kDebugMode) {
        print("[$this] Couldn't sign out!");
      }
    }
  }

  void logResponse(Response response) {
    var url = response.requestOptions.path;
    var statusCode = response.statusCode;
    var statusMessage = response.statusMessage;
    var method = response.requestOptions.method;

    String prefix = "";

    switch (method) {
      case "GET":
        prefix = "GET:    ";
        break;
      case "POST":
        prefix = "POST:   ";
        break;
      case "PUT":
        prefix = "PUT:    ";
        break;
      case "DELETE":
        prefix = "DELETE: ";
        break;
    }

    var logMessage = "$url - $statusCode $statusMessage";

    if (response.statusCode.toString().startsWith("2")) {
      Logger.Green.log(logMessage, name: prefix);
    } else {
      Logger.Red.log(
        logMessage,
        name: prefix,
        error: response.data is Map ? response.data.toString() : null,
      );
    }
  }
}
