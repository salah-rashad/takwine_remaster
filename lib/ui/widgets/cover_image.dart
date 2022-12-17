import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/palette.dart';

class CoverImage extends CachedNetworkImage {
  final String? url;

  CoverImage({
    super.key,
    required this.url,
    super.alignment,
    super.cacheKey,
    super.cacheManager,
    super.color,
    super.colorBlendMode,
    super.fadeInCurve,
    super.fadeInDuration,
    super.fadeOutCurve,
    super.fadeOutDuration,
    super.filterQuality,
    super.fit = BoxFit.cover,
    super.height,
    super.httpHeaders,
    super.imageBuilder,
    super.imageRenderMethodForWeb,
    super.matchTextDirection,
    super.maxHeightDiskCache,
    super.maxWidthDiskCache,
    super.memCacheHeight,
    super.memCacheWidth,
    super.placeholder,
    super.placeholderFadeInDuration,
    super.progressIndicatorBuilder,
    super.repeat,
    super.useOldImageOnUrlChange,
    super.width,
  }) : super(imageUrl: url ?? "");

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return placeholder?.call(context, imageUrl) ??
          imagePlaceholder(context, imageUrl);
    } else {
      return super.build(context);
    }
  }

  @override
  PlaceholderWidgetBuilder? get placeholder =>
      super.placeholder ?? imagePlaceholder;
  @override
  LoadingErrorWidgetBuilder? get errorWidget => (context, url, error) =>
      super.placeholder?.call(context, url) ??
      imagePlaceholder(context, url, error);

  Widget imagePlaceholder(BuildContext context, String? url, [dynamic error]) {
    return Container(
      color: Palette.WHITE.withOpacity(0.7),
    );
  }
}
