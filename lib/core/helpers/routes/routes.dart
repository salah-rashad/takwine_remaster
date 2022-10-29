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
  static const String ENROLLMENT_LESSONS = "enrollment/lessons";
  static const String ENROLLMENT_MATERIALS = "enrollment/lesson/materials";
  static const String ENROLLMENT_RESULT = "enrollment/lesson/result";

  // DOCUMENTS
  static const String DOCUMENTS = "/documents";
}
