import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/routes/routes.dart';
import '../../../core/models/document_models/document.dart';
import '../../theme/palette.dart';
import '../cover_image.dart';

class DocumentItem extends StatelessWidget {
  final Document document;
  const DocumentItem(this.document, {super.key});

  // Color get color => HexColor(document.category?.color ?? "");

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(12.0),
            child: AspectRatio(
              aspectRatio: 1.1 / 1,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CoverImage(
                      url: document.imageUrl,
                      fit: BoxFit.cover,
                      memCacheWidth: size.width.toInt(),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: Palette.BLACK.withOpacity(0.16),
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.SINGLE_DOCUMENT,
                          arguments: document,
                        ),
                      ),
                    ),
                  ),
                  IgnorePointer(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            (document.title).toString(),
                            maxLines: 3,
                            maxFontSize: 16.0,
                            minFontSize: 14.0,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Palette.WHITE,
                              fontSize: 16.0,
                              shadows: [
                                Shadow(
                                  color: Palette.BLACK,
                                  offset: Offset(0, 1),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // const SizedBox(
        //   height: 8.0,
        // ),
        // AutoSizeText(
        //   (document.title ?? "").trim(),
        //   style: const TextStyle(
        //     color: Palette.DARKER_TEXT_COLOR,
        //   ),
        //   maxLines: 2,
        //   maxFontSize: 14.0,
        //   minFontSize: 12.0,
        //   overflow: TextOverflow.ellipsis,
        // ),
      ],
    );
  }
}
