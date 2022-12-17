import 'package:flutter/material.dart';

import '../../helpers/utils/change_notifier_helpers.dart';
import '../../models/document_models/document.dart';
import '../../services/api_docs.dart';

class DocumentsSearchController extends ChangeNotifier
    with ChangeNotifierHelpers {
  final TextEditingController textFieldController = TextEditingController();

  // final FocusNode searchFocusNode = new FocusNode();

  String get searchText => textFieldController.text;
  set searchText(String value) => textFieldController.text = value;

  List<Document>? _documents;
  List<Document>? get documents => _documents;
  set documents(List<Document>? value) {
    _documents = value;
    notifyListeners();
  }

  Future<void> updateSearch() async {
    documents = null;
    documents = await ApiDocs.searchDocuments(searchText);
  }
}
