// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/controllers/courses/courses_search_controller.dart';
import '../../theme/palette.dart';
import '../../widgets/course/course_item_compact.dart';
import '../../widgets/fixed_text_form_field.dart';
import '../../widgets/shimmers/course_item_compact_shimmer.dart';

class CoursesSearchScreen extends StatelessWidget {
  final CoursesSearchController controller;
  const CoursesSearchScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      builder: (context, _) {
        context.watch<CoursesSearchController>();
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 22.0),
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
                            "بحث الدورات",
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
                        // textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Palette.DARK_TEXT_COLOR,
                          fontSize: 14.0,
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
                          suffixIcon: Material(
                            type: MaterialType.transparency,
                            clipBehavior: Clip.antiAlias,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                            ),
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
                        cursorColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    var courses = controller.courses;
                    if (courses != null) {
                      if (courses.isNotEmpty) {
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          shrinkWrap: true,
                          itemCount: controller.courses!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CourseItemCompact(courses[index]);
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
                          return const CourseItemCompactShimmer();
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
