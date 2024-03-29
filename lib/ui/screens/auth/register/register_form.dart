import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/controllers/auth/register_controller.dart';
import '../../../../core/helpers/constants/constants.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/utils/app_snackbar.dart';
import '../../../../core/models/user_models/user_gender.dart';
import '../../../theme/palette.dart';
import '../../../theme/themes.dart';
import '../../../widgets/fixed_text_form_field.dart';
import '../../../widgets/gradient_button.dart';

class RegisterForm extends StatelessWidget {
  final bool isDialog;
  // final BuildContext mContext;
  const RegisterForm({
    super.key,
    this.isDialog = false,
    // required this.mContext,
  });

  @override
  Widget build(BuildContext context) {
    var ctrl = context.watch<RegisterController>();
    var size = context.mediaQuery.size;
    return Form(
      child: AutofillGroup(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: FixedTextFormField(
                    controller: ctrl.firstNameController,
                    onEditingComplete: FocusScope.of(context).nextFocus,
                    autofillHints: const [AutofillHints.givenName],
                    keyboardType: TextInputType.name,
                    decoration: AppTheme.inputDecoration.copyWith(
                      labelText: "الاسم الأول",
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(
                  width: 32.0,
                ),
                Expanded(
                  child: FixedTextFormField(
                    controller: ctrl.lastNameController,
                    onEditingComplete: FocusScope.of(context).nextFocus,
                    autofillHints: const [AutofillHints.familyName],
                    keyboardType: TextInputType.name,
                    decoration: AppTheme.inputDecoration.copyWith(
                      labelText: "اسم العائلة",
                      alignLabelWithHint: true,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            FixedTextFormField(
              controller: ctrl.emailController,
              onChanged: (value) => ctrl.validateEmail(value.trim()),
              keyboardType: TextInputType.emailAddress,
              textDirection: TextDirection.ltr,
              style: const TextStyle(fontFamily: ""),
              onEditingComplete: FocusScope.of(context).nextFocus,
              autofillHints: const [AutofillHints.email],
              decoration: AppTheme.inputDecoration.copyWith(
                labelText: "البريد الإلكتروني",
                alignLabelWithHint: true,
                labelStyle: const TextStyle(fontFamily: "GE SS Two"),
                suffixIcon: ctrl.isEmailValid
                    ? const Icon(Icons.check_circle,
                        color: Palette.BROWN, size: 18)
                    : const Icon(Icons.circle, color: Palette.GRAY, size: 18),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16.0),
            FixedTextFormField(
              controller: ctrl.passwordController,
              keyboardType: TextInputType.visiblePassword,
              style: const TextStyle(fontFamily: ""),
              obscureText: !ctrl.passwordRevealed,
              onEditingComplete: FocusScope.of(context).nextFocus,
              textDirection: TextDirection.ltr,
              decoration: AppTheme.inputDecoration.copyWith(
                labelText: "كلمة المرور",
                alignLabelWithHint: true,
                labelStyle: const TextStyle(fontFamily: "GE SS Two"),
                suffixIcon: GestureDetector(
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
                ),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 16.0,
            ),
            FixedTextFormField(
              onTap: () => ctrl
                  .pickDate(context)
                  .then((value) => FocusScope.of(context).nextFocus()),
              controller: ctrl.birthDateController,
              readOnly: true,
              decoration: AppTheme.inputDecoration.copyWith(
                labelText: "تاريخ الميلاد",
                suffixIcon: const Icon(Icons.event),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<UserGender>(
              value: ctrl.selectedGender,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              decoration: AppTheme.inputDecoration.copyWith(
                labelText: "الجنس",
              ),
              isExpanded: true,
              onChanged: (UserGender? newValue) {
                ctrl.selectedGender = newValue!;
                FocusScope.of(context).nextFocus();
              },
              items: UserGender.values
                  .map<DropdownMenuItem<UserGender>>((UserGender value) {
                return DropdownMenuItem<UserGender>(
                  value: value,
                  child: Text(value.friendlyName),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 16.0,
            ),
            DropdownButtonFormField<String>(
              value: ctrl.selectedCity,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              isDense: true,
              isExpanded: true,
              menuMaxHeight: size.height / 2,
              borderRadius: BorderRadius.circular(8.0),
              decoration: AppTheme.inputDecoration.copyWith(
                labelText: "المدينة",
              ),
              onChanged: (String? newValue) {
                ctrl.selectedCity = newValue!;
                FocusScope.of(context).nextFocus();
              },
              items: cities.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 16.0,
            ),
            FixedTextFormField(
              controller: ctrl.jobController,
              onEditingComplete: FocusScope.of(context).nextFocus,
              autofillHints: const [AutofillHints.jobTitle],
              decoration: AppTheme.inputDecoration.copyWith(
                labelText: "المهنة",
                alignLabelWithHint: true,
              ),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 32.0),
            GradientButton(
              isLoading: ctrl.isLoading,
              onTap: () => register(context, ctrl),
              leftColor: Palette.ORANGE,
              rightColor: const Color(0xFFF8AB7B),
              child: const Text("إنشاء حساب"),
            ),
          ],
        ),
      ),
    );
  }

  void register(BuildContext context, RegisterController ctrl) {
    FocusScope.of(context).unfocus();
    // var auth = context.read<AuthController>();
    ctrl.createAccount().then((value) {
      if (value) {
        Navigator.pop(context);
        AppSnackbar.success(
          message: "تم إنشاء الحساب بنجاح، يمكنك تسجيل الدخول الان.",
        );
      }
    });
  }
}
