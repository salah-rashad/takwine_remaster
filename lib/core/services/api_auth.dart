import 'dart:io';

import 'package:dio/dio.dart';

import '../helpers/constants/urls.dart';
import '../models/user_models/user.dart';
import 'api_provider.dart';

class ApiAuth {
  ApiAuth._();
  static final ApiAuth _instance = ApiAuth._();
  factory ApiAuth() {
    return _instance;
  }

  static ApiProvider provider = ApiProvider();

  static Future<Response?> loginUser(String email, String password) async {
    try {
      final url = ApiUrls.AUTH_LOGIN.url;

      /// 200: user logged in successfully, returns a cookie with the token.
      /// 400: error "message".
      final response = await provider.POST(
        url,
        data: <String, dynamic>{
          "email": email,
          "password": password,
        },
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> createUser(User user, String password) async {
    try {
      final url = ApiUrls.AUTH_REGISTER.url;

      var data = {
        ...user.toMap(),
        "password": password,
      };

      /// 201: User created successfully, returns user data.
      /// 400: error "message".
      final response = await provider.POST(
        url,
        data: data,
      );

      if (response != null) {
        if (response.statusCode == HttpStatus.created) return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> signOut() async {
    try {
      String url = ApiUrls.AUTH_LOGOUT.url;

      // 200: logged out successfully.
      var response = await provider.POST(url);

      if (response != null) {
        if (response.statusCode == HttpStatus.ok) {
          return true;
        }
      }

      return false;
    } catch (e) {
      rethrow;
    }
  }
}
