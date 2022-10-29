// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import '../../services/api_provider.dart';
import '../utils/cache_manager.dart';

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

class ApiUrls {
  ApiUrls._();
  static const String HOST_URL = "http://192.168.1.9:8000";

  // ~~~~~~~~~~~~~~~~~ AUTH ~~~~~~~~~~~~~~~~~ //

  static const _auth = "$HOST_URL/auth";

  static const LOGIN = Url("$_auth/login");
  static const REGISTER = Url("$_auth/register");
  static const LOGOUT = Url("$_auth/logout");

  // ~~~~~~~~~~~~~~~~~ ACCOUNT ~~~~~~~~~~~~~~~~~ //

  static const _account = "$HOST_URL/account";

  static const PROFILE = Url("$_account/profile");
  static const ENROLLMENTS = Url("$_account/enrollments");
  static const LAST_ACTIVITY = Url("$_account/enrollments/last-activity");
  static const USER_STATEMENTS = Url("$_account/statements");

  /// /account/enrollments/[courseId]
  static Url ENROLLMENTS_single(int courseId) => Url("$ENROLLMENTS/$courseId");

  /// /account/enrollments/[courseId]/complete-lessons
  static Url ENROLLMENTS_complete_lessons(int courseId) =>
      Url("$ENROLLMENTS/$courseId/complete-lessons");

  // ~~~~~~~~~~~~~~~~~ COURSES ~~~~~~~~~~~~~~~~~ //

  static const _courses = "$HOST_URL/api/courses";

  static const COURSES = Url(_courses);
  static const COURSES_FEATURED = Url("$_courses/featured");
  static const COURSE_CATEGORIES = Url("$_courses/categories");

  /// /api/courses/[id]
  static Url COURSES_single(int id) => Url("$_courses/$id");

  /// /api/courses/[id]/lessons
  static Url COURSE_lessons(int id) => Url("$_courses/$id/lessons");

  /// /api/courses/[course]/lessons/[lesson]/materials/[material]
  ///
  /// NOTE: [material] here represents the index of an object
  /// in the lesson materials list, while materials list is orderable.
  static Url COURSE_lesson_material(int course, int lesson, int material) =>
      Url("$_courses/$course/lessons/$lesson/materials/$material");

  /// /api/courses/[course]/lessons/[lesson]/exam
  static Url COURSE_lesson_exam(int course, int lesson) =>
      Url("$_courses/$course/lessons/$lesson/exam");

  /// /api/courses?search=[v]
  static Url COURSES_search(String? v) => Url("$_courses?search=$v");
}

class Url {
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
