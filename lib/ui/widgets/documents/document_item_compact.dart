import 'package:flutter/material.dart';

import '../../../core/helpers/constants/font_awesome_icons.dart';
import '../../../core/helpers/routes/routes.dart';
import '../../../core/helpers/utils/helpers.dart';
import '../../../core/helpers/utils/hex_color.dart';
import '../../../core/models/document_models/document.dart';
import '../../theme/palette.dart';
import '../category_chip.dart';
import '../cover_image.dart';

class DocumentItemCompact extends StatelessWidget {
  final Document document;
  const DocumentItemCompact(this.document, {super.key});

  Color get color => HexColor(document.category?.color ?? "");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        color: Palette.WHITE,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            Routes.SINGLE_DOCUMENT,
            arguments: document,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 64,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: CoverImage(
                        url: document.imageUrl,
                        fit: BoxFit.cover,
                        memCacheWidth: 64 * 3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        document.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Palette.DARKER_TEXT_COLOR,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        formatDate(document.date ?? ""),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Palette.GRAY,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      CategoryChip(
                        backgroundColor: color,
                        label: Text((document.category?.title).toString()),
                        avatar: Icon(
                          getFontAwesomeIcon(document.category?.icon),
                          color: getFontColorForBackground(color),
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
