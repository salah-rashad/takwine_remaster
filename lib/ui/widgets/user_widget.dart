import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/controllers/auth/auth_controller.dart';
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
              ? null
              : showDialog(
                  context: context,
                  builder: (context) => const AuthDialog(),
                ),
          child: CircularBorderedImage(
            imageUrl: auth.user?.imageUrl,
            spaceBetween: 2.0,
            size: 32.0,
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
}
