import 'package:flutter/material.dart';

class AppTab {
  final String title;
  final IconData icon;
  final List<Color> colors;
  final Widget Function(List<Color> colors) page;
  final Future<void> Function(bool force) onRefresh;

  const AppTab({
    required this.title,
    required this.icon,
    required this.colors,
    required this.page,
    required this.onRefresh,
  });
}
