import '../helpers/constants/urls.dart';
import '../models/course_models/course/course.dart';
import '../models/course_models/course/course_category.dart';
import '../models/course_models/exam/exam.dart';
import '../models/course_models/lesson/lesson.dart';
import '../models/course_models/material/lesson_material.dart';
import 'api_provider.dart';

class ApiCourses {
  ApiCourses._();
  static final ApiCourses _instance = ApiCourses._();
  factory ApiCourses() {
    return _instance;
  }

  static ApiProvider provider = ApiProvider();

  // static Future<List<Course>> getAllCourses() async {
  //   try {
  //     String url = ApiUrls.COURSES;

  //     var list = await provider.fetchList(url, (map) => Course.fromMap(map));

  //     return list.reversed.toList();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  static Future<List<Course>> getFeaturedCourses() async {
    try {
      const url = ApiUrls.COURSES_FEATURED;

      var list = await provider.fetchList(url, (map) => Course.fromMap(map));

      return list;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Course>> searchCourses(String? value) async {
    try {
      final Url url = ApiUrls.COURSES_search(value);

      var list = await provider.fetchList(url, (map) => Course.fromMap(map));

      return list;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<CourseCategory>> getAllCourseCategories() async {
    try {
      const Url url = ApiUrls.COURSES_CATEGORIES;

      var list =
          await provider.fetchList(url, (map) => CourseCategory.fromMap(map));

      return list;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Course>> getCoursesByCategory(int? catId) async {
    try {
      final Url url = ApiUrls.COURSES_by_category(catId);

      var list = await provider.fetchList(url, (map) => Course.fromMap(map));

      return list;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Course?> getSingleCourse(int id) async {
    try {
      final Url url = ApiUrls.COURSES_single(id);

      var object = await provider.fetch(url, (map) => Course.fromMap(map));

      return object;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Lesson>> getLessons(int? id) async {
    try {
      final Url url = ApiUrls.COURSES_lessons(id);

      var list = await provider.fetchList(url, (map) => Lesson.fromMap(map));

      return list;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Exam?> getLessonExam(int? courseId, int? lessonId) async {
    try {
      final Url url = ApiUrls.COURSES_lesson_exam(courseId, lessonId);

      var object = await provider.fetch(
        url,
        (map) => Exam.fromMap(map),
        saveCache: false,
      );

      return object;
    } catch (e) {
      rethrow;
    }
  }

  static Future<LessonMaterial?> getLessonMaterial(
      int? course, int? lesson, int? material) async {
    try {
      final Url url = ApiUrls.COURSES_lesson_material(course, lesson, material);

      var object =
          await provider.fetch(url, (map) => LessonMaterial.fromMap(map));

      return object;
    } catch (e) {
      rethrow;
    }
  }
}
