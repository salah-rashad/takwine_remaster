import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/controllers/documents/documents_controller.dart';
import '../../../core/models/app_tab.dart';
import '../../theme/palette.dart';
import '../tabs_wrapper.dart';
import 'tabs/documents_home_tab_view.dart';
import 'tabs/my_document_bookmarks_tab_view.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabsWrapper<DocumentsController>(
      controller: (context) => DocumentsController(),
      tabs: (controller) {
        return [
          AppTab(
            title: "الرئيسية",
            colors: Palette.coursesHomeTabColors,
            icon: FontAwesomeIcons.house,
            page: (colors) => DocumentsHomeTabView(colors),
            onRefresh: (force) => controller.initHomeTab(force: force),
          ),
          AppTab(
            title: "محفوظاتي",
            colors: Palette.coursesHomeTabColors,
            icon: FontAwesomeIcons.solidBookmark,
            page: (colors) => MyDocumentBookmarksTabView(colors),
            onRefresh: (force) => controller.initBookmarksTab(force: force),
          ),
        ];
      },
    );
  }
}
