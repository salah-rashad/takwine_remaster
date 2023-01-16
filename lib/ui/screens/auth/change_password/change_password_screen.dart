import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/controllers/account/change_password_controller.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/utils/app_snackbar.dart';
import '../../../theme/palette.dart';
import '../../../theme/themes.dart';
import '../../../widgets/fixed_text_form_field.dart';
import '../../../widgets/gradient_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String? resetToken;
  const ChangePasswordScreen({super.key, this.resetToken});

  Color primaryColor(BuildContext context) => context.theme.colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return ChangeNotifierProvider(
        create: (context) => ChangePasswordController(resetToken: resetToken),
        builder: (context, _) {
          var ctrl = context.watch<ChangePasswordController>();
          return WillPopScope(
            onWillPop: ctrl.onWillPop,
            child: Form(
              key: ctrl.formKey,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("تغيير كلمة المرور"),
                ),
                body: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: size.height - kToolbarHeight),
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16.0),
                          if (resetToken == null) ...[
                            FixedTextFormField(
                              controller: ctrl.oldPasswordController,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(fontFamily: ""),
                              obscureText: !ctrl.passwordRevealed,
                              onEditingComplete:
                                  FocusScope.of(context).nextFocus,
                              textDirection: TextDirection.ltr,
                              decoration: AppTheme.inputDecoration.copyWith(
                                labelText: "كلمة المرور الحالية",
                                labelStyle:
                                    const TextStyle(fontFamily: "GE SS Two"),
                                suffixIcon: revealPasswordWidget(ctrl),
                              ),
                              textInputAction: TextInputAction.next,
                              validator: ctrl.oldPasswordValidator,
                            ),
                            const Divider(
                              height: 32.0,
                              thickness: 1,
                            )
                          ],
                          FixedTextFormField(
                            controller: ctrl.newPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(fontFamily: ""),
                            obscureText: !ctrl.passwordRevealed,
                            onEditingComplete: FocusScope.of(context).nextFocus,
                            textDirection: TextDirection.ltr,
                            decoration: AppTheme.inputDecoration.copyWith(
                              labelText: "كلمة المرور الجديدة",
                              labelStyle:
                                  const TextStyle(fontFamily: "GE SS Two"),
                            ),
                            validator: ctrl.newPasswordValidator,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 8.0),
                          FixedTextFormField(
                            controller: ctrl.newPasswordConfirmController,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(fontFamily: ""),
                            obscureText: !ctrl.passwordRevealed,
                            onEditingComplete: FocusScope.of(context).nextFocus,
                            textDirection: TextDirection.ltr,
                            decoration: AppTheme.inputDecoration.copyWith(
                              labelText: "تأكيد كلمة المرور الجديدة",
                              labelStyle:
                                  const TextStyle(fontFamily: "GE SS Two"),
                            ),
                            validator: ctrl.newPasswordConfirmValidator,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(height: 32.0),
                          GradientButton(
                            isLoading: ctrl.isLoading,
                            onTap: () => changePassword(context, ctrl),
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
        });
  }

  void changePassword(BuildContext context, ChangePasswordController ctrl) {
    FocusScope.of(context).unfocus();
    ctrl.changePassword().then((value) {
      if (value) {
        AppSnackbar.success(
          message: "تم تغيير كلمة المرور بنجاح.",
        );
        Navigator.pop(context);
      }
    });
  }

  Widget revealPasswordWidget(ChangePasswordController ctrl) {
    return GestureDetector(
      onTap: () => ctrl.passwordRevealed = !ctrl.passwordRevealed,
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
    );
  }
}
