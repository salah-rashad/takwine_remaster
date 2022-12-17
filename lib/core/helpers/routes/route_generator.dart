import 'package:flutter/material.dart';
import '../../../ui/screens/courses/courses_search_screen.dart';
import '../../../ui/screens/courses/enrollment/classroom_screen.dart';
import '../../../ui/screens/courses/enrollment/enrollment_lessons_screen.dart';
import '../../../ui/screens/courses/enrollment/exam_result_screen.dart';
import '../../../ui/screens/courses/single_course_screen.dart';
import '../../../ui/screens/documents/documents_screen.dart';
import '../../../ui/screens/documents/documents_search_screen.dart';
import '../../../ui/screens/documents/single_document_screen.dart';
import '../../controllers/courses/courses_search_controller.dart';
import '../../controllers/documents/documents_search_controller.dart';
import '../../models/course_models/course/course.dart';
import '../../models/course_models/enrollment/enrollment.dart';
import '../../models/course_models/lesson/lesson.dart';
import '../../models/document_models/document.dart';
import 'routes.dart';
import '../extensions.dart';
import '../../../ui/screens/app_root.dart';
import '../../../ui/screens/auth/register/register_screen.dart';
import '../../../ui/screens/courses/courses_screen.dart';

class RouteGenerator {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.ROOT:
        return const AppRoot().route(settings);

      //~~~~~~~~~~~~~~~~~~~~~~~~ AUTH ~~~~~~~~~~~~~~~~~~~~~~~~//
      case Routes.REGISTER:
        return const RegisterScreen().route(settings);

      //~~~~~~~~~~~~~~~~~~~~~~~~ COURSES ~~~~~~~~~~~~~~~~~~~~~~~~//
      case Routes.COURSES:
        return const CoursesScreen().route(settings);

      case Routes.SEARCH_COURSES:
        var controller = settings.arguments as CoursesSearchController;
        return CoursesSearchScreen(controller: controller).route(settings);

      case Routes.SINGLE_COURSE:
        var course = settings.arguments as Course;
        return SingleCourseScreen(course: course).route(settings);

      //~~~~~~~~~~~~~~~~~~~~~~~~ ENROLLMENT ~~~~~~~~~~~~~~~~~~~~~~~~//
      case Routes.ENROLLMENT_LESSONS:
        var enrollment = settings.arguments as Enrollment;
        return EnrollmentLessonsScreen(enrollment: enrollment).route(settings);

      case Routes.ENROLLMENT_CLASSROOM:
        var lesson = settings.arguments as Lesson;
        return ClassroomScreen(lesson: lesson).route(settings);

      case Routes.ENROLLMENT_RESULT:
        var args = settings.arguments as List;
        var lesson = args[0] as Lesson;
        var result = args[1] as double;
        return ExamResultScreen(lesson: lesson, result: result).route(settings);

      //~~~~~~~~~~~~~~~~~~~~~~~~ DOCUMENTS ~~~~~~~~~~~~~~~~~~~~~~~~//
      case Routes.DOCUMENTS:
        return const DocumentsScreen().route(settings);

      case Routes.SEARCH_DOCUMENTS:
        var controller = settings.arguments as DocumentsSearchController;
        return DocumentsSearchScreen(controller: controller).route(settings);

      case Routes.SINGLE_DOCUMENT:
        var document = settings.arguments as Document;
        return SingleDocumentScreen(document: document).route(settings);

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
