import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/controllers/auth/auth_controller.dart';
import '../../../core/controllers/documents/single_document_controller.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/utils/helpers.dart';
import '../../../core/models/document_models/document.dart';
import '../../theme/palette.dart';
import '../../widgets/cover_image.dart';
import '../../widgets/custom_html_view.dart';
import '../../widgets/dialogs/auth_dialog.dart';
import '../../widgets/file_item_view.dart';

class SingleDocumentScreen extends StatelessWidget {
  final Document document;
  const SingleDocumentScreen({required this.document, super.key});

  static const List<String> tabs = ["الموضوع", "المرفقات"];

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;

    return ChangeNotifierProvider(
        create: (context) => SingleDocumentController(document),
        builder: (context, _) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        pinned: true,
                        expandedHeight: 200.0,
                        floating: false,
                        snap: false,
                        actions: [
                          Consumer<SingleDocumentController>(
                              builder: (context, controller, _) {
                            return IconButton(
                              onPressed: onBookmarkPressed(context, controller),
                              icon: Icon(
                                controller.isBookmarked
                                    ? Icons.bookmark_added_rounded
                                    : Icons.bookmark_add_outlined,
                                textDirection: TextDirection.ltr,
                              ),
                              style: TextButton.styleFrom(
                                foregroundColor: Palette.WHITE,
                              ),
                              // color: Palette.WHITE,
                            );
                          }),
                        ],
                        title: AutoSizeText(
                          document.title ?? "",
                          maxLines: 2,
                          minFontSize: 14,
                        ),
                        backgroundColor: const Color(0xFF09031E),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            children: [
                              Positioned.fill(
                                child: CoverImage(
                                  url: document.imageUrl,
                                  memCacheWidth: (size.width * 2).toInt(),
                                  placeholder: (context, url, [error]) =>
                                      const SizedBox.shrink(),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  // height: 56 * 2,
                                  // width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Palette.BLACK,
                                        Colors.transparent,
                                        Colors.transparent,
                                        Palette.BLACK.withOpacity(0.5),
                                      ],
                                      stops: const [
                                        0.0,
                                        0.4,
                                        0.8,
                                        1.0,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        bottom: TabBar(
                          padding: EdgeInsets.zero,
                          indicatorColor: Palette.WHITE,
                          isScrollable: true,
                          tabs: tabs.map((name) {
                            return Tab(
                              text: name,
                              // icon: Icon(Icons.subject_rounded),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: tabs.map((name) {
                    var index = tabs.indexOf(name);
                    return SafeArea(
                      top: false,
                      bottom: false,
                      child: Builder(
                        builder: (BuildContext context) {
                          return CustomScrollView(
                            key: PageStorageKey<String>(name),
                            slivers: <Widget>[
                              SliverOverlapInjector(
                                handle: NestedScrollView
                                    .sliverOverlapAbsorberHandleFor(context),
                              ),
                              SliverPadding(
                                padding: const EdgeInsets.all(8.0),
                                sliver: tabView(context, index),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        });
  }

  Widget tabView(BuildContext context, int index) {
    switch (index) {
      case 0:
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle.merge(
                  style: const TextStyle(
                    color: Color(0xFFC2C6E2),
                    // fontWeight: FontWeight.bold,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (document.content != null)
                        Text(
                          formatReadingTime(
                              calculateReadingTimeFromHtml(document.content!)),
                        ),
                      Text(
                        formatDate(document.date ?? ""),
                      ),
                    ],
                  ),
                ),
              ),
              CustomHtmlView(data: document.content),
            ],
          ),
        );
      case 1:
        var filesLength = document.files?.length;
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  FileItem(
                    document.files![index],
                    padding: EdgeInsets.zero,
                  ),
                  if (index + 1 != filesLength)
                    const Divider(
                      thickness: 1,
                      height: 8.0,
                    )
                ],
              );
            },
            childCount: filesLength,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  VoidCallback? onBookmarkPressed(
      BuildContext context, SingleDocumentController controller) {
    var auth = context.watch<AuthController>();
    if (auth.isLoggedIn) {
      if (controller.bookmark == null) {
        return null;
      } else {
        return controller.toggleBookmark;
      }
    } else {
      return () {
        showDialog<bool>(
          context: context,
          builder: (context) => const AuthDialog(),
        ).then((value) => controller.initialize());
      };
    }
  }
}


/* return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.bookmark_add_outlined))
          ],
          backgroundColor: const Color(0xFF09031E),
          bottom: const TabBar(
            padding: EdgeInsets.zero,
            indicatorColor: Palette.WHITE,
            isScrollable: true,
            tabs: [
              Tab(
                text: "الموضوع",
                icon: Icon(Icons.subject_rounded),
              ),
              Tab(
                text: "المرفقات",
                icon: Icon(Icons.attachment),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SingleChildScrollView(
              child: MaterialItem.htmlView(context, document.content),
            ),
            ListView.separated(
              padding: const EdgeInsets.all(16.0),
              shrinkWrap: true,
              itemCount: document.files?.length ?? 0,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return FileItem.fromFile(
                  document.files![index],
                  padding: EdgeInsets.zero,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 1,
                  height: 8.0,
                );
              },
            )
          ],
        ),
      ),
    ); */