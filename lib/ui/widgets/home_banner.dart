import 'package:flutter/material.dart';
import '../../core/helpers/extensions.dart';
import '../theme/palette.dart';

class HomeBanner extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final String subtitle;
  final String imagePath;

  const HomeBanner({
    Key? key,
    this.onTap,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 62.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
              blurRadius: 15.0,
              offset: const Offset(5, 5),
              color: Palette.BLACK.withOpacity(0.35))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              cacheWidth: size.width.toInt(),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Row(
                children: [
                  Image.asset("assets/images/box.png", height: 26.0),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            color: Palette.WHITE, fontSize: 16.0),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                            color: Palette.WHITE, fontSize: 8.0),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  splashColor: Palette.BLACK.withOpacity(0.30),
                  highlightColor: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
