import 'dart:ui';

class Palette {
  Palette._();

  static const Color BLUE1 = Color(0xFF006FFD);
  static const Color BLUE2 = Color(0xFF552FEA);
  static const Color BABY_BLUE = Color(0xFF4193B7);
  static const Color LIGHT_TEXT_COLOR = Color(0xFFACAFB9);
  static const Color DARK_TEXT_COLOR = Color(0xFF515C6F);
  static const Color DARKER_TEXT_COLOR = Color(0xFF181309);

  static const Color PURPLE = Color(0xFF7B3E9A);
  static const Color YELLOW = Color(0xFFFFB001);
  static const Color GREEN = Color(0xFF23CF57);
  static const Color RED = Color(0xFFFA5151);
  static const Color LIGHT_PINK = Color(0xFFFC8B73);
  static const Color BROWN = Color(0xFFD56824);

  static const Color BACKGROUND = Color(0xFFF5F6FA);

  static const Color WHITE = Color(0xFFFFFFFF);
  static const Color BLACK = Color(0xFF000000);
  static const Color GRAY = Color(0xFFACAFB9);

  static const Color NEARLY_BLACK1 = Color(0xFF2D2D3A);
  static const Color NEARLY_BLACK2 = Color(0xFF181309);

  static const Color ORANGE = Color(0xFFE16E26);
  static const Color LIGHT_TEAL = Color(0xFF49A5CD);
  static const Color DARK_TEAL = Color(0xFF255367);

  static Color get primaryShadow12 => NEARLY_BLACK1.withOpacity(0.5);

  static const List<Color> coursesHomeTabColors = [
    Color(0xFF58276E),
    Color(0xFFAE4BD8),
  ];

  static const List<Color> coursesMyActivityTabColors = [
    Color(0xFF9F1D31),
    Color(0xFFE34C63),
  ];

  static const List<Color> coursesMyCertificatesTabColors = [
    Palette.ORANGE,
    Palette.YELLOW,
  ];

  static const List<Color> coursesMyBookmarksTabColors = [
    Palette.DARK_TEAL,
    Palette.LIGHT_TEAL,
  ];
}
