import 'package:flutter/material.dart';

import '../theme/palette.dart';
import 'dialogs/auth_dialog.dart';

class LoginRequiredWidget extends StatelessWidget {
  const LoginRequiredWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 32.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "يجب",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Palette.LIGHT_TEXT_COLOR,
                fontSize: 14.0,
              ),
            ),
            TextButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => const AuthDialog(),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
              child: Text(
                "تسجيل الدخول",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Palette.BLUE1.withOpacity(0.5),
                  fontSize: 14.0,
                ),
              ),
            ),
            const Text(
              "أولاً",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Palette.LIGHT_TEXT_COLOR,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
