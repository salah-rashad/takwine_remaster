import 'package:flutter/material.dart';
import 'palette.dart';

class AppTheme {
  BuildContext context;

  AppTheme(this.context);

  TextTheme get textTheme => Theme.of(context).textTheme;

  static const String FONT_FAMILY = "GE SS Two";

  static ThemeData get _shared => ThemeData(
        fontFamily: FONT_FAMILY,
      );

  //~ Light Theme
  static ThemeData get lightTheme => _shared.copyWith(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Palette.BACKGROUND,
        // elevatedButtonTheme: _elevatedButtonThemeData,
        // inputDecorationTheme: _inputDecorationTheme,
        colorScheme: const ColorScheme.light(
          primary: Palette.PURPLE,
          onPrimary: Palette.WHITE,
          error: Palette.RED,
          onError: Palette.WHITE,
          background: Palette.WHITE,
          onBackground: Palette.NEARLY_BLACK1,
          surface: Palette.GRAY,
          onSurface: Palette.NEARLY_BLACK1,
        ),
      );

  //~ Dark Theme
  // static ThemeData get darkTheme => _shared.copyWith(
  //       brightness: Brightness.dark,
  //       elevatedButtonTheme: _elevatedButtonThemeData,
  //     );

  // static get _elevatedButtonThemeData => ElevatedButtonThemeData(
  //       style: ElevatedButton.styleFrom(
  //         padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
  //         alignment: Alignment.center,
  //         elevation: 10,
  //         shadowColor: Palette.primaryShadow12,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16.0),
  //         ),
  //         textStyle: const TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w600,
  //           fontFamily: FONT_FAMILY,
  //         ),
  //       ),
  //     );

  // static get _inputDecorationTheme => InputDecorationTheme(
  //       filled: true,
  //       fillColor: Palette.COLOR_SURFACE_LIGHT,
  //       contentPadding: const EdgeInsets.all(16.0),
  //       hintStyle: TextStyle(
  //         color: Palette.COLOR_ON_BACKGROUND_LIGHT.withOpacity(0.3),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(20.0),
  //         borderSide: const BorderSide(
  //           color: Palette.COLOR_SURFACE_BORDER_LIGHT,
  //           width: 3,
  //         ),
  //       ),
  //       disabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(20.0),
  //         borderSide: const BorderSide(
  //           color: Palette.COLOR_SURFACE_BORDER_LIGHT,
  //           width: 3,
  //         ),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(20.0),
  //         borderSide: BorderSide(
  //           color: Palette.COLOR_ON_BACKGROUND_LIGHT.withOpacity(0.25),
  //           width: 3,
  //         ),
  //       ),
  //     );
}
