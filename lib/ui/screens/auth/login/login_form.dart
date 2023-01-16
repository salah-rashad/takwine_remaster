import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/controllers/auth/auth_controller.dart';
import '../../../../core/controllers/auth/login_controller.dart';
import '../../../theme/palette.dart';
import '../../../theme/themes.dart';
import '../../../widgets/fixed_text_form_field.dart';
import '../../../widgets/gradient_button.dart';

class LoginForm extends StatelessWidget {
  final bool isDialog;
  const LoginForm({
    super.key,
    this.isDialog = false,
  });

  @override
  Widget build(BuildContext context) {
    var ctrl = context.watch<LoginController>();
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FixedTextFormField(
                  controller: ctrl.emailController,
                  onChanged: (value) => ctrl.validateEmail(value.trim()),
                  keyboardType: TextInputType.emailAddress,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(fontFamily: ""),
                  autofillHints: const [AutofillHints.email],
                  onEditingComplete: FocusScope.of(context).nextFocus,
                  decoration: AppTheme.inputDecoration.copyWith(
                    labelText: "البريد الإلكتروني",
                    labelStyle: const TextStyle(fontFamily: "GE SS Two"),
                    suffixIcon: ctrl.isEmailValid
                        ? const Icon(Icons.check_circle,
                            color: Palette.BROWN, size: 18)
                        : const Icon(Icons.circle,
                            color: Palette.GRAY, size: 18),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16.0),
                FixedTextFormField(
                  controller: ctrl.passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(fontFamily: ""),
                  obscureText: !ctrl.passwordRevealed,
                  textDirection: TextDirection.ltr,
                  autofillHints: const [AutofillHints.password],
                  onEditingComplete: FocusScope.of(context).nextFocus,
                  decoration: AppTheme.inputDecoration.copyWith(
                    labelText: "كلمة المرور",
                    labelStyle: const TextStyle(fontFamily: "GE SS Two"),
                    suffixIcon: GestureDetector(
                      onTap: () =>
                          ctrl.passwordRevealed = !ctrl.passwordRevealed,
                      child: ctrl.passwordRevealed
                          ? const Icon(
                              Icons.visibility_off_rounded,
                              color: Palette.GRAY,
                              size: 18,
                            )
                          : const Icon(
                              Icons.visibility_rounded,
                              color: Palette.GRAY,
                              size: 18,
                            ),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          GradientButton(
            isLoading: ctrl.isLoading,
            onTap: () => login(context, ctrl),
            leftColor: Palette.ORANGE,
            rightColor: const Color(0xFFF8AB7B),
            child: const Text("تسجيل الدخول"),
          ),
        ],
      ),
    );
  }

  void login(BuildContext context, LoginController ctrl) {
    FocusScope.of(context).unfocus();
    var auth = context.read<AuthController>();
    ctrl.loginWithEmailPassword(auth).then((value) {
      if (value) {
        if (isDialog) {
          Navigator.pop(context);
        }
      }
    });
  }
}
