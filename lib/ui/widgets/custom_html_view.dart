import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:photo_view/photo_view.dart';

import '../../core/helpers/constants/urls.dart';
import '../../core/helpers/utils/helpers.dart';
import '../screens/image_viewer_screen.dart';
import '../theme/palette.dart';

class CustomHtmlView extends Html {
  CustomHtmlView({super.key, String? data}) : super(data: data ?? "");

  @override
  bool get shrinkWrap => true;

  @override
  OnTap? get onLinkTap =>
      (url, context, attributes, element) => launchURL(url ?? "");

  @override
  OnTap? get onAnchorTap =>
      (url, context, attributes, element) => launchURL(url ?? "");

  @override
  Map<String, CustomRender> get customRender {
    return {
      /* "a": (ctx, parsedChild) {
          var href = ctx.tree.attributes['href'];
          var fileType = href?.split(".").last;
  
          if (fileType == "pdf") {
            return FileItem(
              name: ctx.tree.children[0].element?.text,
              url: href,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
            );
          }
        }, */
      "img": (ctx, parsedChild) {
        var url = ctx.tree.attributes['src'] ?? "";
        var uniqueTag = "$url-${DateTime.now()}";

        bool validURL = Uri.parse(url).isAbsolute;

        if (!validURL) {
          url = Url.HOST_URI.replace(path: url).toString();
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                ctx.buildContext,
                MaterialPageRoute(
                  builder: (context) =>
                      ImageViewerScreen(url: url, tag: uniqueTag),
                ),
              );
            },
            child: PhotoView(
              imageProvider: NetworkImage(url),
              tightMode: true,
              disableGestures: true,
              heroAttributes: PhotoViewHeroAttributes(
                tag: uniqueTag,
                transitionOnUserGestures: true,
              ),
            ),
          ),
        );
      },
      "hr": (ctx, parsedChild) => const Divider(thickness: 1.0),
      "blockquote": (ctx, parsedChild) {
        var text = ctx.tree.element?.text;
        var borderColor = const Color(0xFF393D64);
        var backgroundColor = borderColor.withOpacity(0.15);

        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                color: backgroundColor,
                border: Border(
                  right: BorderSide(
                    strokeAlign: StrokeAlign.inside,
                    width: 7.0,
                    color: borderColor,
                  ),
                )),
            child: Text(
              text ?? "",
            ),
          ),
        );
      }
    };
  }

  @override
  Map<String, Style> get style {
    return {
      "*": Style(
        backgroundColor: Colors.transparent,
      ),
      "p": Style(
        color: Palette.NEARLY_BLACK1,
      ),
      "blockquote": Style(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        fontWeight: FontWeight.bold,
      ),
    };
  }
}
