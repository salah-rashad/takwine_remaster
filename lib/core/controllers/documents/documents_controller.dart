import '../../helpers/constants/urls.dart';
import '../../models/document_models/document.dart';
import '../../models/document_models/document_bookmark.dart';
import '../../models/document_models/document_category.dart';
import '../../models/takwine_file.dart';
import '../../services/api_account.dart';
import '../../services/api_docs.dart';
import '../tabs_controller.dart';

class DocumentsController extends TabsController {
  DocumentsController() {
    initialize();
  }

  Set<int> initializedTabs = {};

  DocumentCategory? _selectedCategory;
  DocumentCategory? get selectedCategory => _selectedCategory;

  List<DocumentCategory>? _categories;
  List<Document>? _documentsByCategory;
  List<TakwineFile>? _featuredFiles;

  List<DocumentBookmark>? _bookmarks;

  List<DocumentCategory>? get categories => _categories;
  set categories(List<DocumentCategory>? value) {
    _categories = value;
    notifyListeners();
  }

  List<Document>? get documentsByCategory => _documentsByCategory;
  set documentsByCategory(List<Document>? value) {
    _documentsByCategory = value;
    notifyListeners();
  }

  List<TakwineFile>? get featuredFiles => _featuredFiles;
  set featuredFiles(List<TakwineFile>? value) {
    _featuredFiles = value;
    notifyListeners();
  }

  List<DocumentBookmark>? get bookmarks => _bookmarks;
  set bookmarks(List<DocumentBookmark>? value) {
    _bookmarks = value;
    notifyListeners();
  }

  Future<void> initialize() async {
    // load cached data
    // home page
    categories = ApiUrls.DOCUMENTS_CATEGORIES
        .getCache((map) => DocumentCategory.fromMap(map));

    if (categories != null) {
      if (categories!.isNotEmpty) {
        _selectedCategory = categories?[0];
        documentsByCategory = ApiUrls.DOCUMENTS_by_category(categories?[0].id)
            .getCache((map) => Document.fromMap(map));
      }
    }
    documentsByCategory ??= [];

    featuredFiles =
        ApiUrls.DOCUMENTS_FEATURED.getCache((map) => TakwineFile.fromMap(map));

    // bookmarks page
    bookmarks = ApiUrls.ACCOUNT_DOCUMENT_BOOKMARKS
        .getCache((map) => DocumentBookmark.fromMap(map));

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
      // featuredCourses = await ApiCourses.getFeaturedCourses();
      categories = await ApiDocs.getAllDocumentCategories();

      if (categories != null) {
        if (categories!.isNotEmpty) {
          _selectedCategory = categories?[0];
          documentsByCategory =
              await ApiDocs.getDocumentsByCategory(categories?[0].id);
        }
      }

      featuredFiles = await ApiDocs.getFeaturedFiles();
    }
  }

  Future<void> initBookmarksTab({force = false}) async {
    if (canUpdate(1, force)) {
      bookmarks = await ApiAccount.getDocumentBookmarks();
    }
  }

  Future<void> setSelectedCategory(DocumentCategory category) async {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    documentsByCategory = null;
    documentsByCategory = ApiUrls.DOCUMENTS_by_category(category.id)
        .getCache((map) => Document.fromMap(map));
    documentsByCategory = await ApiDocs.getDocumentsByCategory(category.id);
  }
}
