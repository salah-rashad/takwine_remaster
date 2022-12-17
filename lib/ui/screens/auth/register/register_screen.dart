import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../theme/palette.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              Container(
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Image.asset(
                  "assets/images/app_logo.gif",
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(height: 32.0),
              const RegisterForm(),
              const SizedBox(height: 16.0),
              const Center(
                child: Text(
                  "أو",
                  style: TextStyle(
                    color: Palette.DARK_TEXT_COLOR,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(text: "لديك حساب بالفعل؟  ", children: [
                      TextSpan(
                        text: "تسجيل الدخول",
                        style: const TextStyle(
                          color: Palette.ORANGE,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pop(context),
                      )
                    ]),
                    style: const TextStyle(
                      color: Palette.DARK_TEXT_COLOR,
                    ),
                  ),
                ],
              ),
              Container(
                constraints: const BoxConstraints(minHeight: 32.0),
              ),
              const Center(
                child: Text(
                  "بإنشائكم لحساب في هذه المنصة توافقون على شروط الاستخدام",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 12.0, color: Palette.DARK_TEXT_COLOR),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
