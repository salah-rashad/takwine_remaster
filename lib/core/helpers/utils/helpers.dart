// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../ui/theme/palette.dart';

const String YT_Pattern = "com/watch?v=";
const String YT_PatternEmbed = "youtube.com/embed/";

Future<void> launchURL(
  String url, {
  LaunchMode mode = LaunchMode.externalApplication,
}) async {
  var videoId = YoutubePlayer.convertUrlToId(url);
  if (videoId != null) {
    var YT_URL = 'https://www.youtube.com/watch?v=$videoId';
    var YT_APP_URL = 'youtube://www.youtube.com/watch?v=$videoId';

    if (Platform.isIOS) {
      if (await canLaunchUrlString(YT_APP_URL)) {
        await launchUrlString(YT_APP_URL, mode: mode);
      } else {
        if (await canLaunchUrlString(YT_URL)) {
          await launchUrlString(YT_URL, mode: mode);
        } else {
          throw 'Could not launch $YT_URL';
        }
      }
    } else {
      if (await canLaunchUrlString(YT_URL)) {
        await launchUrlString(YT_URL, mode: mode);
      } else {
        throw 'Could not launch $YT_URL';
      }
    }
  } else {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: mode);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// String? getYoutubeIdFromUrl(String url) {
//   if (url.contains(YT_Pattern)) {
//     return url.split(YT_Pattern)[1];
//   } else if (url.contains(YT_PatternEmbed)) {
//     return url.split(YT_PatternEmbed)[1];
//   }
//   return null;
// }

String formatDate(String date) {
  try {
    return intl.DateFormat("d MMM yyyy", "ar_SA").format(DateTime.parse(date));
  } catch (e) {
    return date;
  }
}

Color getFontColorForBackground(Color background) {
  return (background.computeLuminance() > 0.5)
      ? Palette.NEARLY_BLACK1
      : Colors.white;
}

/// Calculate dominant color from ImageProvider
// Future<Color?> getMainColorFromImage(ImageProvider imageProvider) async {
//   final PaletteGenerator paletteGenerator =
//       await PaletteGenerator.fromImageProvider(imageProvider);
//   return paletteGenerator.dominantColor?.color;
// }

double calculateReadingTimeFromHtml(String html) {
  const WPM = 233;
  const WORD_LENGTH = 5;

  // removing html tags and keeping text only
  RegExp regExp1 = RegExp(
    "(<[^>]+>)+",
    caseSensitive: true,
    multiLine: true,
  );

  // removing multiple spaces
  RegExp regExp2 = RegExp(
    " +",
    caseSensitive: true,
    multiLine: true,
  );

  // applying regex
  String content =
      html.replaceAll(regExp1, " ").replaceAll(regExp2, " ").trim();
  // calculating total words count
  double totalWords = content.length / WORD_LENGTH;

  // calcualting reading time
  return totalWords / WPM;
}

String formatReadingTime(double minutes) {
  int seconds = (minutes * 60).toInt();
  String finalText = "";

  if (minutes >= 1) {
    var m = intl.NumberFormat("#.#").format(minutes);
    finalText = "$m دقيقة";
  } else {
    finalText = "$seconds ثانية";
  }

  return "$finalText قراءة";
}
