import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../theme/palette.dart';

class NavBarIcon extends StatelessWidget {
  final bool selected;
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const NavBarIcon({
    super.key,
    required this.selected,
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 22.0,
              color: selected ? color : Palette.GRAY,
            ),
            const SizedBox(height: 8.0),
            AutoSizeText(
              title,
              maxLines: 1,
              maxFontSize: 12.0,
              minFontSize: 8.0,
              style: TextStyle(
                color: selected ? color : Palette.GRAY,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
