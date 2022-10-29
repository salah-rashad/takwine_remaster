// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'go.dart';

/// Generates a cryptographically secure random nonce, to be included in a
/// credential request.
String generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

Future<void> launchURL(String url) async {
  String pattern = "com/watch?v=";
  if (url.contains(pattern)) {
    String videoId = url.split(pattern)[1];

    var YT_URL = 'https://www.youtube.com/watch?v=$videoId';
    var YT_APP_URL = 'youtube://www.youtube.com/watch?v=$videoId';

    if (Platform.isIOS) {
      if (await canLaunchUrlString(YT_APP_URL)) {
        await launchUrlString(YT_APP_URL, mode: LaunchMode.externalApplication);
      } else {
        if (await canLaunchUrlString(YT_URL)) {
          await launchUrlString(YT_URL, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $YT_URL';
        }
      }
    } else {
      if (await canLaunchUrlString(YT_URL)) {
        await launchUrlString(YT_URL, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $YT_URL';
      }
    }
  } else {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}

String convertDateTimeFormat(String date) {
  try {
    return intl.DateFormat("d MMM yyyy", "ar_SA").format(DateTime.parse(date));
  } catch (e) {
    return date;
  }
}

Color getFontColorForBackground(Color background) {
  return (background.computeLuminance() > 0.5) ? Colors.black : Colors.white;
}

T? readProvider<T>() {
  var context = Go().navigatorKey.currentContext;
  if (context != null) {
    return Provider.of<T>(context, listen: false);
  } else {
    return null;
  }
}

T? watchProvider<T>() {
  var context = Go().navigatorKey.currentContext;
  if (context != null) {
    return Provider.of<T>(context, listen: true);
  } else {
    return null;
  }
}
