import 'dart:ui';

class HexColor extends Color {
  HexColor(String hexString) : super(_fromHex(hexString));

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static int _fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return int.tryParse(buffer.toString(), radix: 16) ?? 0xFF000000;
  }
}
