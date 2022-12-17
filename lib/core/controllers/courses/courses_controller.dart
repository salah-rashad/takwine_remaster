import '../../helpers/constants/urls.dart';
import '../../models/course_models/course/course.dart';
import '../../models/course_models/course/course_category.dart';
import '../../models/course_models/course_bookmark.dart';
import '../../models/course_models/enrollment/certificate.dart';
import '../../models/course_models/enrollment/enrollment.dart';
import '../../models/user_models/user_statements.dart';
import '../../services/api_account.dart';
import '../../services/api_courses.dart';
import '../tabs_controller.dart';

class CoursesController extends TabsController {
  CoursesController() {
    initialize();
  }

  Set<int> initializedTabs = {};

  CourseCategory? _selectedCategory;
  CourseCategory? get selectedCategory => _selectedCategory;

  List<Course>? _featuredCourses;
  List<CourseCategory>? _categories;
  List<Course>? _coursesByCategory;

  UserStatements? _statements;
  List<Enrollment>? _enrollments;

  List<Certificate>? _certificates;

  List<CourseBookmark>? _bookmarks;

  List<Course>? get featuredCourses => _featuredCourses;
  set featuredCourses(List<Course>? value) {
    _featuredCourses = value;
    notifyListeners();
  }

  List<CourseCategory>? get categories => _categories;
  set categories(List<CourseCategory>? value) {
    _categories = value;
    notifyListeners();
  }

  List<Course>? get coursesByCategory => _coursesByCategory;
  set coursesByCategory(List<Course>? value) {
    _coursesByCategory = value;
    _coursesByCategory?.sort((a, b) => (b.rate ?? 0).compareTo(a.rate ?? 0));
    notifyListeners();
  }

  UserStatements? get statements => _statements;
  set statements(UserStatements? value) {
    _statements = value;
    notifyListeners();
  }

  List<Enrollment>? get enrollments => _enrollments;
  set enrollments(List<Enrollment>? value) {
    _enrollments = value;
    notifyListeners();
  }

  List<Certificate>? get certificates => _certificates;
  set certificates(List<Certificate>? value) {
    _certificates = value;
    notifyListeners();
  }

  List<CourseBookmark>? get bookmarks => _bookmarks;
  set bookmarks(List<CourseBookmark>? value) {
    _bookmarks = value;
    notifyListeners();
  }

  Future<void> initialize() async {
    // load cached data
    // home page
    featuredCourses =
        ApiUrls.COURSES_FEATURED.getCache((map) => Course.fromMap(map));
    categories = ApiUrls.COURSES_CATEGORIES
        .getCache((map) => CourseCategory.fromMap(map));

    if (categories != null) {
      if (categories!.isNotEmpty) {
        _selectedCategory = categories?[0];
        coursesByCategory = ApiUrls.COURSES_by_category(categories?[0].id)
            .getCache((map) => Course.fromMap(map));
      }
    }
    coursesByCategory ??= [];

    // activity page
    statements = ApiUrls.ACCOUNT_USER_STATEMENTS
        .getCache((map) => UserStatements.fromMap(map));
    enrollments =
        ApiUrls.ACCOUNT_ENROLLMENTS.getCache((map) => Enrollment.fromMap(map));

    // certificates page
    certificates =
        ApiUrls.ACCOUNT_CERTIFICATES.getCache((map) => Enrollment.fromMap(map));

    // bookmarks page
    bookmarks = ApiUrls.ACCOUNT_COURSE_BOOKMARKS
        .getCache((map) => CourseBookmark.fromMap(map));

    await initHomeTab();
  }

  bool canUpdate(int index, bool force) {
    if (!force) {
      if (initializedTabs.contains(index)) return false;
    }
    initializedTabs.add(index);
    return true;
  }

  Future<void> initHomeTab({force = false}) async {
    if (canUpdate(0, force)) {
      featuredCourses = await ApiCourses.getFeaturedCourses();
      categories = await ApiCourses.getAllCourseCategories();

      if (categories != null) {
        if (categories!.isNotEmpty) {
          _selectedCategory = categories?[0];
          coursesByCategory =
              await ApiCourses.getCoursesByCategory(categories?[0].id);
        }
      }
    }
  }

  Future<void> initActivityTab({force = false}) async {
    if (canUpdate(1, force)) {
      statements = await ApiAccount.getUserStatements();
      enrollments = await ApiAccount.getEnrollments();
    }
  }

  Future<void> initCertificatesTab({force = false}) async {
    if (canUpdate(2, force)) {
      certificates = await ApiAccount.getCertificates();
    }
  }

  Future<void> initBookmarksTab({force = false}) async {
    if (canUpdate(3, force)) {
      bookmarks = await ApiAccount.getCourseBookmarks();
    }
  }

  Future<void> setSelectedCategory(CourseCategory category) async {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    coursesByCategory = null;
    coursesByCategory = ApiUrls.COURSES_by_category(category.id)
        .getCache((map) => Course.fromMap(map));
    coursesByCategory = await ApiCourses.getCoursesByCategory(category.id);
  }
}
