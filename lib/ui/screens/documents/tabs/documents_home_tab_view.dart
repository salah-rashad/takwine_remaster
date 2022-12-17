import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/controllers/documents/documents_controller.dart';
import '../../../../core/controllers/documents/documents_search_controller.dart';
import '../../../../core/helpers/routes/routes.dart';
import '../../../../core/helpers/utils/go.dart';
import '../../../../core/models/document_models/document.dart';
import '../../../../core/models/document_models/document_category.dart';
import '../../../../core/models/takwine_file.dart';
import '../../../theme/palette.dart';
import '../../../widgets/file_item_view.dart';
import '../../../widgets/documents/document_item.dart';
import '../../../widgets/shimmers/categories_list_shimmer.dart';
import '../../../widgets/shimmers/document_item_shimmer.dart';
import '../../../widgets/shimmers/file_item_shimmer.dart';
import '../../../widgets/user_widget.dart';

class DocumentsHomeTabView extends StatelessWidget {
  final List<Color> colors;
  const DocumentsHomeTabView(this.colors, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // status bar height
                height: MediaQuery.of(context).padding.top,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: UserWidget()),
                  Align(
                    widthFactor: 0.5,
                    child: ClipOval(
                      child: Material(
                        type: MaterialType.transparency,
                        child: IconButton(
                          onPressed: () => Go().backToRoot(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                          ),
                          padding: const EdgeInsets.all(0.0),
                          color: Palette.WHITE,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22.0),
              const Text(
                "عن أي موضوع تبحث اليوم\nفي منصة تكوين؟",
                style: TextStyle(color: Palette.WHITE, fontSize: 18.0),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 38.0,
                child: ChangeNotifierProvider(
                    create: (context) => DocumentsSearchController(),
                    builder: (context, widget) {
                      final searchController =
                          context.read<DocumentsSearchController>();

                      return TextField(
                        controller: searchController.textFieldController,
                        // textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Palette.DARK_TEXT_COLOR,
                          fontSize: 12.0,
                        ),
                        onEditingComplete: () =>
                            search(context, searchController),
                        textInputAction: TextInputAction.search,
                        clipBehavior: Clip.antiAlias,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30.0)),
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
                              color: Colors.white,
                              child: IconButton(
                                onPressed: () =>
                                    search(context, searchController),
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
                      );
                    }),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Selector<DocumentsController, DocumentCategory?>(
            selector: (p0, p1) => p1.selectedCategory,
            builder: (context, selectedCategory, _) {
              return Selector<DocumentsController, List<DocumentCategory>?>(
                selector: (p0, p1) => p1.categories,
                builder: (context, categories, child) {
                  if (categories != null) {
                    if (categories.isNotEmpty) {
                      const height = 42.0;
                      return SizedBox(
                        height: height,
                        child: ListView.separated(
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var category = categories[index];

                            var bgColor = selectedCategory == category
                                ? Palette.PURPLE
                                : Palette.GRAY.withOpacity(0.3);
                            var textColor = selectedCategory == category
                                ? Colors.white
                                : Colors.black;

                            return OutlinedButton(
                              onPressed: () {
                                var controller =
                                    context.read<DocumentsController>();
                                controller.setSelectedCategory(category);
                              },
                              clipBehavior: Clip.antiAlias,
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(80.0, height),
                                backgroundColor: bgColor,
                                foregroundColor: textColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: Text(category.title ?? ""),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 8.0,
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  } else {
                    return const CategoriesListShimmer();
                  }
                },
              );
            }),
        SizedBox(
          height: 180,
          child: Selector<DocumentsController, List<Document>?>(
            selector: (p0, p1) => p1.documentsByCategory,
            builder: (context, documents, child) {
              if (documents != null) {
                if (documents.isNotEmpty) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(16.0),
                    shrinkWrap: true,
                    itemCount: documents.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return DocumentItem(documents[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 16.0,
                      );
                    },
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        "لا يوجد مواضيع متاحة.",
                        style: TextStyle(color: Palette.GRAY),
                      ),
                    ),
                  );
                }
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(16.0),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const DocumentItemShimmer();
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 16.0,
                    );
                  },
                );
              }
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "وثائق وملفات مقترحة",
              style:
                  TextStyle(color: Palette.DARKER_TEXT_COLOR, fontSize: 18.0),
            ),
          ),
        ),
        Selector<DocumentsController, List<TakwineFile>?>(
          selector: (p0, p1) => p1.featuredFiles,
          builder: (context, files, child) {
            if (files != null) {
              if (files.isNotEmpty) {
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: files.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return FileItem(files[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      indent: 16.0,
                      endIndent: 16.0,
                      thickness: 1,
                      height: 8.0,
                    );
                  },
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      "لا يوجد ملفات متاحة.",
                      style: TextStyle(color: Palette.GRAY),
                    ),
                  ),
                );
              }
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return const FileItemShimmer();
                },
              );
            }
          },
        ),
      ],
    );
  }

  Future<void> search(
    BuildContext context,
    DocumentsSearchController controller,
  ) async {
    if (controller.searchText.trim().isNotEmpty) {
      controller.updateSearch();
      FocusScope.of(context).unfocus();
      Navigator.pushNamed(
        context,
        Routes.SEARCH_DOCUMENTS,
        arguments: controller,
      );
    }
  }
}
