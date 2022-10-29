import 'package:flutter/material.dart';

import '../../../../core/helpers/routes/routes.dart';
import '../../../theme/palette.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(
                  maxWidth: 320,
                ),
                child: Image.asset(
                  "assets/images/app_logo.gif",
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(height: 32.0),
              const LoginForm(),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "عضو جديد؟ ",
                    style: TextStyle(
                      color: Palette.DARK_TEXT_COLOR,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, Routes.REGISTER),
                    child: const Text(
                      "تسجل هنا",
                      style: TextStyle(
                        color: Palette.ORANGE,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 32.0),
                ),
              ),
              const Center(
                child: Text(
                  "بإنشائكم لحساب في هذه المنصة توافقون على شروط الاستخدام",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 8.0, color: Palette.DARK_TEXT_COLOR),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
