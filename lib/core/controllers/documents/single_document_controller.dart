import 'package:flutter/material.dart';

import '../../helpers/constants/urls.dart';
import '../../helpers/utils/change_notifier_helpers.dart';
import '../../models/document_models/document.dart';
import '../../models/document_models/document_bookmark.dart';
import '../../services/api_account.dart';

class SingleDocumentController extends ChangeNotifier
    with ChangeNotifierHelpers {
  final Document document;
  SingleDocumentController(this.document) {
    initialize();
  }
  DocumentBookmark? _bookmark;

  DocumentBookmark? get bookmark => _bookmark;
  set bookmark(DocumentBookmark? value) {
    _bookmark = value;
    notifyListeners();
  }

  bool get isBookmarked =>
      bookmark != null && bookmark != DocumentBookmark.empty();

  //*******************//

  Future<void> initialize() async {
    initBookmark();
  }

  void initBookmark() {
    bookmark = ApiUrls.ACCOUNT_document_bookmarks_single(document.id).getCache(
      (map) => DocumentBookmark.fromMap(map),
    );
    ApiAccount.getSingleDocumentBookmark(document.id).then((value) {
      if (value != null) {
        bookmark = value;
      } else {
        bookmark = DocumentBookmark.empty();
      }
    });
  }

  Future<void> toggleBookmark() async {
    final currentValue = bookmark?.copyWith();

    bool shouldRemove = isBookmarked;

    bookmark = null;
    if (shouldRemove) {
      bool success = await ApiAccount.removeDocumentBookmark(document.id);
      if (success) {
        bookmark = DocumentBookmark.empty();
      } else {
        bookmark = currentValue;
      }
    } else {
      bookmark = await ApiAccount.addDocumentBookmark(document.id) ??
          DocumentBookmark.empty();
    }
  }
}
