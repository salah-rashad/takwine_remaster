// ignore_for_file: non_constant_identifier_names

import '../../services/api_provider.dart';
import '../utils/cache_manager.dart';

class Url {
  static Uri HOST_URI = Uri(scheme: "http", host: "192.168.1.9", port: 8000);
  static const String HOST_URL = "http://192.168.1.9:8000";

  final String url;
  const Url(this.url);

  T? getCache<T, C>(MapConverter<C> convert) {
    return CacheManager.readAndConvert<T, C>(
      url,
      convert,
    );
  }

  @override
  String toString() => url;
}

class ApiUrls {
  ApiUrls._();

  static const String HOST_URL = Url.HOST_URL;

  // ~~~~~~~~~~~~~~~~~ AUTH ~~~~~~~~~~~~~~~~~ //

  static const _auth = "$HOST_URL/api/auth";

  static const AUTH_LOGIN = Url("$_auth/login");
  static const AUTH_REGISTER = Url("$_auth/register");
  static const AUTH_LOGOUT = Url("$_auth/logout");

  // ~~~~~~~~~~~~~~~~~ ACCOUNT ~~~~~~~~~~~~~~~~~ //

  static const _account = "$HOST_URL/api/account";

  static const ACCOUNT_PROFILE = Url("$_account/profile");
  static const ACCOUNT_ENROLLMENTS = Url("$_account/enrollments");
  static const ACCOUNT_LAST_ACTIVITY =
      Url("$_account/enrollments/last-activity");
  static const ACCOUNT_USER_STATEMENTS = Url("$_account/statements");
  static const ACCOUNT_CERTIFICATES = Url("$_account/certificates");
  static const ACCOUNT_COURSE_BOOKMARKS = Url("$_account/course-bookmarks");
  static const ACCOUNT_DOCUMENT_BOOKMARKS = Url("$_account/document-bookmarks");

  /// /account/enrollments/[courseId]
  static Url ACCOUNT_enrollments_single(int? courseId) =>
      Url("$ACCOUNT_ENROLLMENTS/$courseId");

  /// /account/enrollments/[courseId]/lessons
  static Url ACCOUNT_enrollments_lessons(int? courseId) =>
      Url("$ACCOUNT_ENROLLMENTS/$courseId/lessons");

  /// /account/enrollments/[courseId]/complete-lessons
  static Url ACCOUNT_enrollments_complete_lessons(int? courseId) =>
      Url("$ACCOUNT_ENROLLMENTS/$courseId/complete-lessons");

  /// /account/course-bookmarks/[courseId]
  static Url ACCOUNT_course_bookmarks_single(int? courseId) =>
      Url("$ACCOUNT_COURSE_BOOKMARKS/$courseId");

  /// /account/document-bookmarks/[docId]
  static Url ACCOUNT_document_bookmarks_single(int? docId) =>
      Url("$ACCOUNT_DOCUMENT_BOOKMARKS/$docId");
  // ~~~~~~~~~~~~~~~~~ COURSES ~~~~~~~~~~~~~~~~~ //

  static const _courses = "$HOST_URL/api/courses";

  static const COURSES = Url(_courses);
  static const COURSES_FEATURED = Url("$_courses/featured");
  static const COURSES_CATEGORIES = Url("$_courses/categories");

  /// /api/courses?category=[id]
  static Url COURSES_by_category(int? id) => Url("$_courses?category=$id");

  /// /api/courses?search=[v]
  static Url COURSES_search(String? v) => Url("$_courses?search=$v");

  /// /api/courses/[id]
  static Url COURSES_single(int? id) => Url("$_courses/$id");

  /// /api/courses/[id]/lessons
  static Url COURSES_lessons(int? id) => Url("$_courses/$id/lessons");

  /// /api/courses/[course]/lessons/[lesson]/materials/[material]
  ///
  /// NOTE: [material] here represents the index of an object
  /// in the lesson materials list, while materials list is orderable.
  static Url COURSES_lesson_material(int? course, int? lesson, int? material) =>
      Url("$_courses/$course/lessons/$lesson/materials/$material");

  /// /api/courses/[course]/lessons/[lesson]/exam
  static Url COURSES_lesson_exam(int? course, int? lesson) =>
      Url("$_courses/$course/lessons/$lesson/exam");

  // ~~~~~~~~~~~~~~~~~ DOCUMENTS ~~~~~~~~~~~~~~~~~ //

  static const _documents = "$HOST_URL/api/documents";

  static const DOCUMENTS = Url(_documents);
  static const DOCUMENTS_CATEGORIES = Url("$_documents/categories");
  static const DOCUMENTS_FEATURED = Url("$_documents/featured");

  /// /api/documents?category=[id]
  static Url DOCUMENTS_by_category(int? id) => Url("$_documents?category=$id");

  /// /api/documents?search=[v]
  static Url DOCUMENTS_search(String? v) => Url("$_documents?search=$v");
}

class ViewUrls {
  ViewUrls._();

  static const String HOST_URL = Url.HOST_URL;

  static String CERTIFICATE(int? id) => "$HOST_URL/certificate/$id";
}


/* enum ApiUrls {
  // ~~~~~~~~~~~~~~~~~ AUTH ~~~~~~~~~~~~~~~~~ //

  LOGIN("$HOST_URL/auth/login"),
  REGISTER("$HOST_URL/auth/register"),
  LOGOUT("$HOST_URL/auth/logout"),

  // ~~~~~~~~~~~~~~~~~ ACCOUNT ~~~~~~~~~~~~~~~~~ //

  PROFILE("$_account/profile"),
  ENROLLMENTS("$_account/enrollments"),
  ENROLLMENTS_LAST_ACTIVITY("$_account/enrollments/last-activity"),

  // ~~~~~~~~~~~~~~~~~ COURSES ~~~~~~~~~~~~~~~~~ //

  COURSES("$_courses"),
  COURSES_FEATURED("$_courses/featured"),
  COURSE_CATEGORIES("$HOST_URL/api/course-categories");

  static const String HOST_URL = "http://192.168.1.9:8000";

  final String url;
  const ApiUrls(this.url);

  T? getCache<T, C>(MapConverter<C> convert, {String suffix = ''}) {
    return CacheManager.readAndConvert<T, C>(
      url + suffix,
      convert,
    );
  }

  @override
  String toString() => url;
} */