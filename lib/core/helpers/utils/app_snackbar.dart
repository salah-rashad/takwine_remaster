import 'dart:math';

import 'package:flutter/material.dart';
import 'go.dart';

class AppSnackbar extends SnackBar {
  // final BuildContext context;

  final String? message;
  final IconData? icon;
  final Color? color;
  final Widget? custom;

  //~   Success
  AppSnackbar.success(/* this.context, */ {
    super.key,
    required this.message,
    super.action,
    this.icon = Icons.done_rounded,
  })  : color = Colors.green,
        custom = null,
        super(
          content: const SizedBox.shrink(),
        ) {
    _show();
  }

  //~   Error
  AppSnackbar.error(/* this.context, */ {
    super.key,
    required this.message,
    super.action,
    this.icon = Icons.error_rounded,
  })  : color = Colors.red,
        custom = null,
        super(
          content: const SizedBox.shrink(),
        ) {
    _show();
  }

  //~   Warning
  AppSnackbar.warning(/* this.context, */ {
    super.key,
    required this.message,
    super.action,
    this.icon = Icons.warning_rounded,
  })  : color = Colors.amber,
        custom = null,
        super(
          content: const SizedBox.shrink(),
        ) {
    _show();
  }

  //~   Info
  AppSnackbar.info(/* this.context, */ {
    super.key,
    required this.message,
    super.action,
    this.icon = Icons.info_rounded,
  })  : color = Colors.white,
        custom = null,
        super(
          content: const SizedBox.shrink(),
        ) {
    _show();
  }

  //~   No Internet
  AppSnackbar.noInternet(/* this.context, */ {
    super.key,
    super.action,
  })  : color = Colors.red,
        message = "لا يوجد اتصال بالانترنت.",
        icon = Icons.wifi_off_rounded,
        custom = null,
        super(
          content: const SizedBox.shrink(),
        ) {
    _show();
  }

  //~   Custom
  AppSnackbar.custom(
    /* this.context, */
    this.custom, {
    super.key,
    super.action,
  })  : color = null,
        message = null,
        icon = null,
        super(
          content: const SizedBox.shrink(),
        ) {
    _show();
  }

  @override
  Widget get content =>
      custom ??
      Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(width: 16.0),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              message ?? "",
              style: TextStyle(
                color: color,
              ),
            ),
          ),
          // const SizedBox(width: 16.0),
          // IconButton(
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).removeCurrentSnackBar();
          //   },
          //   icon: const Icon(Icons.close_rounded),
          // ),
        ],
      );

  @override
  DismissDirection get dismissDirection => DismissDirection.horizontal;

  @override
  Color? get backgroundColor => Colors.grey.shade900;

  @override
  Duration get duration => calculateReadingTime();

  void _show() {
    try {
      var context = Go().context;
      if (context != null) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(this);
      }
    } catch (e) {
      rethrow;
    }
  }

  Duration calculateReadingTime() {
    if (message != null) {
      int length = message!.length;
      int time = max(10000, length * 120);
      return Duration(milliseconds: time);
    } else {
      return const Duration(seconds: 15);
    }
  }
}
