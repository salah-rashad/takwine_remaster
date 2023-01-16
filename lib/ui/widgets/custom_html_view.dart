import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:photo_view/photo_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../core/helpers/constants/urls.dart';
import '../../core/helpers/utils/helpers.dart';
import '../screens/image_viewer_screen.dart';
import '../screens/youtube_video_screen.dart';
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
        var src = ctx.tree.attributes['src'] ?? "";
        var uniqueTag = "$src-${DateTime.now()}";

        bool validURL = Uri.parse(src).isAbsolute;

        if (!validURL) {
          src = Url.HOST_URI.replace(path: src).toString();
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                ctx.buildContext,
                MaterialPageRoute(
                  builder: (context) =>
                      ImageViewerScreen(url: src, tag: uniqueTag),
                ),
              );
            },
            child: PhotoView(
              imageProvider: NetworkImage(src),
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
      },
      "iframe": (ctx, parsedChild) {
        var src = ctx.tree.attributes['src'] ?? "";

        // if this is a youtube video
        var videoId = YoutubePlayer.convertUrlToId(src);
        /* if (vidId != null) {
          var controller = CustomYoutubeController(
            initialVideoId: vidId,
            url: src,
          );

          var getIt = GetIt.instance;

          if (!getIt.isRegistered<CustomYoutubeController>(
              instanceName: vidId)) {
            getIt.registerSingleton(controller, instanceName: vidId);
          }

          controller = getIt.get<CustomYoutubeController>(instanceName: vidId);

          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CustomYoutubePlayer(controller: controller),
          );
        } */

        if (videoId != null) {
          var controller = YoutubePlayerController(initialVideoId: videoId);

          // var getIt = GetIt.instance;

          // if (!getIt.isRegistered<YoutubePlayerController>(
          //     instanceName: videoId)) {
          //   getIt.registerSingleton(controller, instanceName: videoId);
          // }

          // controller =
          //     getIt.get<YoutubePlayerController>(instanceName: videoId);

          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: YoutubePlayer(
              controller: controller,
              bottomActions: [
                IconButton(
                  icon: const Icon(
                    Icons.fullscreen,
                    textDirection: TextDirection.ltr,
                  ),
                  onPressed: () async {
                    // controller.pause();

                    await Navigator.push<YoutubePlayerValue>(
                      ctx.buildContext,
                      MaterialPageRoute(
                        builder: (context) => YoutubeVideoScreen(
                          videoId: videoId,
                        ),
                      ),
                    );

                    // controller.play();
                  },
                  color: Palette.WHITE,
                  tooltip: "تكبير الشاشة",
                ),
                const SizedBox(width: 8.0),
                CurrentPosition(),
                const SizedBox(width: 8.0),
                ProgressBar(
                  isExpanded: true,
                  // colors: CustomYoutubePlayer._progressBarColors,
                ),
                const SizedBox(width: 16.0),
                const PlaybackSpeedButton(
                  icon: Icon(
                    Icons.speed_rounded,
                    color: Palette.WHITE,
                  ),
                ),
              ],
            ),
          );
        }

        return parsedChild;
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
