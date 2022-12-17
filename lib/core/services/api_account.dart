import 'dart:io';

import 'package:flutter/foundation.dart';

import '../helpers/constants/urls.dart';
import '../models/course_models/course_bookmark.dart';
import '../models/course_models/enrollment/certificate.dart';
import '../models/course_models/enrollment/complete_lesson.dart';
import '../models/course_models/enrollment/enrollment.dart';
import '../models/course_models/lesson/lesson.dart';
import '../models/document_models/document_bookmark.dart';
import '../models/user_models/user.dart';
import '../models/user_models/user_statements.dart';
import 'api_provider.dart';

class ApiAccount {
  ApiAccount._();
  static final ApiAccount _instance = ApiAccount._();
  factory ApiAccount() {
    return _instance;
  }

  static ApiProvider provider = ApiProvider();

  static Future<User?> getProfile() async {
    try {
      String url = ApiUrls.ACCOUNT_PROFILE.url;

      // 200: returns logged in user data.
      // 401: unauthorized, with "message": Access denied.
      var object = await provider.fetch(url, (map) => User.fromMap(map),
          saveCache: false);

      return object;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Enrollment?> updateLastActivity(int? courseId) async {
    try {
      final String url = ApiUrls.ACCOUNT_LAST_ACTIVITY.url;

      var response = await provider.POST(
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

  static Future<Enrollment?> getLastActivity() async {
    try {
      final url = ApiUrls.ACCOUNT_LAST_ACTIVITY.url;

      var object = await provider.fetch(
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

  static Future<UserStatements?> getUserStatements() async {
    try {
      final url = ApiUrls.ACCOUNT_USER_STATEMENTS.url;

      var object =
          await provider.fetch(url, (map) => UserStatements.fromMap(map));

      return object;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Enrollment>> getEnrollments() async {
    try {
      final url = ApiUrls.ACCOUNT_ENROLLMENTS.url;

      var list =
          await provider.fetchList(url, (map) => Enrollment.fromMap(map));
      return list.reversed.toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<Enrollment?> getSingleEnrollment(int? courseId) async {
    try {
      final String url = ApiUrls.ACCOUNT_enrollments_single(courseId).url;

      var object = await provider.fetch(
        url,
        (map) => Enrollment.fromMap(map),
        saveCache: false,
      );

      return object;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Lesson>> getEnrollmentLessons(int? courseId) async {
    try {
      final String url = ApiUrls.ACCOUNT_enrollments_lessons(courseId).url;

      var list = await provider.fetchList(
        url,
        (map) => Lesson.fromMap(map),
        saveCache: false,
      );

      return list;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Enrollment?> enrollInCourse(int? courseId) async {
    try {
      final String url = ApiUrls.ACCOUNT_ENROLLMENTS.url;

      var response = await provider.POST(
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

  static Future<List<CompleteLesson>> getCompleteLessons(int? id) async {
    try {
      final String url = ApiUrls.ACCOUNT_enrollments_complete_lessons(id).url;

      var list = await provider.fetchList(
        url,
        (map) => CompleteLesson.fromMap(map),
        saveCache: false,
      );

      return list;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> setLessonAsComplete(
    double? result,
    int? courseId,
    int? lessonId,
  ) async {
    try {
      final String url =
          ApiUrls.ACCOUNT_enrollments_complete_lessons(courseId).url;

      var response = await provider.POST(
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

  static Future<List<Certificate>> getCertificates() async {
    try {
      final url = ApiUrls.ACCOUNT_CERTIFICATES.url;

      var list =
          await provider.fetchList(url, (map) => Certificate.fromMap(map));
      return list;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<CourseBookmark>> getCourseBookmarks() async {
    try {
      final url = ApiUrls.ACCOUNT_COURSE_BOOKMARKS.url;

      var list =
          await provider.fetchList(url, (map) => CourseBookmark.fromMap(map));
      return list.reversed.toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<CourseBookmark?> getSingleCourseBookmark(int? courseId) async {
    try {
      final String url = ApiUrls.ACCOUNT_course_bookmarks_single(courseId).url;

      var object = await provider.fetch(
        url,
        (map) => CourseBookmark.fromMap(map),
        saveCache: false,
      );

      return object;
    } catch (e) {
      rethrow;
    }
  }

  static Future<CourseBookmark?> addCourseBookmark(int? courseId) async {
    try {
      final String url = ApiUrls.ACCOUNT_COURSE_BOOKMARKS.url;

      var response = await provider.POST(
        url,
        data: <String, dynamic>{
          "course": courseId,
        },
      );

      if (response != null) {
        if (response.statusCode.toString().startsWith("2")) {
          return CourseBookmark.fromMap(response.data);
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> removeCourseBookmark(int? courseId) async {
    try {
      final String url = ApiUrls.ACCOUNT_course_bookmarks_single(courseId).url;

      var response = await provider.DELETE(
        url,
        data: <String, dynamic>{
          "course": courseId,
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

  static Future<List<DocumentBookmark>> getDocumentBookmarks() async {
    try {
      final url = ApiUrls.ACCOUNT_DOCUMENT_BOOKMARKS.url;

      var list =
          await provider.fetchList(url, (map) => DocumentBookmark.fromMap(map));
      return list.reversed.toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<DocumentBookmark?> getSingleDocumentBookmark(int? docId) async {
    try {
      final String url = ApiUrls.ACCOUNT_document_bookmarks_single(docId).url;

      var object = await provider.fetch(
        url,
        (map) => DocumentBookmark.fromMap(map),
        saveCache: false,
      );

      return object;
    } catch (e) {
      rethrow;
    }
  }

  static Future<DocumentBookmark?> addDocumentBookmark(int? docId) async {
    try {
      final String url = ApiUrls.ACCOUNT_DOCUMENT_BOOKMARKS.url;

      var response = await provider.POST(
        url,
        data: <String, dynamic>{
          "document": docId,
        },
      );

      if (response != null) {
        if (response.statusCode.toString().startsWith("2")) {
          return DocumentBookmark.fromMap(response.data);
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> removeDocumentBookmark(int? docId) async {
    try {
      final String url = ApiUrls.ACCOUNT_document_bookmarks_single(docId).url;

      var response = await provider.DELETE(
        url,
        data: <String, dynamic>{
          "document": docId,
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
