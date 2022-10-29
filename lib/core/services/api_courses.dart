import '../helpers/constants/api_urls.dart';
import '../models/course_models/course/course.dart';
import '../models/course_models/exam/exam.dart';
import '../models/course_models/lesson/lesson.dart';
import '../models/course_models/material/lesson_material.dart';
import 'api_provider.dart';

class ApiCourses {
  Future<List<Course>> getAllCourses() async {
    try {
      String url = ApiUrls.COURSES.url;

      var list =
          await ApiProvider().fetchList(url, (map) => Course.fromMap(map));

      return list.reversed.toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Course>> getFeaturedCourses() async {
    try {
      final url = ApiUrls.COURSES_FEATURED.url;

      var list =
          await ApiProvider().fetchList(url, (map) => Course.fromMap(map));

      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Course>> searchCourses(String value) async {
    try {
      final String url = ApiUrls.COURSES_search(value).url;

      var list =
          await ApiProvider().fetchList(url, (map) => Course.fromMap(map));

      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<Course?> getSingleCourse(int id) async {
    try {
      final String url = ApiUrls.COURSES_single(id).url;

      var object = await ApiProvider().fetch(url, (map) => Course.fromMap(map));

      return object;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Lesson>> getLessons(int id) async {
    try {
      final String url = ApiUrls.COURSE_lessons(id).url;

      var list =
          await ApiProvider().fetchList(url, (map) => Lesson.fromMap(map));

      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<Exam?> getLessonExam(int courseId, int lessonId) async {
    try {
      final String url = ApiUrls.COURSE_lesson_exam(courseId, lessonId).url;

      var object = await ApiProvider().fetch(
        url,
        (map) => Exam.fromMap(map),
        saveCache: false,
      );

      return object;
    } catch (e) {
      rethrow;
    }
  }

  Future<LessonMaterial?> getLessonMaterial(
      int course, int lesson, int material) async {
    try {
      final String url =
          ApiUrls.COURSE_lesson_material(course, lesson, material).url;

      var object =
          await ApiProvider().fetch(url, (map) => LessonMaterial.fromMap(map));

      return object;
    } catch (e) {
      rethrow;
    }
  }
}
