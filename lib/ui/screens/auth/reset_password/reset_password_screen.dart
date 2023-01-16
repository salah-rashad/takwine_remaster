import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/controllers/account/change_password_controller.dart';
import '../../../../core/controllers/auth/reset_password_controller.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/utils/app_snackbar.dart';
import '../../../../core/helpers/utils/go.dart';
import '../../../theme/palette.dart';
import '../../../theme/themes.dart';
import '../../../widgets/fixed_text_form_field.dart';
import '../../../widgets/gradient_button.dart';
import '../change_password/change_password_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return Theme(
      data: context.theme.copyWith(
          colorScheme:
              context.theme.colorScheme.copyWith(primary: Palette.ORANGE)),
      child: ChangeNotifierProvider(
          create: (context) => ResetPasswordController(),
          builder: (context, _) {
            var ctrl = context.watch<ResetPasswordController>();
            return AutofillGroup(
              child: Form(
                key: ctrl.formKey,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text("إسترجاع كلمة المرور"),
                  ),
                  body: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: size.height - kToolbarHeight),
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            FixedTextFormField(
                              controller: ctrl.emailController,
                              onChanged: (value) =>
                                  ctrl.validateEmail(value.trim()),
                              keyboardType: TextInputType.emailAddress,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(fontFamily: ""),
                              onEditingComplete:
                                  FocusScope.of(context).nextFocus,
                              autofillHints: const [AutofillHints.email],
                              decoration: AppTheme.inputDecoration.copyWith(
                                labelText: "البريد الإلكتروني",
                                labelStyle:
                                    const TextStyle(fontFamily: "GE SS Two"),
                                suffixIcon: ctrl.isEmailValid
                                    ? const Icon(Icons.check_circle,
                                        color: Palette.BROWN, size: 18)
                                    : const Icon(Icons.circle,
                                        color: Palette.GRAY, size: 18),
                                hintTextDirection: TextDirection.ltr,
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (ctrl.isEmailValid) {
                                  return null;
                                } else {
                                  return "البريد الإلكتروني غير صالح.";
                                }
                              },
                            ),
                            const SizedBox(height: 32.0),
                            GradientButton(
                              isLoading: ctrl.isLoading,
                              onTap: () => resetPassword(context, ctrl),
                              leftColor: Palette.ORANGE,
                              rightColor: Palette.ORANGE,
                              child: const Text("المتابعة"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void resetPassword(BuildContext context, ResetPasswordController ctrl) {
    FocusScope.of(context).unfocus();
    ctrl.resetPassword().then((value) {
      Go().toChangePasswordScreen(context);
      // if (value) {
      //   AppSnackbar.success(
      //     message: "تم تغيير كلمة المرور بنجاح.",
      //   );
      //   Navigator.pop(context);
      // }
    });
  }
}
