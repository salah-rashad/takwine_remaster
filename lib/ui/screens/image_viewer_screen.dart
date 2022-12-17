import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerScreen extends StatelessWidget {
  final String? url;
  final String tag;
  const ImageViewerScreen({this.url, required this.tag, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(url ?? ""),
        heroAttributes: PhotoViewHeroAttributes(
          tag: tag,
          transitionOnUserGestures: true,
        ),
      ),
    );
  }
}
