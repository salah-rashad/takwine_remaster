import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/controllers/account/profile_controller.dart';
import '../../../core/controllers/auth/auth_controller.dart';
import '../../../core/helpers/constants/constants.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/utils/app_snackbar.dart';
import '../../../core/helpers/utils/go.dart';
import '../../../core/models/user_models/user.dart';
import '../../../core/models/user_models/user_gender.dart';
import '../../theme/palette.dart';
import '../../theme/themes.dart';
import '../../widgets/cover_image.dart';
import '../../widgets/fixed_text_form_field.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/user_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  InputDecoration get _topPanelInputDecoration => InputDecoration(
        filled: false,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        alignLabelWithHint: true,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        isDense: true,
      );

  InputDecoration get _bottomPanelInputDecoration =>
      AppTheme.inputDecoration.copyWith(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        alignLabelWithHint: true,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.5),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var auth = context.watch<AuthController>();
    final user = auth.user;

    var size = context.mediaQuery.size;

    return Theme(
      data: context.theme.copyWith(
        colorScheme: const ColorScheme.light(primary: Palette.BLUE2),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Palette.BLUE2,
          selectionColor: Palette.BLUE2.withOpacity(0.5),
          selectionHandleColor: Palette.BLUE2,
        ),
      ),
      child: ChangeNotifierProvider(
        create: (context) => ProfileController(user)..initialize(auth),
        builder: (context, child) {
          var ctrl = context.watch<ProfileController>();

          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () => ctrl.initialize(auth),
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: AutofillGroup(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: size.height + 16.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          topPanel(context, ctrl, auth),
                          content(context, ctrl, user),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 16.0, left: 16.0, right: 16.0),
                            child: GradientButton(
                              isLoading: ctrl.isLoading,
                              onTap: () => saveChanges(context, ctrl, auth),
                              leftColor: Palette.BLUE2,
                              rightColor: Palette.BLUE2,
                              child: const Text("حفظ البيانات"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget topPanel(
      BuildContext context, ProfileController ctrl, AuthController auth) {
    // var size = context.mediaQuery.size;
    final user = auth.user;

    return DefaultTextStyle.merge(
      style: const TextStyle(color: Colors.white),
      child: Theme(
        data: context.theme.copyWith(
          colorScheme: const ColorScheme.light(primary: Palette.WHITE),
          textTheme: context.textTheme.copyWith(
            subtitle1: context.textTheme.subtitle1?.copyWith(
              color: Colors.white,
            ),
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Palette.WHITE,
            selectionColor: Palette.WHITE.withOpacity(0.3),
            selectionHandleColor: Palette.WHITE,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0)),
            color: Palette.BLUE2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // status bar height
                height: MediaQuery.of(context).padding.top + 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 32.0, left: 16.0, bottom: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Expanded(
                      child: Text(
                        "الملف الشخصي",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    ClipOval(
                      child: Material(
                        type: MaterialType.transparency,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                          ),
                          padding: EdgeInsets.zero,
                          color: Palette.WHITE,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: AspectRatio(
                        aspectRatio: 1 / 1.5,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned.fill(
                              child: GestureDetector(
                                onTap: () => ctrl.pickImage(),
                                child: Hero(
                                  tag: "profile-pic-tag",
                                  transitionOnUserGestures: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Container(
                                      color: Palette.GRAY.withOpacity(0.7),
                                      child: profileImage(context, ctrl, user),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (user?.imageUrl != null ||
                                ctrl.imageState != ProfileImageState.none)
                              Positioned(
                                top: -16,
                                right: -16,
                                child: ClipOval(
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: IconButton(
                                      onPressed: () =>
                                          onImageIconButtonPressed(ctrl),
                                      color: ctrl.imageState ==
                                              ProfileImageState.none
                                          ? Palette.GRAY
                                          : Palette.RED,
                                      icon: Icon(
                                        ctrl.imageState ==
                                                ProfileImageState.none
                                            ? Icons
                                                .replay_circle_filled_outlined
                                            : Icons.cancel,
                                        shadows: const [
                                          Shadow(
                                            offset: Offset(-1, 1.5),
                                            color: Colors.black45,
                                            blurRadius: 15,
                                          )
                                        ],
                                      ),
                                      tooltip: ctrl.imageState ==
                                              ProfileImageState.none
                                          ? "الرجوع"
                                          : "إزالة الصورة",
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 32.0,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FixedTextFormField(
                            controller: ctrl.firstNameController,
                            onEditingComplete: FocusScope.of(context).nextFocus,
                            autofillHints: const [AutofillHints.givenName],
                            keyboardType: TextInputType.name,
                            decoration: _topPanelInputDecoration.copyWith(
                              labelText: "الاسم الأول",
                              hintText: user?.first_name,
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          FixedTextFormField(
                            controller: ctrl.lastNameController,
                            onEditingComplete: FocusScope.of(context).nextFocus,
                            autofillHints: const [AutofillHints.familyName],
                            keyboardType: TextInputType.name,
                            decoration: _topPanelInputDecoration.copyWith(
                              labelText: "اسم العائلة",
                              hintText: user?.last_name,
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Go().toChangePasswordScreen(context);
                    },
                    child: const Text("تغيير كلمة المرور"),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      auth.signOut(context).then((result) {
                        if (result == true) {
                          Navigator.pop(context);
                        }
                      });
                    },
                    label: const Text("تسجيل الخروج"),
                    icon: const Icon(
                      Icons.logout_rounded,
                    ),
                    style:
                        OutlinedButton.styleFrom(foregroundColor: Palette.RED),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget content(BuildContext context, ProfileController ctrl, User? user) {
    var size = context.mediaQuery.size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: Column(
        children: [
          FixedTextFormField(
            controller: ctrl.emailController,
            onChanged: (value) => ctrl.validateEmail(value.trim()),
            keyboardType: TextInputType.emailAddress,
            textDirection: TextDirection.ltr,
            style: const TextStyle(fontFamily: ""),
            onEditingComplete: FocusScope.of(context).nextFocus,
            autofillHints: const [AutofillHints.email],
            enabled: false,
            decoration: _bottomPanelInputDecoration.copyWith(
              labelText: "البريد الإلكتروني",
              labelStyle: const TextStyle(fontFamily: "GE SS Two"),
              suffixIcon: ctrl.isEmailValid
                  ? const Icon(Icons.check_circle,
                      color: Palette.BROWN, size: 18)
                  : const Icon(Icons.circle, color: Palette.GRAY, size: 18),
              hintText: user?.email,
              hintTextDirection: TextDirection.ltr,
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 16.0,
          ),
          FixedTextFormField(
            onTap: () => ctrl.pickDate(context),
            controller: ctrl.birthDateController,
            readOnly: true,
            onChanged: (value) {
              FocusScope.of(context).nextFocus();
            },
            decoration: _bottomPanelInputDecoration.copyWith(
              labelText: "تاريخ الميلاد",
              suffixIcon: const Icon(Icons.event),
              hintText: user?.birthDate,
            ),
          ),
          const SizedBox(height: 16.0),
          DropdownButtonFormField<UserGender>(
            value: ctrl.selectedGender ??
                UserGender.from(user?.gender) ??
                UserGender.m,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            decoration: _bottomPanelInputDecoration.copyWith(
              labelText: "الجنس",
              hintText: UserGender.from(user?.gender)?.friendlyName,
            ),
            isExpanded: true,
            onChanged: (UserGender? newValue) {
              ctrl.selectedGender = newValue!;
              FocusScope.of(context).nextFocus();
            },
            items: UserGender.values.map<DropdownMenuItem<UserGender>>((value) {
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
            value: ctrl.selectedCity ??
                cities.firstWhere(
                  (element) => element == user?.city,
                  orElse: () => cities[0],
                ),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            isDense: true,
            isExpanded: true,
            menuMaxHeight: size.height / 2,
            borderRadius: BorderRadius.circular(8.0),
            decoration: _bottomPanelInputDecoration.copyWith(
              labelText: "المدينة",
            ),
            onChanged: (String? newValue) {
              ctrl.selectedCity = newValue!;
              // FocusScope.of(context).nextFocus();
            },
            items: cities.map<DropdownMenuItem<String>>((value) {
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
            decoration: _bottomPanelInputDecoration.copyWith(
              labelText: "المهنة",
              hintText: user?.job,
            ),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  Widget profileImage(
    BuildContext context,
    ProfileController ctrl,
    User? user,
  ) {
    var size = context.mediaQuery.size;

    final imageWidth = size.width / 1.7;

    switch (ctrl.imageState) {
      case ProfileImageState.current:
        return CoverImage(
          url: user?.imageUrl,
          memCacheWidth: imageWidth.toInt(),
        );
      case ProfileImageState.picker:
        if (ctrl.pickedImage != null) {
          return Image.file(
            ctrl.pickedImage!,
            cacheWidth: imageWidth.toInt(),
            fit: BoxFit.cover,
          );
        } else {
          return placeholder(imageWidth);
        }
      case ProfileImageState.none:
        return placeholder(imageWidth);
    }
  }

  Widget placeholder(double width) {
    var padding = const EdgeInsets.only(top: 16.0);
    return UserWidget.placeholderImage(
      padding: padding,
      width: width,
    );
  }

  void saveChanges(
      BuildContext context, ProfileController ctrl, AuthController auth) {
    FocusScope.of(context).unfocus();
    ctrl.saveChanges(auth.user).then((newUser) {
      if (newUser != null) {
        auth.user = newUser;
      } else {
        return;
      }
    });

    AppSnackbar.success(
      message: "تم حفظ تعديلات الملف الشخصي بنجاح.",
    );
  }

  void onImageIconButtonPressed(ProfileController ctrl) {
    switch (ctrl.imageState) {
      case ProfileImageState.none:
        if (ctrl.pickedImage != null) {
          ctrl.imageState = ProfileImageState.picker;
        } else {
          ctrl.imageState = ProfileImageState.current;
        }
        break;
      case ProfileImageState.current:
        ctrl.imageState = ProfileImageState.none;
        break;
      case ProfileImageState.picker:
        ctrl.imageState = ProfileImageState.none;
        ctrl.pickedImage = null;
        break;
    }
  }
}
