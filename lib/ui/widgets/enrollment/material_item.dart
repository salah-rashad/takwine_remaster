import 'package:flutter/material.dart';

import '../../../core/models/course_models/material/lesson_material.dart';
import '../custom_html_view.dart';
import '../file_item_view.dart';

class MaterialItem extends StatelessWidget {
  final LessonMaterial material;

  const MaterialItem(this.material, {super.key});

  @override
  Widget build(BuildContext context) {
    var files = material.files;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Text(
          material.title!,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomHtmlView(data: material.content),
        if (files != null && files.isNotEmpty) ...[
          const SizedBox(height: 16.0),
          const Text(
            "المرفقات",
            style: TextStyle(fontSize: 16.0),
          ),
          const Divider(
            thickness: 3,
          ),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: files.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return FileItem(
                files[index],
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
        ]
      ],
    );
  }
}
