import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/controllers/auth/auth_controller.dart';
import '../../core/helpers/routes/routes.dart';
import '../theme/palette.dart';
import 'circular_bordered_image.dart';
import 'dialogs/auth_dialog.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = context.watch<AuthController>();
    return Row(
      children: [
        GestureDetector(
          onTap: () => auth.isLoggedIn
              ? Navigator.pushNamed(context, Routes.PROFILE)
              : showDialog(
                  context: context,
                  builder: (context) => const AuthDialog(),
                ),
          child: Hero(
            tag: "profile-pic-tag",
            transitionOnUserGestures: true,
            child: CircularBorderedImage(
              imageUrl: auth.user?.imageUrl,
              size: 32.0,
              placeholder: (context, url) => placeholderImage(
                padding: const EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
                width: 32.0,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
            child: Text(
          "مرحباً ${auth.user?.first_name ?? "بك!"}",
          style: const TextStyle(color: Palette.WHITE, fontSize: 18.0),
        )),
      ],
    );
  }

  static Widget placeholderImage({double? width, EdgeInsetsGeometry? padding}) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Image.asset(
        "assets/images/avatar.png",
        // height: size?.width,
        // width: size?.height,
        cacheWidth: width != null ? (width).toInt() : null,
        fit: BoxFit.cover,
      ),
    );
  }
}
