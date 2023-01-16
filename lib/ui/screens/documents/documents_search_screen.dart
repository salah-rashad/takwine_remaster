import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/controllers/documents/documents_search_controller.dart';
import '../../theme/palette.dart';
import '../../widgets/documents/document_item_compact.dart';
import '../../widgets/fixed_text_form_field.dart';
import '../../widgets/shimmers/document_item_compact_shimmer.dart';

class DocumentsSearchScreen extends StatelessWidget {
  final DocumentsSearchController controller;
  const DocumentsSearchScreen({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      builder: (context, _) {
        context.watch<DocumentsSearchController>();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Palette.BACKGROUND,
          body: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: Palette.coursesHomeTabColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      // status bar height
                      height: MediaQuery.of(context).padding.top,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back_ios_rounded),
                              padding: const EdgeInsets.all(0.0),
                              color: Palette.WHITE,
                              iconSize: 22.0,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            "بحث الوثائق و المواضيع",
                            style:
                                TextStyle(color: Palette.WHITE, fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 38.0,
                      child: FixedTextFormField(
                        controller: controller.textFieldController,
                        // textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Palette.DARK_TEXT_COLOR,
                          fontSize: 12.0,
                        ),
                        onEditingComplete: () {
                          if (controller.searchText.trim().isNotEmpty) {
                            controller.updateSearch();
                          }
                        },
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          fillColor: Palette.WHITE,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 24.0),
                          hintText: "ابحث هنا عن مواضيع تهمك ...",
                          hintStyle: const TextStyle(
                            color: Color(0xFFACAFB9),
                          ),
                          suffixIcon: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                onPressed: controller.updateSearch,
                                icon: const Icon(
                                  Icons.search_rounded,
                                  color: Palette.BLACK,
                                ),
                                iconSize: 22.0,
                                tooltip: "بحث",
                              ),
                            ),
                          ),
                        ),
                        cursorColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    var documents = controller.documents;
                    if (documents != null) {
                      if (documents.isNotEmpty) {
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          itemCount: controller.documents!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return DocumentItemCompact(documents[index]);
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("لا توجد نتائج للبحث"),
                        );
                      }
                    } else {
                      return ListView.builder(
                        itemCount: 3,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        itemBuilder: (context, index) {
                          return const DocumentItemCompactShimmer();
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
