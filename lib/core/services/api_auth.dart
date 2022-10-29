import 'dart:io';

import 'package:dio/dio.dart';

import '../helpers/constants/api_urls.dart';
import '../models/user_models/user.dart';
import 'api_provider.dart';

class ApiAuth {
  Future<Response?> loginUser(String email, String password) async {
    try {
      final url = ApiUrls.LOGIN.url;

      /// 200: user logged in successfully, returns a cookie with the token.
      /// 400: error "message".
      final response = await ApiProvider().POST(
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

  Future<bool> createUser(User user, String password) async {
    try {
      final url = ApiUrls.REGISTER.url;

      var data = {
        ...user.toMap(),
        "password": password,
      };

      /// 201: User created successfully, returns user data.
      /// 400: error "message".
      final response = await ApiProvider().POST(
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

  

  Future<bool> signOut() async {
    try {
      String url = ApiUrls.LOGOUT.url;

      // 200: logged out successfully.
      var response = await ApiProvider().POST(url);

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
