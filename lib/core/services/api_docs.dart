import '../helpers/constants/urls.dart';
import '../models/document_models/document.dart';
import '../models/document_models/document_category.dart';
import '../models/takwine_file.dart';
import 'api_provider.dart';

class ApiDocs {
  ApiDocs._();
  static final ApiDocs _instance = ApiDocs._();
  factory ApiDocs() {
    return _instance;
  }

  static ApiProvider provider = ApiProvider();

  static Future<List<DocumentCategory>> getAllDocumentCategories() async {
    try {
      const Url url = ApiUrls.DOCUMENTS_CATEGORIES;

      var list =
          await provider.fetchList(url, (map) => DocumentCategory.fromMap(map));

      return list;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Document>> getDocumentsByCategory(int? catId) async {
    try {
      final Url url = ApiUrls.DOCUMENTS_by_category(catId);

      var list = await provider.fetchList(url, (map) => Document.fromMap(map));

      return list;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<TakwineFile>> getFeaturedFiles() async {
    try {
      const Url url = ApiUrls.DOCUMENTS_FEATURED;

      var list =
          await provider.fetchList(url, (map) => TakwineFile.fromMap(map));

      return list;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Document>> searchDocuments(String? value) async {
    try {
      final Url url = ApiUrls.DOCUMENTS_search(value);

      var list = await provider.fetchList(url, (map) => Document.fromMap(map));

      return list;
    } catch (e) {
      rethrow;
    }
  }
}
