import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../screens/auth/login/login_form.dart';
import '../../theme/palette.dart';
import '../gradient_button.dart';

class AuthDialog extends StatefulWidget {
  const AuthDialog({super.key});

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  bool _isLogin = true;

  void switchDialog() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
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
            child: Center(
              child: Text(_isLogin ? "تسجيل الدخول" : "إنشاء حساب جديد"),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: _isLogin
                  ? const LoginForm(isDialog: true)
                  : /* RegisterForm(isDialog: true) */
                  const Center(
                      child: Text("Register"),
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
                  Text(
                    _isLogin ? "ليس لديك حساب؟" : "هل انت متسجل؟",
                    style: const TextStyle(color: Palette.WHITE),
                  ),
                  const SizedBox(height: 16.0),
                  GradientButton(
                    onTap: switchDialog,
                    leftColor: Palette.WHITE,
                    rightColor: Palette.WHITE,
                    radius: 32.0,
                    height: 42.0,
                    width: context.mediaQuery.size.width / 2,
                    splashColor: Palette.BLACK.withOpacity(0.16),
                    child: Text(
                      _isLogin ? "إنشاء حساب جديد" : "تسجيل الدخول",
                      style: const TextStyle(color: Palette.BLACK),
                    ),
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
