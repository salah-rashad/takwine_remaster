import 'dart:io';

import 'package:flutter/foundation.dart';

import '../helpers/constants/api_urls.dart';
import '../models/course_models/enrollment/complete_lesson.dart';
import '../models/course_models/enrollment/enrollment.dart';
import '../models/user_models/user.dart';
import '../models/user_models/user_statements.dart';
import 'api_provider.dart';

class ApiAccount {
  Future<User?> getProfile() async {
    try {
      String url = ApiUrls.PROFILE.url;

      // 200: returns logged in user data.
      // 401: unauthorized, with "message": Access denied.
      var response = await ApiProvider().GET(url);

      if (response != null) {
        if (response.statusCode == HttpStatus.ok) {
          return User.fromMap(response.data);
        }
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<Enrollment?> getLastActivity() async {
    try {
      final url = ApiUrls.LAST_ACTIVITY.url;

      var object = await ApiProvider().fetch(
        url,
        (map) => Enrollment.fromMap(map),
        saveCache: false,
      );

      if (kDebugMode) {
        print("Last Course: ${object?.course?.title}");
      }
      return object;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserStatements?> getUserStatements() async {
    try {
      final url = ApiUrls.USER_STATEMENTS.url;

      var object =
          await ApiProvider().fetch(url, (map) => UserStatements.fromMap(map));

      return object;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Enrollment>> getEnrollments() async {
    try {
      final url = ApiUrls.ENROLLMENTS.url;

      var list =
          await ApiProvider().fetchList(url, (map) => Enrollment.fromMap(map));
      return list.reversed.toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Enrollment?> getSingleEnrollment(int id) async {
    try {
      final String url = ApiUrls.ENROLLMENTS_single(id).url;

      var object = await ApiProvider().fetch(
        url,
        (map) => Enrollment.fromMap(map),
        saveCache: false,
      );

      return object;
    } catch (e) {
      rethrow;
    }
  }

  Future<Enrollment?> enrollInCourse(int courseId) async {
    try {
      final String url = ApiUrls.ENROLLMENTS.url;

      var response = await ApiProvider().POST(
        url,
        data: <String, dynamic>{"course": courseId},
      );

      if (response != null) {
        if (response.statusCode.toString().startsWith("2")) {
          return Enrollment.fromMap(response.data);
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CompleteLesson>> getCompleteLessons(int id) async {
    try {
      final String url = ApiUrls.ENROLLMENTS_complete_lessons(id).url;

      var list = await ApiProvider().fetchList(
        url,
        (map) => CompleteLesson.fromMap(map),
        saveCache: false,
      );

      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> setLessonAsComplete(
      double result, int courseId, int lessonId) async {
    try {
      final String url = ApiUrls.ENROLLMENTS_complete_lessons(courseId).url;

      var response = await ApiProvider().POST(
        url,
        data: <String, dynamic>{
          "result": result,
          "lesson": lessonId,
        },
      );

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
