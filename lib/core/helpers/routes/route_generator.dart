import 'package:flutter/material.dart';
import '../../../ui/screens/courses/courses_search_screen.dart';
import '../../../ui/screens/courses/enrollment/enrollment_lessons_screen.dart';
import '../../../ui/screens/courses/enrollment/enrollment_materials_screen.dart';
import '../../../ui/screens/courses/enrollment/exam_result_screen.dart';
import '../../../ui/screens/courses/single_course_screen.dart';
import '../../controllers/courses/courses_search_controller.dart';
import '../../models/course_models/course/course.dart';
import '../../models/course_models/enrollment/enrollment.dart';
import '../../models/course_models/lesson/lesson.dart';
import 'routes.dart';
import '../extensions.dart';
import '../../../ui/screens/app_root.dart';
import '../../../ui/screens/auth/register_screen.dart';
import '../../../ui/screens/courses/courses_screen.dart';

class RouteGenerator {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.ROOT:
        return const AppRoot().route(settings);

      //* auth
      case Routes.REGISTER:
        return const RegisterScreen().route(settings);

      //* courses
      case Routes.COURSES:
        return const CoursesScreen().route(settings);

      case Routes.SEARCH_COURSES:
        var controller = settings.arguments as CoursesSearchController;
        return CoursesSearchScreen(controller: controller).route(settings);

      case Routes.SINGLE_COURSE:
        var course = settings.arguments as Course;
        return SingleCourseScreen(course: course).route(settings);

      //* enrollment
      case Routes.ENROLLMENT_LESSONS:
        var enrollment = settings.arguments as Enrollment;
        return EnrollmentLessonsScreen(enrollment: enrollment).route(settings);

      case Routes.ENROLLMENT_MATERIALS:
        var lesson = settings.arguments as Lesson;
        return EnrollmentMaterialsScreen(lesson: lesson).route(settings);

      case Routes.ENROLLMENT_RESULT:
        var result = settings.arguments as double;
        return ExamResultScreen(result: result).route(settings);

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
