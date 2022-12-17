class Routes {
  Routes._();

  static const String initial = ROOT;

  static const String ROOT = "/";

  // AUTH

  static const String LOGIN = "/auth/login";
  static const String REGISTER = "/auth/register";
  static const String RESET_PASSWORD = "/auth/reset-password";

  // COURSES
  static const String COURSES = "/courses";
  static const String SEARCH_COURSES = "$COURSES/search";
  static const String SINGLE_COURSE = "$COURSES/single-course";

  // COURSE ENROLLMENT
  static const String ENROLLMENT_LESSONS = "$COURSES/enrollment/lessons";
  static const String ENROLLMENT_CLASSROOM =
      "$COURSES/enrollment/lesson/class-room";
  static const String ENROLLMENT_RESULT = "$COURSES/enrollment/lesson/result";

  // DOCUMENTS
  static const String DOCUMENTS = "/documents";
  static const String SEARCH_DOCUMENTS = "$DOCUMENTS/search";
  static const String SINGLE_DOCUMENT = "$DOCUMENTS/single-document";
}
