import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

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
      var url = ApiUrls.ACCOUNT_PROFILE;

      // 200: returns logged in user data.
      // 401: unauthorized, with "message": Access denied.
      var object = await provider.fetch(
        url,
        (map) => User.fromMap(map),
      );

      return object;
    } catch (e) {
      rethrow;
    }
  }

  static Future<User?> updateProfile(
    User user,
    File? image,
    bool removeImage,
  ) async {
    try {
      var url = ApiUrls.ACCOUNT_PROFILE;

      MultipartFile? imageData;

      if (image != null) {
        imageData = await MultipartFile.fromFile(
          image.path,
          filename: user.id.toString() + p.extension(image.path),
        );
      }

      final response = await provider.PUT(
        url.url,
        data: FormData.fromMap({
          ...user.toMap()
            ..update("imageUrl", (value) => removeImage ? "" : imageData),
        }),
      );

      if (response != null) {
        if (response.statusCode == HttpStatus.ok) {
          return User.fromMap(response.data);
        }
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  static Future<bool> changePassword(
    String? oldPassword,
    String? newPassword,
  ) async {
    try {
      var url = ApiUrls.ACCOUNT_CHANGE_PASSWORD;

      final response = await provider.PUT(
        url.url,
        data: {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        },
      );

      if (response?.statusCode == HttpStatus.ok) {
        return true;
      }
    } catch (e) {
      rethrow;
    }
    return false;
  }

  static Future<Enrollment?> updateLastActivity(int? courseId) async {
    try {
      const Url url = ApiUrls.ACCOUNT_LAST_ACTIVITY;

      var response = await provider.PUT(
        url.url,
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
      const url = ApiUrls.ACCOUNT_LAST_ACTIVITY;

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
      const url = ApiUrls.ACCOUNT_USER_STATEMENTS;

      var object =
          await provider.fetch(url, (map) => UserStatements.fromMap(map));

      return object;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Enrollment>> getEnrollments() async {
    try {
      const url = ApiUrls.ACCOUNT_ENROLLMENTS;

      var list =
          await provider.fetchList(url, (map) => Enrollment.fromMap(map));
      return list.reversed.toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<Enrollment?> getSingleEnrollment(int? courseId) async {
    try {
      final Url url = ApiUrls.ACCOUNT_enrollments_single(courseId);

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
      final Url url = ApiUrls.ACCOUNT_enrollments_lessons(courseId);

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
      const Url url = ApiUrls.ACCOUNT_ENROLLMENTS;

      var response = await provider.POST(
        url.url,
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
      final Url url = ApiUrls.ACCOUNT_enrollments_complete_lessons(id);

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
      final Url url = ApiUrls.ACCOUNT_enrollments_complete_lessons(courseId);

      var response = await provider.POST(
        url.url,
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
      const url = ApiUrls.ACCOUNT_CERTIFICATES;

      var list =
          await provider.fetchList(url, (map) => Certificate.fromMap(map));
      return list;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<CourseBookmark>> getCourseBookmarks() async {
    try {
      const url = ApiUrls.ACCOUNT_COURSE_BOOKMARKS;

      var list =
          await provider.fetchList(url, (map) => CourseBookmark.fromMap(map));
      return list.reversed.toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<CourseBookmark?> getSingleCourseBookmark(int? courseId) async {
    try {
      final Url url = ApiUrls.ACCOUNT_course_bookmarks_single(courseId);

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
      const Url url = ApiUrls.ACCOUNT_COURSE_BOOKMARKS;

      var response = await provider.POST(
        url.url,
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
      final Url url = ApiUrls.ACCOUNT_course_bookmarks_single(courseId);

      var response = await provider.DELETE(
        url.url,
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
      const url = ApiUrls.ACCOUNT_DOCUMENT_BOOKMARKS;

      var list =
          await provider.fetchList(url, (map) => DocumentBookmark.fromMap(map));
      return list.reversed.toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<DocumentBookmark?> getSingleDocumentBookmark(int? docId) async {
    try {
      final Url url = ApiUrls.ACCOUNT_document_bookmarks_single(docId);

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
      const Url url = ApiUrls.ACCOUNT_DOCUMENT_BOOKMARKS;

      var response = await provider.POST(
        url.url,
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
      final Url url = ApiUrls.ACCOUNT_document_bookmarks_single(docId);

      var response = await provider.DELETE(
        url.url,
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
