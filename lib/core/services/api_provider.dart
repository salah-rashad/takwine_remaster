// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

import '../../core/helpers/utils/logger.dart';
import '../helpers/constants/api_urls.dart';
import '../helpers/constants/constants.dart';
import '../helpers/utils/app_snackbar.dart';
import '../helpers/utils/cache_manager.dart';
import '../helpers/utils/connectivity.dart';
import 'api_account.dart';
import 'api_auth.dart';
import 'api_courses.dart';

typedef MapConverter<T> = T Function(Map<String, dynamic> map);

class ApiProvider {
  late Dio _dio;
  late DioCacheManager _dioCacheManager;
  // final CacheManager _cacheManager = CacheManager();

  final ApiAuth auth = ApiAuth();
  final ApiAccount account = ApiAccount();
  final ApiCourses courses = ApiCourses();
  // static final _APIDocs docs = _APIDocs();

  String? token = '';

  final BaseOptions options = BaseOptions(
    baseUrl: ApiUrls.HOST_URL,
    receiveDataWhenStatusError: true,
    connectTimeout: 60 * 1000, // 60 seconds
    receiveTimeout: 60 * 1000, // 60 seconds
  );

  static final ApiProvider _instance = ApiProvider._internal();
  factory ApiProvider() => _instance;

  ApiProvider._internal() {
    token = CacheManager.getToken();

    _dioCacheManager = DioCacheManager(CacheConfig());

    _dio = Dio(options);
    _dio.interceptors.add(_dioCacheManager.interceptor);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers.addAll({"Cookie": token});
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          //get cooking from response
          final cookies = response.headers.map['set-cookie'];
          if (cookies != null && cookies.isNotEmpty) {
            final authToken = cookies[0].split(';')[0];
            token = authToken;

            await CacheManager.setToken(token);
            await CacheManager.setFullToken(cookies[0]);
          }
          return handler.next(response);
        },
        onError: (error, handler) async {
          return handler.next(error);
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

    if (await Connectivity.isInternetConnected()) {
      try {
        response = await _dio.get(url);
      } on DioError catch (e) {
        response = e.response;
        if (response != null) {
          switch (response.statusCode) {
            case HttpStatus.unauthorized:
              // _trySignOut();
              break;
            case HttpStatus.badRequest:
            default:
              handleBadRequestMessage(response.data);
          }
        }
      } catch (e) {
        rethrow;
      }
    } else {
      AppSnackbar.noInternet();
    }

    logResponse(url, response);

    return response;
  }

  Future<Response?> POST(String url, {dynamic data}) async {
    Response? response;

    if (await Connectivity.isInternetConnected()) {
      try {
        response = await _dio.post(url, data: data);
      } on DioError catch (e) {
        response = e.response;

        if (response != null) {
          switch (response.statusCode) {
            case HttpStatus.unauthorized:
              // _trySignOut();
              break;
            case HttpStatus.badRequest:
            default:
              handleBadRequestMessage(response.data);
          }
        }
      } catch (e) {
        rethrow;
      }
    } else {
      AppSnackbar.noInternet();
    }

    logResponse(url, response);

    return response;
  }

  Future<Response?> PUT(String url, {dynamic data}) async {
    Response? response;

    if (await Connectivity.isInternetConnected()) {
      try {
        response = await _dio.put(url, data: data);
      } on DioError catch (e) {
        response = e.response;

        if (response != null) {
          switch (response.statusCode) {
            case HttpStatus.unauthorized:
              // _trySignOut();
              break;
            case HttpStatus.badRequest:
            default:
              handleBadRequestMessage(response.data);
          }
        }
      } catch (e) {
        rethrow;
      }
    } else {
      AppSnackbar.noInternet();
    }

    logResponse(url, response);

    return response;
  }

  Future<T?> fetch<T>(
    String url,
    MapConverter<T> convert, {
    bool saveCache = true,
  }) async {
    return await _fetchData<T>(url, convert, saveCache);
  }

  Future<List<T>> fetchList<T>(
    String url,
    MapConverter<T> convert, {
    bool saveCache = true,
  }) async {
    return await _fetchData<T>(url, convert, saveCache) ?? <T>[];
  }

  /// This function tries fetching data from `url`.
  /// If the response is null or the status code is not `200`,
  /// try to get cached data from storage.
  /// If cache data is null neither, then return null.
  Future<dynamic> _fetchData<T>(
    String url,
    MapConverter<T> convert,
    bool saveCache,
  ) async {
    if (!saveCache) {
      CacheManager.generalStorage.remove(url);
    }

    var response = await ApiProvider().GET(url);

    // represents the raw data like "Map" or "List<Map>"
    dynamic data;
    // this should be the data converted to an Object or List<Object>
    // this is the object that should be returned
    dynamic object;

    if (response != null && response.statusCode == 200) {
      data = response.data;

      if (saveCache) CacheManager.write(url, data);
    } else {
      var cache = CacheManager.read(url);

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
        object = convert(data);
      }
    }

    /* var cache = _cacheManager.read<Map<String, dynamic>>(url);

    if (cache != null) {
      // if cache found return it's value
      object = convert(cache);

      // then fetch for new data and update cache
      ApiProvider().GET(url).then((response) {
        if (response?.statusCode == 200) {
          if (saveCache) _cacheManager.write(url, response!.data);
        }
      });
    } else {
      var response = await ApiProvider().GET(url);

      if (response != null) {
        if (response.statusCode == 200) {
          var data = response.data;

          if (data is List) {
            var list = List<T>.empty(growable: true);

            for (var e in data) {
              list.add(convert(e));
            }

            object = list;
          } else {
            object = convert(data);
          }

          if (saveCache) _cacheManager.write(url, data);
        }
      }
    } */

    return object;
  }

  /* Future<List<T>> fetchList<T>(
    String url,
    T Function(Map<String, dynamic> map) convert, {
    bool saveCache = true,
  }) async {
    if (!saveCache) {
      CacheManager.generalStorage.remove(url);
    }

    var list = List<T>.empty(growable: true);

    var cache = _cacheManager.read<List>(url);

    if (cache == null) {
      var response = await ApiProvider().GET(url);

      if (response != null) {
        if (response.statusCode == 200) {
          var data = response.data;

          if (data is List) {
            for (var e in data) {
              list.add(convert(e));
            }
            if (saveCache) _cacheManager.write(url, data);
          }
        }
      }
    } else {
      for (var e in cache) {
        list.add(convert(e));
      }

      ApiProvider().GET(url).then((response) {
        if (response != null) {
          if (response.statusCode == 200) {
            if (saveCache) _cacheManager.write(url, response.data);
          }
        }
      });
    }

    return list;
  } */

  static void handleBadRequestMessage(dynamic data) {
    List<Widget> messages = [];

    if (data is Map<String, dynamic>) {
      for (var entry in data.entries) {
        var key = entry.key;
        var value = entry.value;

        key = responseMessageKeysTranslationsMap[key] ?? key;

        if (key != "message") {
          messages.add(
            Text(
              "$key:".toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          );
        }

        if (value is List) {
          for (var v in value) {
            messages.add(
              Padding(
                padding: const EdgeInsets.only(left: 32.0, top: 8.0),
                child: Text(
                  v.toString(),
                  style: const TextStyle(
                    color: Color(0xFFD53939),
                  ),
                ),
              ),
            );
          }
          messages.add(const SizedBox(height: 16.0));
        } else {
          messages.add(
            Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 8.0),
              child: Text(
                value.toString(),
                style: const TextStyle(
                  color: Color(0xFFD53939),
                ),
              ),
            ),
          );
        }
      }

      AppSnackbar.custom(
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: messages,
        ),
      );
    }
  }

  // void _trySignOut() {
  //   var ctx = Go().context;

  //   if (ctx != null) {
  //     ctx.read<AuthController>().signOut(ctx, forced: true);
  //   } else {
  //     Logger.Yellow.log("[$this] Couldn't sign out!");
  //   }
  // }

  void logResponse(String url, Response? response) {
    if (response == null) {
      Logger.Red.log(url, name: "error");
      return;
    }
    var statusCode = response.statusCode;
    var statusMessage = response.statusMessage;
    // var url = response.requestOptions.uri.toString();
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

    var logText = "$url - $statusCode $statusMessage";

    if (response.statusCode.toString().startsWith("2")) {
      Logger.Green.log(logText, name: prefix);
    } else if (response.statusCode == HttpStatus.badRequest) {
      Logger.Red.log(
        logText,
        name: prefix,
        error: response.data.toString(),
      );
    } else {
      Logger.Red.log(logText, name: prefix);
    }
  }
}
