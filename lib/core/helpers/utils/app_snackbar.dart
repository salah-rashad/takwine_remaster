import 'dart:math';

import 'package:flutter/material.dart';

import 'go.dart';

class AppSnackbar extends SnackBar {
  // final BuildContext context;

  final String? message;
  final IconData? icon;
  final Color? color;
  final bool _custom;

  //~   Success
  AppSnackbar.success({
    super.key,
    required this.message,
    super.action,
    this.icon = Icons.done_rounded,
  })  : color = Colors.green,
        _custom = false,
        super(content: const SizedBox.shrink()) {
    _show();
  }

  //~   Error
  AppSnackbar.error({
    super.key,
    required this.message,
    super.action,
    this.icon = Icons.error_rounded,
  })  : color = Colors.red,
        _custom = false,
        super(content: const SizedBox.shrink()) {
    _show();
  }

  //~   Warning
  AppSnackbar.warning({
    super.key,
    required this.message,
    super.action,
    this.icon = Icons.warning_rounded,
  })  : color = Colors.amber,
        _custom = false,
        super(content: const SizedBox.shrink()) {
    _show();
  }

  //~   Info
  AppSnackbar.info({
    super.key,
    required this.message,
    super.action,
    this.icon = Icons.info_rounded,
  })  : color = Colors.white,
        _custom = false,
        super(content: const SizedBox.shrink()) {
    _show();
  }

  //~   No Internet
  AppSnackbar.noInternet({
    super.key,
    super.action,
  })  : color = Colors.red,
        message = "لا يوجد اتصال بالانترنت.",
        icon = Icons.wifi_off_rounded,
        _custom = false,
        super(content: const SizedBox.shrink()) {
    _show();
  }

  //~   Custom
  AppSnackbar.custom({
    required super.content,
    super.key,
    super.action,
  })  : color = null,
        message = null,
        icon = null,
        _custom = true,
        super() {
    _show();
  }

  @override
  Widget get content => _custom
      ? super.content
      : Row(
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
    Go().showSnackbar(this);
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
