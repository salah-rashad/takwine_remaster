import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/routes/routes.dart';
import '../../screens/auth/login/login_form.dart';
import '../../theme/palette.dart';
import '../gradient_button.dart';

class AuthDialog extends StatelessWidget {
  const AuthDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: false,
      insetPadding: const EdgeInsets.all(32.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
      clipBehavior: Clip.antiAlias,
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            height: 80.0,
            child: const Center(
              child: Text("تسجيل الدخول"),
            ),
          ),
          const Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: LoginForm(isDialog: true),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.RESET_PASSWORD),
              style: TextButton.styleFrom(
                foregroundColor: Palette.DARK_TEXT_COLOR,
              ),
              child: const Text(
                "نسيت كلمة المرور؟",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Palette.BLUE1,
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    "ليس لديك حساب؟",
                    style: TextStyle(color: Palette.WHITE),
                  ),
                  const SizedBox(height: 16.0),
                  GradientButton(
                    onTap: () => Navigator.pushNamed(context, Routes.REGISTER),
                    leftColor: Palette.WHITE,
                    rightColor: Palette.WHITE,
                    radius: 32.0,
                    height: 42.0,
                    width: context.mediaQuery.size.width / 2,
                    child: const Text("إنشاء حساب جديد"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
